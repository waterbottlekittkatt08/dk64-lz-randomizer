regular_maps = {4,6,7,12,13,14,16,17,19,20,21,22,23,24,26,27,29,30,31,33,34,36,37,38,39,41,43,44,45,46,47,48,49,51,52,54,55,56,57,58,59,60,61,62,63,64,70,71,72,82,84,85,86,87,88,89,90,91,92,93,94,95,97,98,100,105,106,108,110,112,113,114,151,163,164,166,167,168,169,170,171,173,174,175,176,178,179,183,185,186,187,188,189,193,194,195,200};
global_maps = {1,5,15,25,42};
boss_maps = {8,83,111,154,196,197,199};
special_minigame_maps = {2,9};
bonus_maps = {3,10,18,32,35,50,65,66,67,68,69,74,75,77,78,79,96,99,101,102,103,104,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,165,201,202,209,210,211,212};
crown_maps = {53,73,155,156,157,158,159,160,161,162};
training_barrels = {177,180,181,182};
k_rool = {203,204,205,207}; -- Tiny Phase not randomised bc shoe

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
	[15] = 0x0800,
	[16] = 0x0C00,
	[17] = 0x0D00,
	[18] = 0x0E00,
	[19] = 0x1000,
	[20] = 0x1100,
	[21] = 0x1300,
	[22] = 0x1400,
	[23] = 0x1500,
	[24] = 0x1600,
	[25] = 0x1700,
	[26] = 0x1800,
	[27] = 0x1A00,
	[28] = 0x1A01,
	[29] = 0x1A02,
	[30] = 0x1A03,
	[31] = 0x1A04,
	[32] = 0x1A05,
	[33] = 0x1A06,
	[34] = 0x1A07,
	[35] = 0x1A08,
	[36] = 0x1A09,
	[37] = 0x1A0A,
	[38] = 0x1A0B,
	[39] = 0x1A0C,
	[40] = 0x1A0D,
	[41] = 0x1A10,
	[42] = 0x1A11,
	[43] = 0x1B00,
	[44] = 0x1D00,
	[45] = 0x1E00,
	[46] = 0x1E01,
	[47] = 0x1E02,
	[48] = 0x1E03,
	[49] = 0x1E04,
	[50] = 0x1E05,
	[51] = 0x1E06,
	[52] = 0x1E07,
	[53] = 0x1E08,
	[54] = 0x1E09,
	[55] = 0x1E0A,
	[56] = 0x1E0B,
	[57] = 0x1E0C,
	[58] = 0x1E0D,
	[59] = 0x1E0E,
	[60] = 0x1E0F,
	[61] = 0x1E11,
	[62] = 0x1E12,
	[63] = 0x1E13,
	[64] = 0x1E14,
	[65] = 0x1E15,
	[66] = 0x1E16,
	[67] = 0x1E17,
	[68] = 0x1F00,
	[69] = 0x2100,
	[70] = 0x2200,
	[71] = 0x2201,
	[72] = 0x2202,
	[73] = 0x2203,
	[74] = 0x2204,
	[75] = 0x2205,
	[76] = 0x2206,
	[77] = 0x2207,
	[78] = 0x2208,
	[79] = 0x2209,
	[80] = 0x220A,
	[81] = 0x220B,
	[82] = 0x220C,
	[83] = 0x220D,
	[84] = 0x2400,
	[85] = 0x2500,
	[86] = 0x2600,
	[87] = 0x2601,
	[88] = 0x2602,
	[89] = 0x2603,
	[90] = 0x2604,
	[91] = 0x2605,
	[92] = 0x2606,
	[93] = 0x2607,
	[94] = 0x2608,
	[95] = 0x2609,
	[96] = 0x260A,
	[97] = 0x260C,
	[98] = 0x260D,
	[99] = 0x260E,
	[100] = 0x260F,
	[101] = 0x2610,
	[102] = 0x2611,
	[103] = 0x2612,
	[104] = 0x2613,
	[105] = 0x2700,
	[106] = 0x2900,
	[107] = 0x2B00,
	[108] = 0x2B01,
	[109] = 0x2B02,
	[110] = 0x2C00,
	[111] = 0x2D00,
	[112] = 0x2E00,
	[113] = 0x2E01,
	[114] = 0x2F00,
	[115] = 0x2F01,
	[116] = 0x3000,
	[117] = 0x3000,
	[118] = 0x3001,
	[119] = 0x3002,
	[120] = 0x3003,
	[121] = 0x3004,
	[122] = 0x3005,
	[123] = 0x3006,
	[124] = 0x3007,
	[125] = 0x3008,
	[126] = 0x3009,
	[127] = 0x300A,
	[128] = 0x300B,
	[129] = 0x300C,
	[130] = 0x300D,
	[131] = 0x300E,
	[132] = 0x300F,
	[133] = 0x3010,
	[134] = 0x3011,
	[135] = 0x3012,
	[136] = 0x3013,
	[137] = 0x3014,
	[138] = 0x3015,
	[139] = 0x3016,
	[140] = 0x3017,
	[141] = 0x3018,
	[142] = 0x3019,
	[143] = 0x3100,
	[144] = 0x3300,
	[145] = 0x3400,
	[146] = 0x3600,
	[147] = 0x3700,
	[148] = 0x3800,
	[149] = 0x3900,
	[150] = 0x3A00,
	[151] = 0x3B00,
	[152] = 0x3C00,
	[153] = 0x3D00,
	[154] = 0x3D01,
	[155] = 0x3E00,
	[156] = 0x3E01,
	[157] = 0x3E02,
	[158] = 0x3E03,
	[159] = 0x3F00,
	[160] = 0x4000,
	[161] = 0x4001,
	[162] = 0x4002,
	[163] = 0x4003,
	[164] = 0x4004,
	[165] = 0x4600,
	[166] = 0x4700,
	[167] = 0x4800,
	[168] = 0x4801,
	[169] = 0x4802,
	[170] = 0x4803,
	[171] = 0x4804,
	[172] = 0x4805,
	[173] = 0x4806,
	[174] = 0x480C,
	[175] = 0x480D,
	[176] = 0x480E,
	[177] = 0x480F,
	[178] = 0x4810,
	[179] = 0x4811,
	[180] = 0x4812,
	[181] = 0x4813,
	[182] = 0x4814,
	[183] = 0x4815,
	[184] = 0x4816,
	[185] = 0x4817,
	[186] = 0x4818,
	[187] = 0x4819,
	[188] = 0x481A,
	[189] = 0x481E,
	[190] = 0x5200,
	[191] = 0x5300,
	[192] = 0x5400,
	[193] = 0x5500,
	[194] = 0x5600,
	[195] = 0x5700,
	[196] = 0x5701,
	[197] = 0x5702,
	[198] = 0x5703,
	[199] = 0x5704,
	[200] = 0x5705,
	[201] = 0x5706,
	[202] = 0x5707,
	[203] = 0x5708,
	[204] = 0x5709,
	[205] = 0x570A,
	[206] = 0x570B,
	[207] = 0x570C,
	[208] = 0x570D,
	[209] = 0x570E,
	[210] = 0x570F,
	[211] = 0x5710,
	[212] = 0x5712,
	[213] = 0x5713,
	[214] = 0x5714,
	[215] = 0x5800,
	[216] = 0x5801,
	[217] = 0x5900,
	[218] = 0x5A00,
	[219] = 0x5B00,
	[220] = 0x5C00,
	[221] = 0x5D00,
	[222] = 0x5E00,
	[223] = 0x5F00,
	[224] = 0x6200,
	[225] = 0x6400,
	[226] = 0x6900,
	[227] = 0x6A00,
	[228] = 0x6C00,
	[229] = 0x6E00,
	[230] = 0x6F00,
	[231] = 0x7000,
	[232] = 0x7001,
	[233] = 0x7100,
	[234] = 0x7101,
	[235] = 0x7102,
	[236] = 0x7200,
	[237] = 0x7201,
	[238] = 0x9700,
	[239] = 0x9701,
	[240] = 0x9702,
	[241] = 0x9703,
	[242] = 0x9704,
	[243] = 0x9A00,
	[244] = 0xA300,
	[245] = 0xA400,
	[246] = 0xA600,
	[247] = 0xA700,
	[248] = 0xA800,
	[249] = 0xA900,
	[250] = 0xA901,
	[251] = 0xAA00,
	[252] = 0xAA01,
	[253] = 0xAD00,
	[254] = 0xAD01,
	[255] = 0xAE00,
	[256] = 0xAE01,
	[257] = 0xAF00,
	[258] = 0xAF01,
	[259] = 0xB200,
	[260] = 0xB201,
	[261] = 0xB300,
	[262] = 0xB700,
	[263] = 0xB701,
	[264] = 0xB702,
	[265] = 0xB703,
	[266] = 0xB704,
	[267] = 0xB900,
	[268] = 0xBA00,
	[269] = 0xBB00,
	[270] = 0xBC00,
	[271] = 0xBD00,
	[272] = 0xC100,
	[273] = 0xC101,
	[274] = 0xC200,
	[275] = 0xC201,
	[276] = 0xC300,
	[277] = 0xC301,
	[278] = 0xC400,
	[279] = 0xC500,
	[280] = 0xC700,
	[281] = 0xC800,
	[282] = 0xCB00,
	[283] = 0xCC00,
	[284] = 0xCD00,
	[285] = 0xCF00,
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

