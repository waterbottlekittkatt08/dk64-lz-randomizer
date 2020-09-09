--[[
	Cases
	> LZ Objects
	> Bonus Barrels/Helm Barrels
	> Boss Door LZs
	> K Rool (Hopefully the map sequence is stored inside RDRAM)
	> Helm Entrance
]]--
require "modules.mapAndExitNames";

function getZonePointers()
	local lzptrs = {};
	local loadingZoneArray = dereferencePointer(Mem.loading_zone_array[version]);
	if isRDRAM(loadingZoneArray) then
		local arraySize = mainmemory.read_u16_be(Mem.loading_zone_array_size[version]);
		for i = 0, arraySize - 1 do
			table.insert(lzptrs, loadingZoneArray + (i * 0x3A));
		end
	end
	return lzptrs
end

function getSpawnerCount()
	endpoint_found = false;
	actorSpawner_header = dereferencePointer(Mem.actor_spawner_pointer[version]);
	count = 0;
	nextSpawner = actorSpawner_header;
	if isRDRAM(actorSpawner_header) then
		while not endpoint_found do
			count = count + 1;
			nextSpawner = dereferencePointer(nextSpawner + 0x68);
			if not isRDRAM(nextSpawner) then
				endpoint_found = true;
				return count;
			end
		end
		emu.yield();
	end
end

function populateActorSpawnerPointers()
	local actorSpawnerArray = dereferencePointer(Mem.actor_spawner_pointer[version]);
	object_pointers = {};
	if isRDRAM(actorSpawnerArray) then
		local spawnerCount = getSpawnerCount();
		local nextSpawner = actorSpawnerArray;
		for i = 1, spawnerCount do
			local slotBase = nextSpawner;
			nextSpawner = dereferencePointer(slotBase + 0x68)
			table.insert(object_pointers, slotBase);
		end
	end
	return object_pointers
end


function handleLZObject()
	zones = getZonePointers();
	types_of_loading_zones = {0x9, 0xC, 0xD, 0x10, 0x11};
	if #zones > 0 then
		addToCrashLog("Frame "..emu.framecount().." | ADJUSTED LOADING ZONES WITH THESE SETTINGS")
		lz_found = false;
		for i = 1, #zones do
			is_valid_type = false
			lz_type = mainmemory.read_u16_be(zones[i] + 0x10);
			for j = 1, #types_of_loading_zones do
				if lz_type == types_of_loading_zones[j] then
					is_valid_type = true;
				end 
			end
			if is_valid_type then
				lz_found = true;
				lz_map = mainmemory.read_u16_be(zones[i] + 0x12);
				lz_exit = mainmemory.read_u16_be(zones[i] + 0x14);
				output_data = lzRando(lz_map, lz_exit)
				addToCrashLog(getFullName((lz_map * 256) + lz_exit).." > "..getFullName((output_data[1] * 256) + output_data[2]))
				--print(bizstring.hex(zones[i]).." | "..bizstring.hex(lz_map)..","..bizstring.hex(lz_exit).." > "..bizstring.hex(output_data[1])..","..bizstring.hex(output_data[2]));
				mainmemory.write_u16_be(zones[i] + 0x12, output_data[1]); -- New map
				mainmemory.write_u16_be(zones[i] + 0x14, output_data[2]); -- New Exit
			end
		end
		if not lz_found then
			addToCrashLog("No Loading Zones found")
		end
	end
end

function handleBonusBarrels()
	potential_pointers = populateActorSpawnerPointers();
	if #potential_pointers then
		for i = 1, #potential_pointers do
			actor_type = mainmemory.read_u16_be(potential_pointers[i]);
			if actor_type == 12 or actor_type == 91 then -- Is Helm Barrel (107 - 16) or Bonus Barrel (28 - 16)
				inputMap = mainmemory.read_u32_be(potential_pointers[i] + 0x24);
				outputMap = getBonusDestination(inputMap);
				mainmemory.write_u32_be(potential_pointers[i] + 0x24, outputMap);
			end
		end
	end
end

function handeBossDoorLZ()
	zones = getZonePointers();
	types_of_loading_zones = {0x9, 0xC, 0xD, 0x10, 0x11};
	if #zones > 0 then
		for i = 1, #zones do
			lz_type = mainmemory.read_u16_be(zones[i] + 0x10);
			if lz_type == 0x14 then -- Boss Door LZ
				current_pmap = mainmemory.read_u16_be(Mem.pmap[version]);
				output_data = getBossDestination(current_pmap);
				mainmemory.write_u16_be(zones[i] + 0x10, 0x9); -- Change LZ Type
				mainmemory.write_u16_be(zones[i] + 0x12, output_data); -- New Map
				mainmemory.write_u16_be(zones[i] + 0x14, 0); -- New Exit
			end
		end
	end
