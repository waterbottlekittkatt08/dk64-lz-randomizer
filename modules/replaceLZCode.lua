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
			current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
			current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
			current_pmap = mainmemory.read_u16_be(Mem.pmap[version]);
			current_cexit = mainmemory.read_u32_be(Mem.cexit[version]);
			dmapType = mapType(current_dmap);
			cmapType = mapType(current_cmap);
			previous_msb_value = mainmemory.readbyte(Mem.map_state[version]);
			player = getPlayerObject();
			if isRDRAM(player) then
				has_control = mainmemory.readbyte(player + 0x373); -- Might be 0x37B. Changes on same frame
				if transition_speed_value < 0 then
					rando_happened = 0;
					if has_control == 0 then
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
					elseif dmapType == "k_rool" and current_cmap ~= 0xD6 and settings.randomiser == 1 then
						new_destmap_to_write = getKRoolDestination(current_dmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
						rando_happened = 1;
					elseif dmapType == "global_maps" and cmapType == "regular_maps" and settings.randomiser == 1 then
						mainmemory.write_u16_be(Mem.pmap[version], current_cmap);
						--mainmemory.writebyte(Mem.pexit[version], current_cexit);
						rando_happened = 1;
					elseif cmapType ~= "bonus_maps" and cmapType ~= "crown_maps" and dmapType == "regular_maps" then
						if current_cmap ~= 0x61 and current_dmap ~= 0x61 and settings.randomiser == 1 then
							loadingZoneCode = getLoadingZone(current_dmap, current_dexit);
							new_destexit_to_write = loadingZoneCode % 256;
							new_destmap_to_write = (loadingZoneCode - (loadingZoneCode % 256)) / 256;
							mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
							mainmemory.write_u32_be(Mem.dexit[version], new_destexit_to_write);
							checkMap(new_destmap_to_write);
							rando_happened = 1;
						end
					end
				end
			elseif transition_speed_value < 0 and zipProg > 3 and zipProg < 9 and cutsceneActive == 0 and dmapType == "k_rool" and previous_msb_value % 2 == 0 then
				mainmemory.writebyte(Mem.map_state[version], previous_msb_value + 1);
				forcing_a_cutscene = 1;
				-- On first frame of 6 zip progress (-1 transition speed), reload byte
				-- ensure same dest map
				-- Force CS number to array value
				-- Reduce Round Number by 1
			elseif transition_speed_value < 0 and zipProg > 3 and zipProg < 9 and cutsceneActive == 1 and cutscene == 25 and current_dmap == 0xCB and previous_msb_value % 2 == 0 then
				mainmemory.writebyte(Mem.map_state[version], previous_msb_value + 1);
				forcing_a_cutscene = 1;
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
		end
	end
end

function getLoadingZone(destmap, destexit)
	reference = nil;
	lookup_value = (destmap * 256) + destexit;
	for i = 1, #regular_map_table do
		if regular_map_table[i] == lookup_value then
			reference = i;
		end
	end
	if reference == nil then
		print("Value maintained as "..lookup_value);
		return lookup_value;
	else
		value_to_lookup = regular_map_assortment[reference];
		new_dmap_code = regular_map_table[value_to_lookup];
		print("Value set to as "..new_dmap_code);
		return new_dmap_code;
	end
end

event.onframeend(randomise, "Randomises Destination Map");