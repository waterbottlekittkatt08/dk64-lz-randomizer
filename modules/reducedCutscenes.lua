function setCutscene(value)
	mainmemory.write_u16_be(Mem.cs[version], value);
end

function removeCutscenes()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	cutscene = mainmemory.read_u16_be(Mem.cs[version]);
	cutscene_timer = mainmemory.read_u16_be(Mem.cutscene_timer[version]);
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
			mainmemory.writebyte(snide_pointers[1] + 0x232, 1);
		end
	end
	if settings.using_jabos == 0 then
		quickFile() -- Getting back to the main menu faster
	end
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