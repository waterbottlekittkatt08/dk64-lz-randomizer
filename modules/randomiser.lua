require "modules.mapAndExitNames";

regular_map_table = {
	[1] = 0x0400,
	[2] = 0x0600,
	[3] = 0x0701,
	[4] = 0x0702,
	[5] = 0x0703,
	[6] = 0x0704,
	[7] = 0x0705,
	[8] = 0x0706,
	[9] = 0x0708,
	[10] = 0x0709,
	[11] = 0x070A,
	[12] = 0x070C,
	[13] = 0x070E,
	[14] = 0x070F,
	[15] = 0x0C00,
	[16] = 0x0D00,
	[17] = 0x0E00,
	[18] = 0x1000,
	[19] = 0x1100,
	[20] = 0x1300,
	[21] = 0x1400,
	[22] = 0x1500,
	[23] = 0x1600,
	[24] = 0x1700,
	[25] = 0x1800,
	[26] = 0x1A00,
	[27] = 0x1A01,
	[28] = 0x1A02,
	[29] = 0x1A03,
	[30] = 0x1A04,
	[31] = 0x1A05,
	[32] = 0x1A06,
	[33] = 0x1A07,
	[34] = 0x1A09,
	[35] = 0x1A0A,
	[36] = 0x1A0B,
	[37] = 0x1A0C,
	[38] = 0x1A0D,
	[39] = 0x1A10,
	[40] = 0x1A11,
	[41] = 0x1B00,
	[42] = 0x1D00,
	[43] = 0x1E00,
	[44] = 0x1E01,
	[45] = 0x1E02,
	[46] = 0x1E03,
	[47] = 0x1E04,
	[48] = 0x1E05,
	[49] = 0x1E06,
	[50] = 0x1E07,
	[51] = 0x1E08,
	[52] = 0x1E09,
	[53] = 0x1E0A,
	[54] = 0x1E0B,
	[55] = 0x1E0C,
	[56] = 0x1E0D,
	[57] = 0x1E0E,
	[58] = 0x1E0F,
	[59] = 0x1E11,
	[60] = 0x1E12,
	[61] = 0x1E13,
	[62] = 0x1E14,
	[63] = 0x1E15,
	[64] = 0x1E16,
	[65] = 0x1E17,
	[66] = 0x1F00,
	[67] = 0x2100,
	[68] = 0x2202,
	[69] = 0x2204,
	[70] = 0x2205,
	[71] = 0x2206,
	[72] = 0x2207,
	[73] = 0x2208,
	[74] = 0x2209,
	[75] = 0x220A,
	[76] = 0x220B,
	[77] = 0x220D,
	[78] = 0x2400,
	[79] = 0x2500,
	[80] = 0x2600,
	[81] = 0x2601,
	[82] = 0x2602,
	[83] = 0x2603,
	[84] = 0x2604,
	[85] = 0x2605,
	[86] = 0x2606,
	[87] = 0x2607,
	[88] = 0x2608,
	[89] = 0x2609,
	[90] = 0x260A,
	[91] = 0x260C,
	[92] = 0x260D,
	[93] = 0x260E,
	[94] = 0x260F,
	[95] = 0x2610,
	[96] = 0x2611,
	[97] = 0x2612,
	[98] = 0x2613,
	[99] = 0x2700,
	[100] = 0x2900,
	[101] = 0x2B00,
	[102] = 0x2B01,
	[103] = 0x2B02,
	[104] = 0x2C00,
	[105] = 0x2D00,
	[106] = 0x2E00,
	[107] = 0x2E01,
	[108] = 0x2F00,
	[109] = 0x2F01,
	[110] = 0x3000,
	[111] = 0x3000,
	[112] = 0x3001,
	[113] = 0x3002,
	[114] = 0x3003,
	[115] = 0x3004,
	[116] = 0x3005,
	[117] = 0x3006,
	[118] = 0x3007,
	[119] = 0x3008,
	[120] = 0x3009,
	[121] = 0x300A,
	[122] = 0x300B,
	[123] = 0x300C,
	[124] = 0x300D,
	[125] = 0x300E,
	[126] = 0x300F,
	[127] = 0x3010,
	[128] = 0x3011,
	[129] = 0x3012,
	[130] = 0x3013,
	[131] = 0x3014,
	[132] = 0x3015,
	[133] = 0x3016,
	[134] = 0x3017,
	[135] = 0x3018,
	[136] = 0x3019,
	[137] = 0x3100,
	[138] = 0x3300,
	[139] = 0x3400,
	[140] = 0x3600,
	[141] = 0x3700,
	[142] = 0x3800,
	[143] = 0x3900,
	[144] = 0x3A00,
	[145] = 0x3B00,
	[146] = 0x3C00,
	[147] = 0x3D00,
	[148] = 0x3D01,
	[149] = 0x3E00,
	[150] = 0x3E01,
	[151] = 0x3E02,
	[152] = 0x3E03,
	[153] = 0x3F00,
	[154] = 0x4000,
	[155] = 0x4001,
	[156] = 0x4002,
	[157] = 0x4003,
	[158] = 0x4004,
	[159] = 0x4600,
	[160] = 0x4700,
	[161] = 0x4800,
	[162] = 0x4801,
	[163] = 0x4802,
	[164] = 0x4803,
	[165] = 0x4804,
	[166] = 0x4805,
	[167] = 0x4806,
	[168] = 0x480C,
	[169] = 0x480D,
	[170] = 0x480E,
	[171] = 0x480F,
	[172] = 0x4810,
	[173] = 0x4811,
	[174] = 0x4812,
	[175] = 0x4813,
	[176] = 0x4814,
	[177] = 0x4815,
	[178] = 0x4816,
	[179] = 0x4817,
	[180] = 0x4818,
	[181] = 0x4819,
	[182] = 0x481A,
	[183] = 0x481E,
	[184] = 0x5200,
	[185] = 0x5400,
	[186] = 0x5500,
	[187] = 0x5600,
	[188] = 0x5700,
	[189] = 0x5701,
	[190] = 0x5702,
	[191] = 0x5703,
	[192] = 0x5704,
	[193] = 0x5705,
	[194] = 0x5706,
	[195] = 0x5707,
	[196] = 0x5708,
	[197] = 0x5709,
	[198] = 0x570A,
	[199] = 0x570C,
	[200] = 0x570D,
	[201] = 0x570E,
	[202] = 0x5710,
	[203] = 0x5712,
	[204] = 0x5713,
	[205] = 0x5714,
	[206] = 0x5800,
	[207] = 0x5801,
	[208] = 0x5900,
	[209] = 0x5A00,
	[210] = 0x5B00,
	[211] = 0x5C00,
	[212] = 0x5D00,
	[213] = 0x5E00,
	[214] = 0x5F00,
	[215] = 0x6200,
	[216] = 0x6400,
	[217] = 0x6900,
	[218] = 0x6A00,
	[219] = 0x6C00,
	[220] = 0x6E00,
	[221] = 0x7000,
	[222] = 0x7100,
	[223] = 0x7101,
	[224] = 0x7102,
	[225] = 0x7200,
	[226] = 0x7201,
	[227] = 0x9700,
	[228] = 0x9701,
	[229] = 0x9702,
	[230] = 0x9703,
	[231] = 0x9704,
	[232] = 0xA300,
	[233] = 0xA400,
	[234] = 0xA600,
	[235] = 0xA700,
	[236] = 0xA800,
	[237] = 0xA900,
	[238] = 0xA901,
	[239] = 0xAA00,
	[240] = 0xAA01,
	[241] = 0xAD00,
	[242] = 0xAD01,
	[243] = 0xAE00,
	[244] = 0xAE01,
	[245] = 0xAF00,
	[246] = 0xAF01,
	[247] = 0xB200,
	[248] = 0xB201,
	[249] = 0xB300,
	[250] = 0xB700,
	[251] = 0xB701,
	[252] = 0xB702,
	[253] = 0xB703,
	[254] = 0xB704,
	[255] = 0xB900,
	[256] = 0xBA00,
	[257] = 0xBB00,
	[258] = 0xBC00,
	[259] = 0xBD00,
	[260] = 0xC100,
	[261] = 0xC101,
	[262] = 0xC200,
	[263] = 0xC201,
	[264] = 0xC300,
	[265] = 0xC301,
	[266] = 0xC800,
};

