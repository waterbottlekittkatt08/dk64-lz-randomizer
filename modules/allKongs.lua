kong_flags = {
	[1] = {0x30,1}, -- DK
	[2] = {0x0,6}, -- Diddy
	[3] = {0x8,6}, -- Lanky
	[4] = {0x8,2}, -- Tiny
	[5] = {0xE,5}, -- Chunky
};

function getFileEntranceAllKongs()
	if current_cmap == 80 and cutsceneActive == 6 and cutsceneValue == 19 and current_dmap == 176 and zipProg > 89 and zipProg < 93 then -- Entering New File
		for i = 1, 5 do
			setFlag(kong_flags[i][1],kong_flags[i][2]);
		end
	end
end

event.onframestart(getFileEntranceAllKongs, "Acquires all kongs");