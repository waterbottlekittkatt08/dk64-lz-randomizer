cameraFlags = {
	[1] = {0x2F,1},
};

function giveMoves()
	for i = 0, 4 do
		selected_kong_header = Mem.kong_base[version] + (i * 0x5E);
		mainmemory.write_u32_be(selected_kong_header, 0x03030702); -- Moves/Slam/Gun/Ammo Belt
		mainmemory.writebyte(selected_kong_header + 4, 15); -- Instrument
	end
	mainmemory.write_u16_be(0x7FCC4B,0x0C03);
	setFlag(cameraFlags[1][1],cameraFlags[1][2]);
end