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

generateBonusAssortment();

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