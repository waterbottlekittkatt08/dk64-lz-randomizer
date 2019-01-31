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
	[19] = 0x1300,
	[20] = 0x1400,
	[21] = 0x1500,
	[22] = 0x1600,
	[23] = 0x1700,
	[24] = 0x1800,
	[25] = 0x1A00,
	[26] = 0x1A01,
	[27] = 0x1A02,
	[28] = 0x1A03,
	[29] = 0x1A04,
	[30] = 0x1A05,
	[31] = 0x1A06,
	[32] = 0x1A07,
	[33] = 0x1A09,
	[34] = 0x1A0A,
	[35] = 0x1A0B,
	[36] = 0x1A0C,
	[37] = 0x1A0D,
	[38] = 0x1A10,
	[39] = 0x1A11,
	[40] = 0x1B00,
	[41] = 0x1D00,
	[42] = 0x1E00,
	[43] = 0x1E01,
	[44] = 0x1E02,
	[45] = 0x1E03,
	[46] = 0x1E04,
	[47] = 0x1E05,
	[48] = 0x1E06,
	[49] = 0x1E07,
	[50] = 0x1E08,
	[51] = 0x1E09,
	[52] = 0x1E0A,
	[53] = 0x1E0B,
	[54] = 0x1E0C,
	[55] = 0x1E0D,
	[56] = 0x1E0E,
	[57] = 0x1E0F,
	[58] = 0x1E11,
	[59] = 0x1E12,
	[60] = 0x1E13,
	[61] = 0x1E14,
	[62] = 0x1E15,
	[63] = 0x1E16,
	[64] = 0x1E17,
	[65] = 0x1F00,
	[66] = 0x2100,
	[67] = 0x2202,
	[68] = 0x2204,
	[69] = 0x2205,
	[70] = 0x2206,
	[71] = 0x2207,
	[72] = 0x2208,
	[73] = 0x2209,
	[74] = 0x220A,
	[75] = 0x220B,
	[76] = 0x220D,
	[77] = 0x2400,
	[78] = 0x2500,
	[79] = 0x2600,
	[80] = 0x2601,
	[81] = 0x2602,
	[82] = 0x2603,
	[83] = 0x2604,
	[84] = 0x2605,
	[85] = 0x2606,
	[86] = 0x2607,
	[87] = 0x2608,
	[88] = 0x2609,
	[89] = 0x260A,
	[90] = 0x260C,
	[91] = 0x260D,
	[92] = 0x260E,
	[93] = 0x260F,
	[94] = 0x2610,
	[95] = 0x2611,
	[96] = 0x2612,
	[97] = 0x2613,
	[98] = 0x2700,
	[99] = 0x2900,
	[100] = 0x2B00,
	[101] = 0x2B01,
	[102] = 0x2B02,
	[103] = 0x2C00,
	[104] = 0x2D00,
	[105] = 0x2E00,
	[106] = 0x2E01,
	[107] = 0x2F00,
	[108] = 0x2F01,
	[109] = 0x3000,
	[110] = 0x3001,
	[111] = 0x3002,
	[112] = 0x3003,
	[113] = 0x3004,
	[114] = 0x3005,
	[115] = 0x3006,
	[116] = 0x3007,
	[117] = 0x3008,
	[118] = 0x3009,
	[119] = 0x300A,
	[120] = 0x300B,
	[121] = 0x300C,
	[122] = 0x300D,
	[123] = 0x300E,
	[124] = 0x300F,
	[125] = 0x3010,
	[126] = 0x3011,
	[127] = 0x3012,
	[128] = 0x3013,
	[129] = 0x3014,
	[130] = 0x3015,
	[131] = 0x3016,
	[132] = 0x3017,
	[133] = 0x3018,
	[134] = 0x3019,
	[135] = 0x3100,
	[136] = 0x3300,
	[137] = 0x3400,
	[138] = 0x3600,
	[139] = 0x3700,
	[140] = 0x3800,
	[141] = 0x3900,
	[142] = 0x3A00,
	[143] = 0x3B00,
	[144] = 0x3C00,
	[145] = 0x3D00,
	[146] = 0x3D01,
	[147] = 0x3E00,
	[148] = 0x3E01,
	[149] = 0x3E02,
	[150] = 0x3E03,
	[151] = 0x3F00,
	[152] = 0x4000,
	[153] = 0x4001,
	[154] = 0x4002,
	[155] = 0x4003,
	[156] = 0x4004,
	[157] = 0x4600,
	[158] = 0x4700,
	[159] = 0x4800,
	[160] = 0x4801,
	[161] = 0x4802,
	[162] = 0x4803,
	[163] = 0x4804,
	[164] = 0x4805,
	[165] = 0x4806,
	[166] = 0x480C,
	[167] = 0x480D,
	[168] = 0x480E,
	[169] = 0x480F,
	[170] = 0x4810,
	[171] = 0x4811,
	[172] = 0x4812,
	[173] = 0x4813,
	[174] = 0x4814,
	[175] = 0x4815,
	[176] = 0x4816,
	[177] = 0x4817,
	[178] = 0x4818,
	[179] = 0x4819,
	[180] = 0x481A,
	[181] = 0x481E,
	[182] = 0x5200,
	[183] = 0x5400,
	[184] = 0x5500,
	[185] = 0x5600,
	[186] = 0x5700,
	[187] = 0x5701,
	[188] = 0x5702,
	[189] = 0x5703,
	[190] = 0x5704,
	[191] = 0x5705,
	[192] = 0x5706,
	[193] = 0x5707,
	[194] = 0x5708,
	[195] = 0x5709,
	[196] = 0x570A,
	[197] = 0x570C,
	[198] = 0x570D,
	[199] = 0x570E,
	[200] = 0x5710,
	[201] = 0x5712,
	[202] = 0x5713,
	[203] = 0x5714,
	[204] = 0x5800,
	[205] = 0x5801,
	[206] = 0x5900,
	[207] = 0x5A00,
	[208] = 0x5B00,
	[209] = 0x5C00,
	[210] = 0x5D00,
	[211] = 0x5E00,
	[212] = 0x5F00,
	[213] = 0x6200,
	[214] = 0x6400,
	[215] = 0x6900,
	[216] = 0x6A00,
	[217] = 0x6C00,
	[218] = 0x6E00,
	[219] = 0x7000,
	[220] = 0x7100,
	[221] = 0x7101,
	[222] = 0x7102,
	[223] = 0x7200,
	[224] = 0x7201,
	[225] = 0x9700,
	[226] = 0x9701,
	[227] = 0x9702,
	[228] = 0x9703,
	[229] = 0x9704,
	[230] = 0xA300,
	[231] = 0xA400,
	[232] = 0xA600,
	[233] = 0xA700,
	[234] = 0xA800,
	[235] = 0xA900,
	[236] = 0xA901,
	[237] = 0xAD00,
	[238] = 0xAD01,
	[239] = 0xAE00,
	[240] = 0xAE01,
	[241] = 0xAF00,
	[242] = 0xAF01,
	[243] = 0xB200,
	[244] = 0xB201,
	[245] = 0xB300,
	[246] = 0xB700,
	[247] = 0xB701,
	[248] = 0xB702,
	[249] = 0xB703,
	[250] = 0xB704,
	[251] = 0xB900,
	[252] = 0xBA00,
	[253] = 0xBB00,
	[254] = 0xBC00,
	[255] = 0xBD00,
	[256] = 0xC100,
	[257] = 0xC101,
	[258] = 0xC200,
	[259] = 0xC201,
	[260] = 0xC300,
	[261] = 0xC301,
	[262] = 0xC800,
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
	reference = nil;
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
	reference = nil;
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
	reference = nil;
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
	reference = nil;
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
	[7] = {0xFFFF,0}, -- Isles
	[8] = {0x39,4}, -- Helm
};

function checkMap(map_value)
	levelIndex = mainmemory.readbyte(Mem.level_index_mapping[version] + map_value);
	dmapType = mapType(current_dmap);
	if level_index_flags[levelIndex][1] ~= 0xFFFF then -- Not Isles
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
			current_cexit = mainmemory.read_u32_be(Mem.cexit[version]);
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
				if zipProg < 50 and lag == real and rando_happened == 0 then
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
						--mainmemory.writebyte(Mem.pexit[version], current_cexit);
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