bonus_map_table = {
	[1] = 3,
	[2] = 10,
	[3] = 18,
	[4] = 32,
	[5] = 35,
	[6] = 50,
	[7] = 65,
	[8] = 66,
	[9] = 67,
	[10] = 68,
	[11] = 69,
	[12] = 74,
	[13] = 75,
	[14] = 77,
	[15] = 78,
	[16] = 79,
	[17] = 96,
	[18] = 99,
	[19] = 101,
	[20] = 102,
	[21] = 103,
	[22] = 104,
	[23] = 115,
	[24] = 116,
	[25] = 117,
	[26] = 118,
	[27] = 119,
	[28] = 120,
	[29] = 121,
	[30] = 122,
	[31] = 123,
	[32] = 124,
	[33] = 125,
	[34] = 126,
	[35] = 127,
	[36] = 128,
	[37] = 129,
	[38] = 130,
	[39] = 131,
	[40] = 132,
	[41] = 133,
	[42] = 134,
	[43] = 135,
	[44] = 136,
	[45] = 137,
	[46] = 138,
	[47] = 139,
	[48] = 140,
	[49] = 141,
	[50] = 142,
	[51] = 143,
	[52] = 144,
	[53] = 145,
	[54] = 146,
	[55] = 147,
	[56] = 148,
	[57] = 149,
	[58] = 150,
	[59] = 165,
	[60] = 201,
	[61] = 202,
	[62] = 209,
	[63] = 210,
	[64] = 211,
	[65] = 212,
};

