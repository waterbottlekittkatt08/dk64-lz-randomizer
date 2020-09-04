require "modules.mapAndExitNames";

forcing_a_cutscene = 0;
rando_happened = 0;

exception_occurred_bblast = false;
exception_occurred_list = false;
exceptions = {
	-- {destination_map, destination_exit || "ignore", transition_type || "ignore"}
	{38,2,"ignore"},
	{20,"ignore","ignore"},
	{38,1,"ignore"},
};

function randomise()
	if version < 2 then -- Should be <4, need to fix CS fade stuff
		mode_value = mainmemory.readbyte(Mem.mode[version]);
		dmapType = mapType(current_dmap);
		cmapType = mapType(current_cmap);
		ignore = false;
		transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
		zipProg = mainmemory.readbyte(Mem.zipper_progress[version]);
		cutscene = mainmemory.read_u16_be(Mem.cs[version]);
		cutsceneActive = mainmemory.readbyte(Mem.cs_active[version]);
		transition_type = mainmemory.readbyte(Mem.loading_zone_transition_type[version]);
		current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
		current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
		current_pmap = mainmemory.read_u16_be(Mem.pmap[version]);
		current_prevmap = mainmemory.readbyte(Mem.prev_map[version]);
		current_cexit = mainmemory.read_u32_be(Mem.cexit[version]);
		prevmapType = mapType(current_prevmap);
		previous_msb_value = mainmemory.readbyte(Mem.map_state[version]);
		current_dexit = mainmemory.read_u32_be(Mem.dexit[version]);
		player = getPlayerObject();


		if lzr_type == "chain" and transition_speed_value == 1 then
			if cmapType == "baboon_blast" or dmapType == "baboon_blast" then
				ignore = true;
				if not exception_occurred_bblast then
					print("Ignoring randomisation due to Baboon Blast")
				end
				exception_occurred_bblast = true;
			else
				exception_occurred_bblast = false
			end
		else
			exception_occurred_bblast = false;
		end
		found_exception = false;
		for i = 1, #exceptions do
			if current_dmap == exceptions[i][1] and transition_speed_value == 1 then
				if current_dexit == exceptions[i][2] or exceptions[i][2] == "ignore" then
					if transition_type == exceptions[i][3] or exceptions[i][3] == "ignore" then
						ignore = true;
						if not exception_occurred_list then
							print("Ignoring randomisation due to exception match")
						end
						exception_occurred_list = true;
						found_exception = true;
					end
				end
			end
		end
		if not found_exception then
			exception_occurred_list = false;
		end

		if mode_value > 5 and not ignore then -- Not Intro Stuff, not bblast
			
			if transition_speed_value < 0 then
				rando_happened = 0;
			end
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
			if transition_speed_value > 0 then
				current_dexit = mainmemory.read_u32_be(Mem.dexit[version]);
				lag = mainmemory.read_u32_be(Mem.frame_lag[version]);
				real = mainmemory.read_u32_be(Mem.frame_real[version]);
				if dmapType == "regular_maps" and cmapType ~= "bonus_maps" then
					mainmemory.writebyte(Mem.insubmap[version], 0);
					mainmemory.writebyte(Mem.insubmap_b[version], 0);
				end
				--[[
				if dmapType == "baboon_blast" then
					mainmemory.writebyte(Mem.insubmap[version], 1);
					mainmemory.writebyte(Mem.insubmap_b[version], 2);
				end
				]]--
				if zipProg < 50 and lag == real and rando_happened == 0 then
					if dmapType == "bonus_maps" and cmapType ~= "bonus_maps" and settings.randomiser_barrel == 1 then
						if current_cmap ~= 0xF then -- Not Snide's HQ
							new_destmap_to_write = getBonusDestination(current_dmap);
							mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
							rando_happened = 1;
						end
					elseif dmapType == "boss_maps" and settings.randomiser > 0 then
						new_destmap_to_write = getBossDestination(current_pmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
						rando_happened = 1;
					elseif dmapType == "k_rool" and current_cmap ~= 0xD6 and settings.randomiser > 0 then -- 0xD6 = Tiny Shoe
						if current_cmap ~= current_dmap and current_cmap ~= 0xD7 then -- Prevents randomisation when re-attempting rounds
							new_destmap_to_write = getKRoolDestination(current_dmap);
							mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
							rando_happened = 1;
						end
					elseif dmapType == "global_maps" and cmapType == "regular_maps" and settings.randomiser > 0 then
						mainmemory.write_u16_be(Mem.pmap[version], current_cmap);
						--mainmemory.writebyte(Mem.pexit[version], current_cexit);
						rando_happened = 1;
					elseif cmapType ~= "bonus_maps" and cmapType ~= "crown_maps" and cmapType ~= "special_minigame_maps" and cmapType ~= "baboon_blast" and dmapType == "regular_maps" then
						if current_cmap ~= 0x61 and current_dmap ~= 0x61 and settings.randomiser > 0 then
							loadingZoneCode = getLoadingZone(current_dmap, current_dexit, current_cmap, cutscene, transition_type);
							new_destexit_to_write = loadingZoneCode % 256;
							new_destmap_to_write = (loadingZoneCode - (loadingZoneCode % 256)) / 256;
							mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
							mainmemory.write_u32_be(Mem.dexit[version], new_destexit_to_write);
							checkMap(new_destmap_to_write);
							rando_happened = 1;
						end
					--[[
					elseif cmapType == "regular_maps" and dmapType == "baboon_blast" and settings.randomiser == 1 then
						new_destmap_to_write = getBBlastDestination(current_dmap);
						--mainmemory.write_u32_be(Mem.dmap[version],new_destmap_to_write); -- TODO: Need to fix BBlast Crashes
						rando_happened = 1;
					]]--
					end
					if current_dmap == 0x11 then -- Helm
						if current_cmap == 0xAA and not checkFlag(0x60,2) then -- Coming from Lobby. BoM is not shut down
							mainmemory.write_u32_be(Mem.dexit[version],3); -- Enter Helm from Lever
							mainmemory.writebyte(Mem.cutscene_fade_active[version],1);
							mainmemory.write_u16_be(Mem.cutscene_fade_value[version],2); -- Open Helm Doors
						end
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

function getLoadingZone(destmap, destexit, origmap, cs_val, transition_type)
	reference = nil;
	lookup_value = (destmap * 256) + destexit;
	
	--special case: Llama temple switch
	if destmap == 38 and destexit == 2 then
		if lzr_type == "chain" then
			devPrint("Value maintained for llama temple "..toHexString(lookup_value));
			return lookup_value;
		elseif transition_type == 0 then
			devPrint("Value maintained for llama temple switch "..toHexString(lookup_value));
			return lookup_value;
		end
	end

	--special case: Tiny Temple Exit
	if destmap == 38 and destexit == 1 then
		if lzr_type == "chain" then
			devPrint("Value maintained for tiny temple "..toHexString(lookup_value));
			return lookup_value;
		end
	end

	--disable randomization for cross-map cutscenes
	if cutsceneActive == 1 then
		for i=1, #cutscene_transition_table do
			if cutscene_transition_table[i][1] == origmap and cutscene_transition_table[i][2] == cs_val then
				devPrint("Value maintained for cutscene transition "..toHexString(lookup_value));
				return lookup_value;
			end
		end
	end
	--normal case
	for i = 1, #regular_map_table do
		if regular_map_table[i] == lookup_value then
			reference = i;
		end
	end
	if reference == nil then
		devPrint("Value maintained as "..toHexString(lookup_value));
		return lookup_value;
	else
		value_to_lookup = regular_map_assortment[reference];
		new_dmap_code = regular_map_table[value_to_lookup];
		devPrint("Value set to as "..toHexString(new_dmap_code));
		return new_dmap_code;
	end
end

cutscene_transition_table = {
	--map id, cutscene id
	{4,3},
	{7,13},
	{62,1},
	{48,11},
	{29,0},
	{26,7},
	{49,0},
	{30,14},
	{62,0},
	{48,10},
	{61,2},
	{38,17},
	{57,0},
	{48,7},
	{61,1},
	{48,9},
};

event.onframeend(randomise, "Randomises Destination Map");