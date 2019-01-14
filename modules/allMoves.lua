function giveMoves()
	kong_headers = {0x7FC950, 0x7FC9AE, 0x7FCA0C, 0x7FCA6A, 0x7FCAC8};
	for i = 1, #kong_headers do
		selected_kong_header = kong_headers[i];
		mainmemory.write_u32_be(selected_kong_header, 0x03030702); -- Moves/Slam/Gun/Ammo Belt
		mainmemory.writebyte(selected_kong_header + 4, 15); -- Instrument
	end
	mainmemory.write_u16_be(0x7FCC4B,0x0C03);
end