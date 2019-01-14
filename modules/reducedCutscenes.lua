function setCutscene(value)
	mainmemory.write_u16_be(0x7476F4, value);
end

function removeCutscenes()
	current_cmap = mainmemory.read_u32_be(0x76A0A8);
	cutscene = mainmemory.read_u16_be(0x7476F4);
	cutscene_timer = mainmemory.read_u16_be(0x7476F0);
	if current_cmap == 15 then -- Snide's
		if cutscene == 5 then
			if cutscene_timer == 199 then
				stored_parent_map = mainmemory.read_u16_be(0x76A172);
			elseif cutscene_timer == 200 then
				mainmemory.write_u16_be(0x76A172, 0);
			end
		elseif cutscene == 2 then
			mainmemory.write_u16_be(0x76A172, stored_parent_map);
		end
	end
	quickFile() -- Getting back to the main menu faster
end

function quickFile()
	if version < 2 then
		mode_value = mainmemory.readbyte(mode[version]);
		if mode_value < 5 then
			mainmemory.writebyte(mode[version], 5);
			mainmemory.writebyte(mode[version] - 4, 5);
			mainmemory.write_u32_be(dmap[version], 80)
		end
	end
end

event.onframestart(removeCutscenes, "Removes Cutscenes");