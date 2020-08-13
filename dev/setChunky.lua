function derefPtr(addr)
	addr_output = mainmemory.read_u32_be(addr)
	if addr_output > 0x7FFFFFFF and addr_output < 0x80800000 then
		addr_output = addr_output - 0x80000000;
		return addr_output;
	end
	return 0;
end

kong_data = {
	-- KONG = {FlagByte, FlagBit, CutsceneModelSpawnAddress}
	dk = {0x30, 1, nil}, -- 0x181
	diddy = {0x0, 6, nil}, -- 0x6
	lanky = {0x8, 6, nil}, -- 0x46
	tiny = {0x8, 2, nil}, -- 0x42
	chunky = {0xE, 5, 0x755DF4}, -- 0x75
};

function setGroundSwitchOutput(bp0,encode,cycles)
	bpo = bp0;
	for i = 1, cycles do
		bpn = derefPtr(bpo + 0x4C);
		bpo = bpn;
	end
	mainmemory.write_u16_be(bpn + 0x2E, encode);
end

-- Default Cage = 0x413420
-- Default Slam - 0x4135D0
-- Default GB - 0x412A00
-- setChunky(0x4135D0, 0x413420, 0x412A00, 0xE, 4)
function setChunky(switchObject,cageObject,gbObject,flagByte,flagBit)
	encode = (flagByte * 8) + flagBit;
	mainmemory.write_u16_be(0x755DF4, encode);
	-- Set Output Flag
	bp0A = derefPtr(switchObject + 0x7C);
	bp0B = derefPtr(bp0A + 0xA0)
	setGroundSwitchOutput(bp0,encode,5);
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
	-- Set Golden Banana
	bp_g = derefPtr(gbObject + 0x7C);
	spawnData_g0 = derefPtr(bp_g + 0xA0);
	spawnData_g1 = derefPtr(spawnData_g0 + 0x4C);
	mainmemory.write_u16_be(spawnData_g1 + 0xC, encode)
end

-- setDK(0x49A070,0x49BC00,0x8,6)
function setDK(switchObject,gateObject,flagByte,flagBit)
	encode = (flagByte * 8) + flagBit;
	bp0A = derefPtr(switchObject + 0x7C);
	bp0B = derefPtr(bp0A + 0xA0)
	setGroundSwitchOutput(bp0B,encode,4);
	-- Gate Lowered
	bp_g = derefPtr(gateObject + 0x7C);
	spawnData_g0 = derefPtr(bp_g + 0xA0);
	mainmemory.write_u16_be(spawnData_g0 + 0xC, encode);
	spawnData_g1 = derefPtr(spawnData_g0 + 0x4C);
	mainmemory.write_u16_be(spawnData_g1 + 0xC, encode);
	-- Set Lanky Switch (Visible)
	bp_s0 = derefPtr(switchObject + 0x7C);
	spawnData_s0 = derefPtr(bp_s0 + 0xA0);
	mainmemory.write_u16_be(spawnData_s0 + 0xC, encode)
	-- Set Lanky Switch (Action)
	mainmemory.write_u16_be(spawnData_s0 - 0x54, encode)

end

function setTiny()

end

function setDiddy()

end

function setLanky()

end