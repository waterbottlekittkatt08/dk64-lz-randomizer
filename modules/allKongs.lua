kong_flags = {
	[1] = {0x30,1}, -- DK
	[2] = {0x0,6}, -- Diddy
	[3] = {0x8,6}, -- Lanky
	[4] = {0x8,2}, -- Tiny
	[5] = {0xE,5}, -- Chunky
};

function getFileEntranceAllKongs()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	cutsceneValue = mainmemory.read_u16_be(Mem.cs[version]);
	cutsceneActive = mainmemory.readbyte(Mem.cs_active[version]);
	current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
	zipProg = mainmemory.readbyte(Mem.zipper_progress[version]);
	if current_cmap == 80 and cutsceneActive == 6 and cutsceneValue == 19 and current_dmap == 176 and zipProg > 31 and zipProg < 37 then -- Entering New File
		for i = 1, 5 do
			setFlag(kong_flags[i][1],kong_flags[i][2]);
		end
	end
end

event.onframestart(getFileEntranceAllKongs, "Acquires all kongs");