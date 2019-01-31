kong_flags = {
	[1] = {0x30,1}, -- DK
	[2] = {0x0,6}, -- Diddy
	[3] = {0x8,6}, -- Lanky
	[4] = {0x8,2}, -- Tiny
	[5] = {0xE,5}, -- Chunky
};

function getAllKongs()
	for i = 1, 5 do
		setFlag(kong_flags[i][1],kong_flags[i][2]);
	end
end