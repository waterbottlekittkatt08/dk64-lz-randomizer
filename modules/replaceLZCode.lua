require "modules.mapAndExitNames";

forcing_a_cutscene = 0;
rando_happened = 0;

function randomise()
	if version < 2 then -- Should be <4, need to fix CS fade stuff
		mode_value = mainmemory.readbyte(Mem.mode[version]);
		if mode_value > 5 then -- Not Intro Stuff
			transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
			zipProg = mainmemory.readbyte(Mem.zipper_progress[version]);
			cutscene = mainmemory.read_u16_be(Mem.cs[version]);
			cutsceneActive = mainmemory.readbyte(Mem.cs_active[version]);
			transition_type = mainmemory.readbyte(Mem.loading_zone_transition_type[version]);
			current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
			current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
			current_pmap = mainmemory.read_u16_be(Mem.pmap[version]);
			current_cexit = mainmemory.read_u32_be(Mem.cexit[version]);
			dmapType = mapType(current_dmap);
			cmapType = mapType(current_cmap);
			previous_msb_value = mainmemory.readbyte(Mem.map_state[version]);
			player = getPlayerObject();
			if transition_speed_value < 0 then
				rando_happened = 0;
			end
			if isRDRAM(player) and cmapType == "regular_maps" then
				has_control = mainmemory.readbyte(player + 0x373); -- Might be 0x37B. Changes on same frame
				movement = mainmemory.readbyte(player + 0x154); -- Might be 0x37B. Changes on same frame
				if transition_speed_value < 0 then
					rando_happened = 0;
					if has_control == 0 and zipProg > 6 and movement ~= 0x42 then
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
						if settings.randomiser == 1 then
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
				if zipProg < 50 and lag == real and rando_happened == 0 then
					if dmapType == "bonus_maps" and cmapType ~= "bonus_maps" and settings.randomiser_barrel == 1 then
						new_destmap_to_write = getBonusDestination(current_dmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
						rando_happened = 1;
					elseif dmapType == "boss_maps" and settings.randomiser == 1 then
						new_destmap_to_write = getBossDestination(current_pmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
						rando_happened = 1;
					elseif dmapType == "k_rool" and current_cmap ~= 0xD6 and settings.randomiser == 1 then -- 0xD6 = Tiny Shoe
						if current_cmap ~= current_dmap and current_cmap ~= 0xD7 then -- Prevents randomisation when re-attempting rounds
							new_destmap_to_write = getKRoolDestination(current_dmap);
							mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
							rando_happened = 1;
						end
					elseif dmapType == "global_maps" and cmapType == "regular_maps" and settings.randomiser == 1 then
						mainmemory.write_u16_be(Mem.pmap[version], current_cmap);
						--mainmemory.writebyte(Mem.pexit[version], current_cexit);
						rando_happened = 1;
					elseif cmapType ~= "bonus_maps" and cmapType ~= "crown_maps" and cmapType ~= "special_minigame_maps" and dmapType == "regular_maps" then
						if current_cmap ~= 0x61 and current_dmap ~= 0x61 and settings.randomiser == 1 then
							loadingZoneCode = getLoadingZone(current_dmap, current_dexit, current_cmap, cutscene, transition_type);
							new_destexit_to_write = loadingZoneCode % 256;
							new_destmap_to_write = (loadingZoneCode - (loadingZoneCode % 256)) / 256;
							mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
							mainmemory.write_u32_be(Mem.dexit[version], new_destexit_to_write);
							checkMap(new_destmap_to_write);
							rando_happened = 1;
						end
					end
				end
			elseif transition_speed_value < 0 and zipProg > 6 and zipProg < 12 and cutsceneActive == 0 and dmapType == "k_rool" and previous_msb_value % 2 == 0 then
				mainmemory.writebyte(Mem.map_state[version], previous_msb_value + 1);
				forcing_a_cutscene = 1;
				-- On first frame of 6 zip progress (-1 transition speed), reload byte
				-- ensure same dest map
				-- Force CS number to array value
				-- Reduce Round Number by 14
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
	if destmap == 38 and destexit == 2 and transition_type == 0 then
		devPrint("Value maintained for llama temple switch "..toHexString(lookup_value));
		return lookup_value;
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