boss_map_table = {
	[1] = 8,
	[2] = 83,
	[3] = 111,
	[4] = 154,
	[5] = 196,
	[6] = 197,
	[7] = 199
};

k_rool_maps_table = {
	[1] = {0xCB,5};
	[2] = {0xCC,4};
	[3] = {0xCD,7};
	[4] = {0xCE,4};
	[5] = {0xCF,5};
};

function generateAssortment()
	temporary_regular_map_assortment = {};
	regular_map_assortment = {};
	regular_seedSetting = seedAsNumber * 1000;
	for i = 1, #regular_map_table do
		temporary_regular_map_assortment[i] = i;
	end
	math.randomseed(regular_seedSetting);
	for i = 1, #regular_map_table do
		selected_temp_value = math.ceil(math.random() * #temporary_regular_map_assortment);
		regular_map_assortment[i] = temporary_regular_map_assortment[selected_temp_value];
		table.remove(temporary_regular_map_assortment, selected_temp_value);
	end
end

function generateBonusAssortment()
	temporary_bonus_map_assortment = {};
	bonus_map_assortment = {};
	bonus_seedSetting = seedAsNumber * 100;
	for i = 1, #bonus_map_table do
		temporary_bonus_map_assortment[i] = i;
	end
	math.randomseed(bonus_seedSetting);
	for i = 1, #bonus_map_table do
		selected_temp_value = math.ceil(math.random() * #temporary_bonus_map_assortment);
		bonus_map_assortment[i] = temporary_bonus_map_assortment[selected_temp_value];
		table.remove(temporary_bonus_map_assortment, selected_temp_value);
	end
end

function generateBossAssortment()
	temporary_boss_map_assortment = {};
	boss_map_assortment = {};
	boss_seedSetting = seedAsNumber * 10;
	for i = 1, #boss_map_table do
		temporary_boss_map_assortment[i] = i;
	end
	math.randomseed(boss_seedSetting);
	for i = 1, #boss_map_table do
		selected_temp_value = math.ceil(math.random() * #temporary_boss_map_assortment);
		boss_map_assortment[i] = temporary_boss_map_assortment[selected_temp_value];
		table.remove(temporary_boss_map_assortment, selected_temp_value);
	end
end

function generateKRoolOrder()
	temporary_k_rool_table = {};
	k_rool_assortment = {};
	k_rool_seedSetting = seedAsNumber * 10000;
	for i = 1, 4 do
		temporary_k_rool_table[i] = i;
	end
	math.randomseed(k_rool_seedSetting);
	for i = 1, 4 do
		selected_temp_value = math.ceil(math.random() * #temporary_k_rool_table);
		k_rool_assortment[i] = temporary_k_rool_table[selected_temp_value];
		table.remove(temporary_k_rool_table, selected_temp_value);
	end
	k_rool_assortment[5] = 5; -- Always ends on Chunky Phase
end

function setAssortments()
	generateAssortment();
	generateBonusAssortment();
	generateBossAssortment();
	generateKRoolOrder();
end

function getExitName(map_index, exit_index)
	for i = 1, #mapsWithMultipleExits  do
        if map_index == mapsWithMultipleExits[i] then
			local exitName = exitTable[map_index][exit_index + 1];
			assert(exitName ~= nil, "Invalid or unknown exit! Map: "..maps[map_index + 1]..", Exit: " ..exit_index);
			return exitName;
		end
    end
    return exit_index;
end

function getLoadingZone(destmap, destexit)
	lookup_value = (destmap * 256) + destexit;
	for i = 1, #regular_map_table do
		if regular_map_table[i] == lookup_value then
			reference = i;
		end
	end
	if reference == nil then
		print("Value maintained as "..lookup_value);
		return lookup_value;
	else
		value_to_lookup = regular_map_assortment[reference];
		new_dmap_code = regular_map_table[value_to_lookup];
		print("Value set to as "..new_dmap_code);
		return new_dmap_code;
	end
end

function getBonusDestination(destmap)
	for i = 1, #bonus_map_table do
		if bonus_map_table[i] == destmap then
			reference = i;
		end
	end
	if reference == nil then
		return destmap;
	else
		value_to_lookup = bonus_map_assortment[reference];
		new_dmap_code = bonus_map_table[value_to_lookup];
		return new_dmap_code;
	end
end

function getBossDestination(destmap)
	for i = 1, #boss_map_table do
		if boss_map_table[i] == destmap then
			reference = i;
		end
	end
	if reference == nil then
		return destmap;
	else
		value_to_lookup = boss_map_assortment[reference];
		new_dmap_code = boss_map_table[value_to_lookup];
		return new_dmap_code;
	end
end

function getKRoolDestination(destmap)
	for i = 1, #k_rool_maps_table do
		if k_rool_maps_table[i][1] == destmap then
			reference = i;
		end
	end
	if reference == nil then
		return destmap;
	else
		new_dmap_code = k_rool_maps_table[k_rool_assortment[reference]][1];
		return new_dmap_code;
	end
end

function getSeed()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	cutsceneValue = mainmemory.read_u16_be(Mem.cs[version]);
	cutsceneActive = mainmemory.readbyte(Mem.cs_active[version]);
	current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
	zipProg = mainmemory.readbyte(Mem.zipper_progress[version]);
	if current_cmap == 80 and cutsceneActive == 6 and cutsceneValue == 19 and current_dmap == 176 and zipProg > 89 and zipProg < 93 then -- Entering New File
		if settings.all_moves == 1 then
			giveMoves();
		end
	end
end

level_index_flags = {
	[0] = {0x38,5}, -- Japes
	[1] = {0x38,6}, -- Aztec
	[2] = {0x38,7}, -- Factory
	[3] = {0x39,0}, -- Galleon
	[4] = {0x39,1}, -- Fungi
	[5] = {0x39,2}, -- Caves
	[6] = {0x39,3}, -- Castle
	-- [7] = Isles
	[8] = {0x39,4}, -- Helm
};

function checkMap(map_value)
	levelIndex = mainmemory.readbyte(Mem.level_index_mapping[version] + map_value);
	dmapType = mapType(current_dmap);
	if level_index_flags[levelIndex][1] ~= nil then
		if not checkFlag(level_index_flags[levelIndex][1], level_index_flags[levelIndex][2]) then
			setFlag(level_index_flags[levelIndex][1], level_index_flags[levelIndex][2]);
		end
	end
end

forcing_a_cutscene = 0;
rando_happened = 0;

function randomise()
	if version < 2 then -- Should be <4, need to fix CS fade stuff
		getSeed();
		mode_value = mainmemory.readbyte(Mem.mode[version]);
		if mode_value > 5 then -- Not Intro Stuff
			transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
			cutscene = mainmemory.read_u16_be(Mem.cs[version]);
			cutsceneActive = mainmemory.readbyte(Mem.cs_active[version]);
			current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
			current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
			dmapType = mapType(current_dmap);
			cmapType = mapType(current_cmap);
			previous_msb_value = mainmemory.readbyte(Mem.map_state[version]);
			if transition_speed_value < 0 then
				rando_happened = 0;
			end
			if transition_speed_value > 0 then
				current_dexit = mainmemory.read_u32_be(Mem.dexit[version]);
				lag = mainmemory.read_u32_be(Mem.frame_lag[version]);
				real = mainmemory.read_u32_be(Mem.frame_real[version]);
				if zipProg < 37 and lag == real and rando_happened == 0 then
					if dmapType == "bonus_maps" then
						new_destmap_to_write = getBonusDestination(current_dmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
						rando_happened = 1;
					elseif dmapType == "boss_maps" then
						new_destmap_to_write = getBossDestination(current_dmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
						rando_happened = 1;
					elseif dmapType == "k_rool" and current_cmap ~= 0xD6 then
						new_destmap_to_write = getKRoolDestination(current_dmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
						rando_happened = 1;
					elseif dmapType == "global_maps" and cmapType == "regular_maps" then
						mainmemory.write_u16_be(Mem.pmap[version], current_cmap);
						rando_happened = 1;
					elseif cmapType ~= "bonus_maps" and cmapType ~= "crown_maps" and dmapType == "regular_maps" then
						if current_cmap ~= 0x61 and current_dmap ~= 0x61 then
							loadingZoneCode = getLoadingZone(current_dmap, current_dexit);
							new_destexit_to_write = loadingZoneCode % 256;
							new_destmap_to_write = (loadingZoneCode - (loadingZoneCode % 256)) / 256;
							mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
							mainmemory.write_u32_be(Mem.dexit[version], new_destexit_to_write);
							checkMap(new_destmap_to_write);
							rando_happened = 1;
						end
					end
				end
			elseif transition_speed_value < 0 and zipProg > 3 and zipProg < 9 and cutsceneActive == 0 and dmapType == "k_rool" and previous_msb_value % 2 == 0 then
				mainmemory.writebyte(Mem.map_state[version], previous_msb_value + 1);
				forcing_a_cutscene = 1;
				-- On first frame of 6 zip progress (-1 transition speed), reload byte
				-- ensure same dest map
				-- Force CS number to array value
				-- Reduce Round Number by 1
			elseif transition_speed_value < 0 and zipProg > 3 and zipProg < 9 and cutsceneActive == 1 and cutscene == 25 and current_dmap == 0xCB and previous_msb_value % 2 == 0 then
				mainmemory.writebyte(Mem.map_state[version], previous_msb_value + 1);
				forcing_a_cutscene = 1;
			end
			if transition_speed_value < 0 and cmapType == "k_rool" and cutsceneActive == 1 and forcing_a_cutscene == 1 then
				for i = 1, #k_rool_maps_table do
					if k_rool_maps_table[i][1] == current_cmap then
						mainmemory.write_u16_be(Mem.cs[version], k_rool_maps_table[i][2]);
						previous_kr_round = mainmemory.readbyte(Mem.krool_round[version]);
						mainmemory.writebyte(Mem.krool_round[version], previous_kr_round - 1);
						forcing_a_cutscene = 0;
					end
				end
			end
		end
	end
end

event.onframeend(randomise, "Randomises Destination Map");