generateAssortment();
generateBonusAssortment();

function getLoadingZone(destmap, destexit)
	lookup_value = (destmap * 256) + destexit;
	for i = 1, #regular_map_table do
		if regular_map_table[i] == lookup_value then
			reference = i;
		end
	end
	if reference == nil then
		return lookup_value;
	else
		value_to_lookup = regular_map_assortment[reference];
		new_dmap_code = regular_map_table[value_to_lookup];
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
	current_cmap = mainmemory.read_u32_be(cmap[version]);
	cutsceneValue = mainmemory.read_u16_be(cs[version]);
	cutsceneActive = mainmemory.readbyte(cs_active[version]);
	current_dmap = mainmemory.read_u32_be(dmap[version]);
	zipProg = mainmemory.readbyte(zipper_progress[version]);
	if current_cmap == 80 and cutsceneActive == 6 and cutsceneValue == 19 and current_dmap == 176 and zipProg > 89 and zipProg < 93 then -- Entering New File
		--saveSeed();
		giveMoves();
	end
end

function randomise()
	if version < 2 then -- Should be <4, need to fix CS fade stuff
		getSeed();
		mode_value = mainmemory.readbyte(mode[version]);
		if mode_value > 5 then -- Not Intro Stuff
			transition_speed_value = mainmemory.readfloat(transition_speed[version], true);
			if transition_speed_value > 0 then
				current_dexit = mainmemory.read_u32_be(dexit[version]);
				lag = mainmemory.read_u32_be(frame_lag[version]);
				real = mainmemory.read_u32_be(frame_real[version]);
				if zipProg > 89 and zipProg < 93 and lag == real then
					dmapType = mapType(current_dmap);
					cmapType = mapType(current_cmap);
					if dmapType == "bonus_maps" then
						new_destmap_to_write = getBonusDestination(current_dmap);
						mainmemory.write_u32_be(dmap[version], new_destmap_to_write);
					elseif cmapType ~= "bonus_maps" then
						loadingZoneCode = getLoadingZone(current_dmap, current_dexit);
						new_destexit_to_write = loadingZoneCode % 256;
						new_destmap_to_write = (loadingZoneCode - (loadingZoneCode % 256)) / 256;
						mainmemory.write_u32_be(dmap[version], new_destmap_to_write);
						mainmemory.write_u32_be(dexit[version], new_destexit_to_write);
					end
				end
			end
		end
	end
end

event.onframeend(randomise, "Randomises Destination Map");