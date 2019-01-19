regular_maps = {4,6,7,12,13,14,16,17,19,20,21,22,23,24,26,27,29,30,31,33,34,36,37,38,39,41,43,44,45,46,47,48,49,51,52,54,55,56,57,58,59,60,61,62,63,64,70,71,72,82,84,85,86,87,88,89,90,91,92,93,94,95,97,98,100,105,106,108,110,112,113,114,151,163,164,166,167,168,169,170,171,173,174,175,176,178,179,183,185,186,187,188,189,193,194,195,200};
global_maps = {1,5,15,25,42};
boss_maps = {8,83,111,154,196,197,199};
special_minigame_maps = {2,9};
bonus_maps = {3,10,18,32,35,50,65,66,67,68,69,74,75,77,78,79,96,99,101,102,103,104,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,165,201,202,209,210,211,212};
crown_maps = {53,73,155,156,157,158,159,160,161,162};
training_barrels = {177,180,181,182};
k_rool = {203,204,205,206,207};

regular_map_table = {
	[1] = 0x0300,
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
	[77] = 0x220C,
	[78] = 0x220D,
	[79] = 0x2400,
	[80] = 0x2500,
	[81] = 0x2600,
	[82] = 0x2601,
	[83] = 0x2602,
	[84] = 0x2603,
	[85] = 0x2604,
	[86] = 0x2605,
	[87] = 0x2606,
	[88] = 0x2607,
	[89] = 0x2608,
	[90] = 0x2609,
	[91] = 0x260A,
	[92] = 0x260C,
	[93] = 0x260D,
	[94] = 0x260E,
	[95] = 0x260F,
	[96] = 0x2610,
	[97] = 0x2611,
	[98] = 0x2612,
	[99] = 0x2613,
	[100] = 0x2700,
	[101] = 0x2900,
	[102] = 0x2B00,
	[103] = 0x2B01,
	[104] = 0x2B02,
	[105] = 0x2C00,
	[106] = 0x2D00,
	[107] = 0x2E00,
	[108] = 0x2E01,
	[109] = 0x2F00,
	[110] = 0x2F01,
	[111] = 0x3000,
	[112] = 0x3000,
	[113] = 0x3001,
	[114] = 0x3002,
	[115] = 0x3003,
	[116] = 0x3004,
	[117] = 0x3005,
	[118] = 0x3006,
	[119] = 0x3007,
	[120] = 0x3008,
	[121] = 0x3009,
	[122] = 0x300A,
	[123] = 0x300B,
	[124] = 0x300C,
	[125] = 0x300D,
	[126] = 0x300E,
	[127] = 0x300F,
	[128] = 0x3010,
	[129] = 0x3011,
	[130] = 0x3012,
	[131] = 0x3013,
	[132] = 0x3014,
	[133] = 0x3015,
	[134] = 0x3016,
	[135] = 0x3017,
	[136] = 0x3018,
	[137] = 0x3019,
	[138] = 0x3100,
	[139] = 0x3300,
	[140] = 0x3400,
	[141] = 0x3600,
	[142] = 0x3700,
	[143] = 0x3800,
	[144] = 0x3900,
	[145] = 0x3A00,
	[146] = 0x3B00,
	[147] = 0x3C00,
	[148] = 0x3D00,
	[149] = 0x3D01,
	[150] = 0x3E00,
	[151] = 0x3E01,
	[152] = 0x3E02,
	[153] = 0x3E03,
	[154] = 0x3F00,
	[155] = 0x4000,
	[156] = 0x4001,
	[157] = 0x4002,
	[158] = 0x4003,
	[159] = 0x4004,
	[160] = 0x4600,
	[161] = 0x4700,
	[162] = 0x4800,
	[163] = 0x4801,
	[164] = 0x4802,
	[165] = 0x4803,
	[166] = 0x4804,
	[167] = 0x4805,
	[168] = 0x4806,
	[169] = 0x480C,
	[170] = 0x480D,
	[171] = 0x480E,
	[172] = 0x480F,
	[173] = 0x4810,
	[174] = 0x4811,
	[175] = 0x4812,
	[176] = 0x4813,
	[177] = 0x4814,
	[178] = 0x4815,
	[179] = 0x4816,
	[180] = 0x4817,
	[181] = 0x4818,
	[182] = 0x4819,
	[183] = 0x481A,
	[184] = 0x481E,
	[185] = 0x5200,
	[186] = 0x5400,
	[187] = 0x5500,
	[188] = 0x5600,
	[189] = 0x5700,
	[190] = 0x5701,
	[191] = 0x5702,
	[192] = 0x5703,
	[193] = 0x5704,
	[194] = 0x5705,
	[195] = 0x5706,
	[196] = 0x5707,
	[197] = 0x5708,
	[198] = 0x5709,
	[199] = 0x570A,
	[200] = 0x570C,
	[201] = 0x570D,
	[202] = 0x570E,
	[203] = 0x5710,
	[204] = 0x5712,
	[205] = 0x5713,
	[206] = 0x5714,
	[207] = 0x5800,
	[208] = 0x5801,
	[209] = 0x5900,
	[210] = 0x5A00,
	[211] = 0x5B00,
	[212] = 0x5C00,
	[213] = 0x5D00,
	[214] = 0x5E00,
	[215] = 0x5F00,
	[216] = 0x6200,
	[217] = 0x6400,
	[218] = 0x6900,
	[219] = 0x6A00,
	[220] = 0x6C00,
	[221] = 0x6E00,
	[222] = 0x7000,
	[223] = 0x7001,
	[224] = 0x7100,
	[225] = 0x7101,
	[226] = 0x7102,
	[227] = 0x7200,
	[228] = 0x7201,
	[229] = 0x9700,
	[230] = 0x9701,
	[231] = 0x9702,
	[232] = 0x9703,
	[233] = 0x9704,
	[234] = 0xA300,
	[235] = 0xA400,
	[236] = 0xA600,
	[237] = 0xA700,
	[238] = 0xA800,
	[239] = 0xA900,
	[240] = 0xA901,
	[241] = 0xAA00,
	[242] = 0xAA01,
	[243] = 0xAD00,
	[244] = 0xAD01,
	[245] = 0xAE00,
	[246] = 0xAE01,
	[247] = 0xAF00,
	[248] = 0xAF01,
	[249] = 0xB200,
	[250] = 0xB201,
	[251] = 0xB300,
	[252] = 0xB700,
	[253] = 0xB701,
	[254] = 0xB702,
	[255] = 0xB703,
	[256] = 0xB704,
	[257] = 0xB900,
	[258] = 0xBA00,
	[259] = 0xBB00,
	[260] = 0xBC00,
	[261] = 0xBD00,
	[262] = 0xC100,
	[263] = 0xC101,
	[264] = 0xC200,
	[265] = 0xC201,
	[266] = 0xC300,
	[267] = 0xC301,
	[268] = 0xC800,
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

function mapType(mapNumber)
	for i = 1, #regular_maps do
		if mapNumber == regular_maps[i] then
			return "regular_maps";
		end
	end
	for i = 1, #global_maps do
		if mapNumber == global_maps[i] then
			return "global_maps";
		end
	end
	for i = 1, #boss_maps do
		if mapNumber == boss_maps[i] then
			return "boss_maps";
		end
	end
	for i = 1, #special_minigame_maps do
		if mapNumber == special_minigame_maps[i] then
			return "special_minigame_maps";
		end
	end
	for i = 1, #bonus_maps do
		if mapNumber == bonus_maps[i] then
			return "bonus_maps";
		end
	end
	for i = 1, #crown_maps do
		if mapNumber == crown_maps[i] then
			return "crown_maps";
		end
	end
	for i = 1, #training_barrels do
		if mapNumber == training_barrels[i] then
			return "training_barrels";
		end
	end
	for i = 1, #k_rool do
		if mapNumber == k_rool[i] then
			return "k_rool";
		end
	end
	return "Unassigned";
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
			if transition_speed_value > 0 then
				current_dexit = mainmemory.read_u32_be(Mem.dexit[version]);
				lag = mainmemory.read_u32_be(Mem.frame_lag[version]);
				real = mainmemory.read_u32_be(Mem.frame_real[version]);
				if zipProg > 89 and zipProg < 93 and lag == real then
					if dmapType == "bonus_maps" then
						new_destmap_to_write = getBonusDestination(current_dmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
					elseif dmapType == "boss_maps" then
						new_destmap_to_write = getBossDestination(current_dmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
					elseif dmapType == "k_rool" and current_cmap ~= 0xD6 then
						new_destmap_to_write = getKRoolDestination(current_dmap);
						mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
					elseif dmapType == "global_maps" then
						mainmemory.write_u16_be(Mem.pmap[version], current_cmap);
					elseif cmapType ~= "bonus_maps" and dmapType == "regular_maps" then
						if current_cmap ~= 0x61 and current_dmap ~= 0x61 then
							loadingZoneCode = getLoadingZone(current_dmap, current_dexit);
							new_destexit_to_write = loadingZoneCode % 256;
							new_destmap_to_write = (loadingZoneCode - (loadingZoneCode % 256)) / 256;
							mainmemory.write_u32_be(Mem.dmap[version], new_destmap_to_write);
							mainmemory.write_u32_be(Mem.dexit[version], new_destexit_to_write);
							checkMap(new_destmap_to_write);
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