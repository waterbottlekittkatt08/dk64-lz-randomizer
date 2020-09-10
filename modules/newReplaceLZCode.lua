--[[
	Cases
	> LZ Objects
	> Bonus Barrels/Helm Barrels
	> Boss Door LZs
	> K Rool (Hopefully the map sequence is stored inside RDRAM)
	> Helm Entrance
	> BBlast Entrance (DKhaos)
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

function populateExitPointers()
	local exitArray = dereferencePointer(Mem.exit_array_pointer[version]);
	exit_pointers = {};
	if isRDRAM(exitArray) then
		local numberOfExits = mainmemory.readbyte(Mem.number_of_exits[version]);
		for i = 0, numberOfExits - 1 do
			local exitBase = exitArray + i * 0xA;
			table.insert(exit_pointers, exitBase);
		end
	end
	return exit_pointers
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
				if lz_map == 0x11 and lz_exit == 0 then
				else
					output_data = lzRando(lz_map, lz_exit)
					addToCrashLog(getFullName((lz_map * 256) + lz_exit).." > "..getFullName((output_data[1] * 256) + output_data[2]))
					--print(bizstring.hex(zones[i]).." | "..bizstring.hex(lz_map)..","..bizstring.hex(lz_exit).." > "..bizstring.hex(output_data[1])..","..bizstring.hex(output_data[2]));
					mainmemory.write_u16_be(zones[i] + 0x12, output_data[1]); -- New map
					mainmemory.write_u16_be(zones[i] + 0x14, output_data[2]); -- New Exit
				end
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
			if is_valid_type and lz_map == 0xCB then
				mainmemory.write_u16_be(zones[i] + 0x12, getKRoolDestination(0xCB)); -- New map
			end
		end
	end
	setTempFlag(0xB,5) -- DK Phase Intro, Prevents fake K Rool
	setTempFlag(0xB,0) -- Tiny Phase Intro
	setTempFlag(0x0,0) -- Diddy Help Me
	setTempFlag(0x0,6) -- Lanky Help Me
	setTempFlag(0x1,0) -- Tiny Help Me
	setTempFlag(0x1,7) -- Chunky Help Me

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

krool_rando_happened = false;
function handleKRool()
	if version < 2 then -- Should be <4, need to fix CS fade stuff
		transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
		if transition_speed_value > 0 and not krool_rando_happened then
			current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
			current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
			final_cs_table = {
				{0xCB,13},
				{0xCC,12},
				{0xCD,12},
				{0xCE,12},	
			}
			if current_cmap > 0xCA and current_cmap < 0xD0 then
				for i = 1, #final_cs_table do
					if current_cmap == final_cs_table[i][1] then
						cutscene = mainmemory.read_u16_be(Mem.cs[version]);
						cutsceneActive = mainmemory.readbyte(Mem.cs_active[version]);
						cutscene_type = dereferencePointer(Mem.cutscene_type[version]);
						--if isRDRAM(cutscene_type) then
							if cutscene == final_cs_table[i][2] and cutsceneActive == 1 and cutscene_type == Mem.cutscene_type_map[version] then
								new_phase = getKRoolDestination(current_dmap);
								mainmemory.write_u32_be(Mem.dmap[version], new_phase);
								krool_rando_happened = true;
							end
						--end
					end
				end
			end
		elseif transition_speed_value < 1 then
			krool_rando_happened = false;
		end
	end
end

function onEveryMapLoad()
	set_story = {
		-- Story Flag, Maps this applies to
		{{0x38,5},{0x4, 0x6, 0x7, 0xC, 0xD, 0x21, 0x25}}, -- Japes
		{{0x38,6},{0xE, 0x10, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x26, 0x29}}, -- Aztec
		{{0x38,7},{0x1A, 0x1B, 0x1D, 0x24, 0x6E}}, -- Factory
		{{0x39,0},{0x1E, 0x1F, 0x27, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x31, 0x33, 0x36, 0xB3}}, -- Galleon
		{{0x39,1},{0x30, 0x34, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40, 0x46, 0x47, 0xBC,}}, -- Fungi
		{{0x39,2},{0x48, 0x52, 0x54, 0x55, 0x56, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, 0x62, 0x64, 0xBA, 0xC8}}, -- Caves
		{{0x39,3},{0x57, 0x58, 0x69, 0x6A, 0x6C, 0x70, 0x71, 0x72, 0x97, 0xA3, 0xA4, 0xA6, 0xA7, 0xA8, 0xB7, 0xB9, 0xBB}}, -- Castle
	}
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	for i = 1, #set_story do
		for j = 1, #set_story[i][2] do
			if set_story[i][2][j] == current_cmap then
				setFlag(set_story[i][1][1], set_story[i][1][2])
			end
		end
	end
end

function getDistBetweenPoints(x1,z1,x2,z2)
	return math.sqrt(((x2 - x1) ^ 2) + ((z2 - z1) ^ 2))
end

function determineClosestExit()
	player = getPlayerObject();
	closest_exit = -1;
	smallest_dist = 0;
	if isRDRAM(player) then
		exits = populateExitPointers();
		if #exits > 0 then
			for i = 1, #exits do
				local player_x = mainmemory.readfloat(player + 0x7C, true);
				local player_z = mainmemory.readfloat(player + 0x84, true);
				local exit_x = mainmemory.read_s16_be(exits[i]);
				local exit_z = mainmemory.read_s16_be(exits[i] + 0x4);
				local exit_d = getDistBetweenPoints(player_x,player_z,exit_x,exit_z);
				if closest_exit == -1 then
					smallest_dist = exit_d;
					closest_exit = i - 1;
				elseif smallest_dist > exit_d then
					smallest_dist = exit_d;
					closest_exit = i - 1;
				end
			end
		end
	end
	return closest_exit
end

parent_set = false;
function handleGlobalEntry()
	if version < 2 then -- Should be <4, need to fix CS fade stuff
		mode_value = mainmemory.readbyte(Mem.mode[version]);
		transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
		current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
		current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
		dmapType = mapType(current_dmap);
		cmapType = mapType(current_cmap);
		if mode_value > 5 then -- Not Intro Stuff
			if transition_speed_value > 0 and not parent_set then
				if dmapType == "bonus_maps" or dmapType == "global_maps" then -- Entering Global/Bonus Map
					if cmapType ~= "global_maps" and cmapType ~= "bonus_maps" and cmapType ~= "boss_maps" then -- Not coming from boss/bonus/global map
						mainmemory.write_u16_be(Mem.pmap[version], current_cmap);
						calculated_exit = determineClosestExit();
						mainmemory.writebyte(Mem.pexit[version], calculated_exit);
						print("Set parent details to: "..getFullName((current_cmap * 256) + calculated_exit));
						parent_set = true;
					end
				end
			elseif transition_speed_value < 0 then
				parent_set = false;
			end
		end
	end
end

bblast_set = false;
function handleBBlast()
	if version < 2 then
		transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
		if transition_speed_value > 0 then -- Entering a zone
			cutscene = mainmemory.read_u16_be(Mem.cs[version]);
			cutsceneActive = mainmemory.readbyte(Mem.cs_active[version]);
			cutscene_type = dereferencePointer(Mem.cutscene_type[version]);
			--if isRDRAM(cutscene_type) then
				if cutscene_type == Mem.cutscene_type_kong[version] and cutscene == 38 and cutsceneActive == 1 then
					current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
					bblast_maps = {37,41,54,110,186,187,188};
					dmap_is_bblast = false;
					for i = 1, #bblast_maps do
						if current_dmap == bblast_maps[i] then
							dmap_is_bblast = true;
						end
					end
					if dmap_is_bblast and not bblast_set then
						bblast_set = true;
						current_dexit = mainmemory.read_u32_be(Mem.dexit[version]);
						output_data = lzRando(current_dmap, current_dexit)
						addToCrashLog(getFullName((current_dmap * 256) + current_dexit).." > "..getFullName((output_data[1] * 256) + output_data[2]))
						mainmemory.write_u32_be(Mem.dmap[version], output_data[1]); -- New Map
						mainmemory.write_u32_be(Mem.dexit[version], output_data[2]); -- New Exit
					end
				end
			--end
		elseif transition_speed_value < 0 then
			bblast_set = false
		end
	end
end

function handleHelmEntranceSettings()
	if version < 2 then
		transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
		if transition_speed_value > 0 then -- Entering a zone
			current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
			current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
			if current_cmap == 0xAA and current_dmap == 0x11 then
				mainmemory.write_u32_be(Mem.dexit[version], 3); -- New Exit
				--setTempFlag(0x7,3) -- Roman Numeral Doors
				setTempFlag(0x8,6) -- DK Grate
				setTempFlag(0x8,7) -- Chunky Grate
				setTempFlag(0x9,0) -- Tiny Grate
				setTempFlag(0x9,1) -- Lanky Grate
				if not checkFlag(0x60, 2) then
					mainmemory.writebyte(Mem.cutscene_fade_active[version],1);
					mainmemory.write_u16_be(Mem.cutscene_fade_value[version],2); -- Open Helm Doors
				end
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
	handleGlobalEntry();
	handleBBlast();
	handleHelmEntranceSettings();
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	cmapType = mapType(current_cmap);
	if cmapType == "k_rool" then
		handleKRool();
	end
	transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
	obj_m2_timer_value = mainmemory.read_u32_be(Mem.obj_model2_timer[version]);
	if transition_speed_value < 0 then
		if obj_m2_timer_value == 1 then
			onEveryMapLoad();
			if not zones_changed then
				handleLZObject();
				handleBonusBarrels();
				if current_cmap == 0x2A then -- T&S
					handeBossDoorLZ();
				end
				if current_cmap == 0x22 then -- DK Isles
					handleKRoolFirstLZ();
				end
				zones_changed = true;
			end
		end
	elseif transition_speed_value > 0 then
		zones_changed = false;
	end
end

handleLZObject();
handleBonusBarrels();
if current_cmap == 0x2A then -- T&S
	handeBossDoorLZ();
elseif cmapType == "k_rool" then
	handleKRool();
end
if current_cmap == 0x22 then -- DK Isles
	handleKRoolFirstLZ();
end

event.onframeend(changeZones, "Randomises Zones");