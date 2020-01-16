-- Credit: Retroben

function performKongChange()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	player_pointer = getPlayerObject();
	kong_reload_address = dereferencePointer(Mem.kong_reload_pointer[version]) + 0x29C;
	player_dpad_input = mainmemory.readbyte(Mem.player1_input[version]) % 16;
	player_shoulder_input = (mainmemory.readbyte(Mem.player1_input[version] + 1) - (mainmemory.readbyte(Mem.player1_input[version] + 1) % 16)) / 16;
	if isRDRAM(player_pointer) then
		if current_cmap ~= 2 and current_cmap ~= 9 then -- Not jetpac or arcade, which have legitimate uses of the D-Pad
			if current_cmap ~= 0xC7 then -- Not Kut Out, would make the fight more trivial than it is
				if bit.check(player_shoulder_input,1) then -- L (DK)
					mainmemory.writebyte(player_pointer + 0x36F, 2);
					mainmemory.write_u16_be(kong_reload_address, 0x003B);
				elseif bit.check(player_dpad_input,3) and checkFlag(0,6) then -- DUp (Diddy)
					mainmemory.writebyte(player_pointer + 0x36F, 3);
					mainmemory.write_u16_be(kong_reload_address, 0x003B);
				elseif bit.check(player_dpad_input,0) and checkFlag(8,6) then -- DRight (Lanky)
					mainmemory.writebyte(player_pointer + 0x36F, 4);
					mainmemory.write_u16_be(kong_reload_address, 0x003B);
				elseif bit.check(player_dpad_input,2) and checkFlag(8,2) then -- DDown (Tiny)
					mainmemory.writebyte(player_pointer + 0x36F, 5);
					mainmemory.write_u16_be(kong_reload_address, 0x003B);
				elseif bit.check(player_dpad_input,1) and checkFlag(14,5) then -- DLeft (Chunky)
					mainmemory.writebyte(player_pointer + 0x36F, 6);
					mainmemory.write_u16_be(kong_reload_address, 0x003B);
				end
			end
		end
	end
end

event.onframeend(performKongChange, "Checks data and alters kong");