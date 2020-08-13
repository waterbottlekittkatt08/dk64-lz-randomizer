function derefPtr(addr)
	addr_output = mainmemory.read_u32_be(addr)
	if addr_output > 0x7FFFFFFF and addr_output < 0x80800000 then
		addr_output = addr_output - 0x80000000;
		return addr_output;
	end
	return 0;
end

-- Default Cage = 0x413420
-- Default Slam - 0x4135D0
-- setChunky(0x4135D0, 0x413420, 0xE, 4)
function setChunky(switchObject,cageObject,flagByte,flagBit)
	encode = (flagByte * 8) + flagBit;
	-- Set Output Flag
	bp0 = derefPtr(switchObject + 0x7C);
	bp1 = derefPtr(bp0 + 0x4C);
	bp2 = derefPtr(bp1 + 0x4C);
	bp3 = derefPtr(bp2 + 0x4C);
	bp4 = derefPtr(bp3 + 0x4C);
	bp5 = derefPtr(bp4 + 0x4C);
	bp6 = derefPtr(bp5 + 0x4C);
	mainmemory.write_u16_be(bp6 + 0x2E, encode);
	-- Set Chunky Cage
	bp_c = derefPtr(cageObject + 0x7C);
	spawnData_c = derefPtr(bp_c + 0xA0);
	mainmemory.write_u16_be(spawnData_c + 0xC, encode)
	-- Set Lanky Switch (Visible)
	bp_s0 = derefPtr(switchObject + 0x7C);
	spawnData_s0 = derefPtr(bp_s0 + 0xA0);
	mainmemory.write_u16_be(spawnData_s0 + 0xC, encode)
	-- Set Lanky Switch (Action)
	mainmemory.write_u16_be(spawnData_s0 - 0x54, encode)
end