function setCutscene(value)
	mainmemory.write_u16_be(Mem.cs[version], value);
end

klumsy_cutscene_table = {
	--[value] = {destMap, destCS, {keys}},
	[1] = {0x22,9, {0}}, -- Open Japes
	[2] = {0x22,8, {1}}, -- Open Aztec (Key 1)
	[3] = {0x22,7, {2}}, -- Open Factory > Galleon (Key 2)
	[4] = {0x22,5, {4}}, -- Open Fungi (Key 4)
	[5] = {0x22,4, {5}}, -- Open Caves > Castle (Key 5)
	[6] = {0x22,18, {6, 7}}, -- Open Helm/Attempt to open (Key 6 or 7)
};

klumsy_check_lower = 30;
klumsy_check_upper = 35;

function removeCutscenes()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
	cutscene_active = mainmemory.readbyte(Mem.cs_active[version]);
	cutscene = mainmemory.read_u16_be(Mem.cs[version]);
	cutscene_timer = mainmemory.read_u16_be(Mem.cutscene_timer[version]);
	cs_fade_active = mainmemory.readbyte(Mem.cutscene_fade_active[version]);
	cs_fade_val = mainmemory.read_u16_be(Mem.cutscene_fade_value[version]);
	obj_model2_timer_value = mainmemory.read_u32_be(Mem.obj_model2_timer[version]);
	if current_cmap == 15 then -- Snide's
		if cutscene == 5 then -- Get rid of most contraption cutscenes
			if cutscene_timer == 199 then
				stored_parent_map = mainmemory.read_u16_be(Mem.pmap[version]);
			elseif cutscene_timer == 200 then
				mainmemory.write_u16_be(Mem.pmap[version], 0);
			end
		elseif cutscene == 2 then
			mainmemory.write_u16_be(Mem.pmap[version], stored_parent_map);
		end
		snide_pointers = getActorPointers(184);
		if #snide_pointers > 0 then
			turnincount = mainmemory.readbyte(snide_pointers[1] + 0x232);
			if turnincount > 0 then
				mainmemory.writebyte(snide_pointers[1] + 0x232, 1);
			end
		end
	--elseif current_cmap == 0xCC then -- Diddy Phase
	--	if cutscene == 1 then
	--		krool_diddy_array = getActorPointers(292);
	--		krool_diddy = krool_diddy_array[1];
	--		krool_diddy_state = mainmemory.readbyte(krool_diddy + 0x155);
	--		if krool_diddy_state == 3 then
	--			mainmemory.writebyte(krool_diddy + 0x155, 4); -- Auto Fast Light
	--		end
	--	end
	elseif current_cmap == 97 then
		if cutscene == 0 and cutscene_active == 1 and padlock_swap_occurred == 0 then
			padlock_actors = getActorPointers(334);
			if #padlock_actors > 0 then
				padlock_actor_pointer_array = {};
				for i = 1, #padlock_actors do
					previous_value = mainmemory.readbyte(padlock_actors[i] + 0x17A);
					padlock_actor_pointer_array[previous_value + 1] = padlock_actors[i];
					mainmemory.writebyte(padlock_actors[i] + 0x17A, 7);
				end
				padlock_swap_occurred = 1;
			end
		end
		if cutscene == 0 and cutscene_active == 1 then
			padlock_actors = getActorPointers(334);
			if #padlock_actors > 0 then
				for i = 1, 8 do
					if padlock_actor_pointer_array[i] ~= nil then
						state = mainmemory.readbyte(padlock_actor_pointer_array[i] + 0x154);
						sub_state = mainmemory.readbyte(padlock_actor_pointer_array[i] + 0x155);
						if state == 3 and sub_state == 1 then -- Key turning in
							setFlag(keys[i][4][1], keys[i][4][2]);
							if not checkFlag(keys[8][2][1], keys[8][2][2]) then
								clearFlag(keys[8][4][1], keys[8][4][2]);
							end
						end
					end
				end
			end
		elseif obj_model2_timer_value < klumsy_check_lower then
			padlock_swap_occurred = 0;
			padlock_actors = getActorPointers(334);
			if #padlock_actors > 0 then
				for i = 1, #padlock_actors do
					assigned_key = mainmemory.readbyte(padlock_actors[i] + 0x17A) + 1;
					if checkFlag(keys[assigned_key][2][1], keys[assigned_key][2][2]) then -- has key
						mainmemory.writebyte(padlock_actors[i] + 0x154, 2); -- Key active for turn-in
						mainmemory.writebyte(padlock_actors[i] + 0x147, 1); -- Has key inside (visually)
					end
				end
			end
		end
		if cutscene == 1 and cutscene_active == 1 then
			if not checkFlag(keys[8][2][1], keys[8][2][2]) then
				clearFlag(keys[8][4][1], keys[8][4][2]);
			end
			if not checkFlag(keys[3][2][1], keys[3][2][2]) then
				clearFlag(keys[3][4][1], keys[3][4][2]);
			end
		end
		if cs_fade_active == 1 and cs_fade_val == 9 and current_dmap == 153 then -- loading K Rool Takeoff
			mainmemory.writebyte(Mem.cutscene_fade_active[version], 0);
			mainmemory.write_u32_be(Mem.dmap[version], 0x22)
		end
	elseif current_cmap == 0x11 then
		setTempFlag(0xB8,6); -- DK Grate
		setTempFlag(0xB8,7); -- Chunky Grate
		setTempFlag(0xB9,0); -- Lanky Grate
		setTempFlag(0xB9,1); -- Tiny Grate
		if cutscene == 2 and cutscene_active == 1 and cutscene_timer > 242 then
			setTempFlag(0xB7,3); -- Roman Numeral Doors
		end
	end
	if settings.using_jabos == 0 then
		quickFile() -- Getting back to the main menu faster
	end
	mainmemory.writebyte(Mem.story_skip[version],1);
end

function quickFile()
	if version < 2 then
		mode_value = mainmemory.readbyte(Mem.mode[version]);
		if mode_value < 5 then
			mainmemory.writebyte(Mem.mode[version], 5);
			mainmemory.writebyte(Mem.mode[version] - 4, 5);
			mainmemory.write_u32_be(Mem.dmap[version], 80)
		end
	end
end

event.onframestart(removeCutscenes, "Removes Cutscenes");