end

function handleKRoolFirstLZ()
	zones = getZonePointers();
	types_of_loading_zones = {0x9, 0xC, 0xD, 0x10, 0x11};
	if #zones > 0 then
		for i = 1, #zones do
			is_valid_type = false
			lz_type = mainmemory.read_u16_be(zones[i] + 0x10);
			for j = 1, #types_of_loading_zones do
				if lz_type == types_of_loading_zones[j] then
					is_valid_type = true;
				end 
			end
			lz_map = mainmemory.read_u16_be(zones[i] + 0x12);
			if is_valid_type and lz_map == 0xCA then
				mainmemory.write_u16_be(zones[i] + 0x12, getKRoolDestination(0xCA)); -- New map
			end
		end
	end
end

function handleNoclip()
	if version < 2 then
		mode_value = mainmemory.readbyte(Mem.mode[version]);
		current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
		cmapType = mapType(current_cmap);
		transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
		zipProg = mainmemory.readbyte(Mem.zipper_progress[version]);
		current_prevmap = mainmemory.readbyte(Mem.prev_map[version]);
		prevmapType = mapType(current_prevmap);
		player = getPlayerObject();
		if mode_value > 5 then
			if isRDRAM(player) and cmapType == "regular_maps" then
				has_control = mainmemory.readbyte(player + 0x373); -- Might be 0x37B. Changes on same frame
				movement = mainmemory.readbyte(player + 0x154); -- Might be 0x37B. Changes on same frame
				if transition_speed_value < 0 then
					rando_happened = 0;
					if has_control == 0 and movement ~= 0x42 and prevmapType ~= "bonus_maps" then
						if isRDRAM(player) then
							local value = mainmemory.readbyte(player + 0x144);
							if bit.check(value, 2) then
								value = value - 4;
							end
							if bit.check(value, 3) then
								value = value - 8;
							end
							mainmemory.writebyte(player + 0x144, value);
						end
						if settings.randomiser > 0 then
							setTnSDoorStuff();
						end
					end
					if has_control == 1 or zipProg > 90 then
						if isRDRAM(player) then
							local value = mainmemory.readbyte(player + 0x144);
							if not bit.check(value, 2) then
								value = value + 4;
							end
							if not bit.check(value, 3) then
								value = value + 8;
							end
							mainmemory.writebyte(player + 0x144, value);
						end
					end
				end
			end
		end
	end
end

rando_happened = false;
function handleKRool()
	if version < 2 then -- Should be <4, need to fix CS fade stuff
		mode_value = mainmemory.readbyte(Mem.mode[version]);
		dmapType = mapType(current_dmap);
		cmapType = mapType(current_cmap);
		transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
		zipProg = mainmemory.readbyte(Mem.zipper_progress[version]);
		cutscene = mainmemory.read_u16_be(Mem.cs[version]);
		cutsceneActive = mainmemory.readbyte(Mem.cs_active[version]);
		current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
		current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
		if mode_value > 5 then -- Not Intro Stuff, not bblast
			if transition_speed_value < 0 then
				rando_happened = false;
			end
			if transition_speed_value > 0 then
				if zipProg < 50 and lag == real and not rando_happened then
					if dmapType == "k_rool" and current_cmap ~= 0xD6 and settings.randomiser > 0 then -- 0xD6 = Tiny Shoe
						if current_cmap ~= current_dmap and current_cmap ~= 0xD7 then -- Prevents randomisation when re-attempting rounds
							new_destmap_to_write = getKRoolDestination(current_dmap);
							mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
							rando_happened = true;
						end
					else

					end
				end
			elseif transition_speed_value < 0 and zipProg > 6 and zipProg < 12 and cutsceneActive == 0 and dmapType == "k_rool" and previous_msb_value % 2 == 0 then
				mainmemory.writebyte(Mem.map_state[version], previous_msb_value + 1);
				forcing_a_cutscene = 1;
			elseif transition_speed_value < 0 and zipProg > 0 and zipProg < 9 and cutsceneActive == 1 and cmapType == "k_rool" and (cutscene == k_rool_maps_table[current_cmap - 0xCA][3][1] or cutscene == k_rool_maps_table[current_cmap - 0xCA][3][2])then
				mainmemory.write_u16_be(Mem.cs[version], k_rool_maps_table[current_cmap - 0xCA][2]);
				forcing_a_cutscene = 0;
			elseif transition_speed_value < 0 and zipProg > 6 and zipProg < 12 and cutsceneActive == 1 and cutscene == 25 and current_dmap == 0xCB and previous_msb_value % 2 == 0 then
				mainmemory.writebyte(Mem.map_state[version], previous_msb_value + 1);
				forcing_a_cutscene = 1;
			end
			if transition_speed_value > 0 and dmapType == "k_rool"then
				for i = 1, #k_rool_maps_table do
					if k_rool_maps_table[i][1] == current_dmap then
						mainmemory.writebyte(Mem.character[version], i - 1);
					end
				end
			end
			if transition_speed_value < 0 and cmapType == "k_rool" and cutsceneActive == 1 and forcing_a_cutscene == 1 then
				for i = 1, #k_rool_maps_table do
					if k_rool_maps_table[i][1] == current_cmap then
						mainmemory.write_u16_be(Mem.cs[version], k_rool_maps_table[i][2]);
						previous_kr_round = mainmemory.readbyte(Mem.krool_round[version]);
						mainmemory.writebyte(Mem.krool_round[version], previous_kr_round - 1);
						forcing_a_cutscene = 0;						
					end
				end
			end
			if transition_speed_value < 0 and cmapType == "k_rool" then
				for i = 1, #k_rool_maps_table do
					if k_rool_maps_table[i][1] == current_cmap then
						if k_rool_assortment[1] == i then
							mainmemory.writebyte(Mem.krool_round[version], 1);
						end
					end
				end
			end
		end
	end
end

function handleHelmEntrance()
	zones = getZonePointers();
	types_of_loading_zones = {0x9, 0xC, 0xD, 0x10, 0x11};
	if #zones > 0 then
		for i = 1, #zones do
			is_valid_type = false
			lz_type = mainmemory.read_u16_be(zones[i] + 0x10);
			for j = 1, #types_of_loading_zones do
				if lz_type == types_of_loading_zones[j] then
					is_valid_type = true;
				end 
			end
			lz_map = mainmemory.read_u16_be(zones[i] + 0x12);
			if is_valid_type and lz_map == 0x11 then -- LZ To Helm
				output_data = lzRando(lz_map, lz_exit)
				--print(bizstring.hex(zones[i]).." | "..bizstring.hex(lz_map)..","..bizstring.hex(lz_exit).." > "..bizstring.hex(output_data[1])..","..bizstring.hex(output_data[2]));
				mainmemory.write_u16_be(zones[i] + 0x14, 3); -- From Lever
			end
		end
	end
end

function lzRando(inputMap,inputExit)
	reference = nil;
	lookup_value = (inputMap * 256) + inputExit;

	for i = 1, #regular_map_table do
		if regular_map_table[i] == lookup_value then
			reference = i;
		end
	end
	if reference == nil then
		devPrint("Value maintained as "..toHexString(lookup_value));
		crashLogGen("PERSISTANCE","transition","","due to nil reference");
		return {inputMap, inputExit};
	else
		value_to_lookup = regular_map_assortment[reference];
		new_dmap_code = regular_map_table[value_to_lookup];
		devPrint("Value set to as "..toHexString(new_dmap_code));
		new_exit = new_dmap_code % 256;
		new_map = (new_dmap_code - new_exit) / 256;
		return {new_map, new_exit};
	end
end

zones_changed = false;
function changeZones()
	handleNoclip();
	transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
	obj_m2_timer_value = mainmemory.read_u32_be(Mem.obj_model2_timer[version]);
	if transition_speed_value < 0 and obj_m2_timer_value == 1 and not zones_changed then
		current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
		cmapType = mapType(current_cmap);
		handleLZObject();
		handleBonusBarrels();
		if current_cmap == 0xAA then -- Helm Lobby
			handleHelmEntrance();
		elseif current_cmap == 0x2A then -- T&S
			handeBossDoorLZ();
		elseif cmapType == "k_rool" then
			handleKRool();
		end
		if current_cmap == 0x22 then -- DK Isles
			handleKRoolFirstLZ();
		end
		zones_changed = true;
	elseif transition_speed_value > 0 then
		zones_changed = false;
	end
end

handleLZObject();
handleBonusBarrels();
if current_cmap == 0xAA then -- Helm Lobby
	handleHelmEntrance();
elseif current_cmap == 0x2A then -- T&S
	handeBossDoorLZ();
elseif cmapType == "k_rool" then
	handleKRool();
end
if current_cmap == 0x22 then -- DK Isles
	handleKRoolFirstLZ();
end

event.onframeend(changeZones, "Randomises Zones");