bonus_map_table = {
	-- [minigame_number] = {minigame_map, {completion array}, {accessibility array}},
	[1] = {3, {1,2,3,4,5}, {3}},
	[2] = {10, {1,2,3,4,5}, {5}, ishelm = true},
	[3] = {18, {1,2,3,4,5}, {3}},
	[4] = {32, {1,2,3,4,5}, {1,2,3,4,5}},
	[5] = {35, {1}, {1}, ishelm = true},
	[6] = {50, {1,2,3,4,5}, {4}, ishelm = true},
	[7] = {65, {1,2,3,4,5}, {2}},
	[8] = {66, {1,2,3,4,5}, nosource = true},
	[9] = {67, {1,2,3,4,5}, nosource = true},
	[10] = {68, {1,2,3,4,5}, {3}},
	[11] = {69, {1,2,3,4,5}, {2,4}},
	[12] = {74, {1,2,3,4,5}, {5}},
	[13] = {75, {1,2,3,4,5}, nosource = true},
	[14] = {77, {1,2,3,4,5}, {5}},
	[15] = {78, {1,2,4,5}, {5}},
	[16] = {79, {1,2,4,5}, {2}},
	[17] = {96, {1,2,3,4,5}, {4}},
	[18] = {99, {1,2,3,4,5}, {3}},
	[19] = {101, {1,2,3,4,5}, {4}},
	[20] = {102, {1,2,3,4,5}, {3}},
	[21] = {103, {1,2,3,4,5}, {3}},
	[22] = {104, {1,2,3,4,5}, {2}, helm_ban = true},
	[23] = {115, {1,2,3,4,5}, {4}},
	[24] = {116, {1,2,3,4,5}, {3}},
	[25] = {117, {1,2,3,4,5}, {5}},
	[26] = {118, {1,2,3,4,5}, {2}},
	[27] = {119, {1,2,3,4,5}, {4}},
	[28] = {120, {1,2,3,4,5}, nosource = true},
	[29] = {121, {1,2,3,4,5}, {5}},
	[30] = {122, {1,2,3,4,5}, {2}},
	[31] = {123, {1,2,3,4,5}, nosource = true},
	[32] = {124, {1,2,3,4,5}, nosource = true},
	[33] = {125, {1,2,3,4,5}, nosource = true},
	[34] = {126, {1,2,3,4,5}, {1}},
	[35] = {127, {1,2,3,4,5}, nosource = true},
	[36] = {128, {1,2,3,4,5}, nosource = true},
	[37] = {129, {1,2,3,4,5}, {1}},
	[38] = {130, {1,2,3,4,5}, {2}},
	[39] = {131, {1,2,4,5}, {1}},
	[40] = {132, {1,2,3,4,5}, nosource = true},
	[41] = {133, {1,2,3,4,5}, {2}},
	[42] = {134, {4}, {1,2,3,4,5}},
	[43] = {135, {1,2,3,4,5}, nosource = true},
	[44] = {136, {1,2,3,4,5}, {3,5}, multibarrel = true, helm_ban = true}, -- Both Castle BBothers
	[45] = {137, {1,2,3,4,5}, nosource = true, helm_ban = true},
	[46] = {138, {1,2,3,4,5}, nosource = true},
	[47] = {139, {1,2,3,4,5}, {5}},
	[48] = {140, {1,2,3,4,5}, {3,5}, multibarrel = true}, -- Both Castle Lobby & Crypt SSeek
	[49] = {141, {1,2,3,4,5}, {1}},
	[50] = {142, {1,2,3,4,5}, {3,4}, multibarrel = true}, -- Both Fungi & Caves Krazy KK
	[51] = {143, {1,2,3,4,5}, nosource = true},
	[52] = {144, {1,2,3,4,5}, {2}},
	[53] = {145, {1,2,3,4,5}, {1}},
	[54] = {146, {1,2,3,4,5}, {2}},
	[55] = {147, {1,2,3,4,5}, nosource = true},
	[56] = {148, {1,2,3,4,5}, {4}},
	[57] = {149, {1,2,3,4,5}, {4}},
	[58] = {150, {1,2,3,4,5}, {2}},
	[59] = {165, {1,2,3,4,5}, {2}, ishelm = true},
	[60] = {201, {2}, {2}, ishelm = true},
	[61] = {202, {1,2,3,4,5}, {3}, ishelm = true},
	[62] = {209, {5}, {5}, ishelm = true},
	[63] = {210, {4}, {4}, ishelm = true},
	[64] = {211, {1,2,3,4,5}, {5}, ishelm = true},
	[65] = {212, {1,2,3,4,5}, {1}, ishelm = true},
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
		selected_temp_value = randomBetween(1,#temporary_bonus_map_assortment);
		bonus_map_assortment[i] = temporary_bonus_map_assortment[selected_temp_value];
		table.remove(temporary_bonus_map_assortment, selected_temp_value);
	end
end

function getListOfCompliantMinigames(access_array,mode,available_maps_array,bmtable_reference)
	-- Mode = "or"/"and".
	-- If Or, any minigame which can be completed by any kong in array gets listed
	-- If And, any minigam which can be completed by all kongs in array gets listed
	compliantMinigames = {};
	compliance_counter = 0;
	for a = 1, #bonus_map_table do
		--print("");
		--print("Testing for bonus value "..a);
		valid = 0;
		if mode == "or" then
			--print("or path taken");
			for b = 1, #access_array do
				for c = 1, #bonus_map_table[a][2] do
					if access_array[b] == bonus_map_table[a][2][c] then
						valid = 1;
						--print("Set as a temporary valid count");
					end
				end
			end
		elseif mode == "and" then
			--print("and path taken");
			validity_counter = 0;
			for b = 1, #access_array do
				for c = 1, #bonus_map_table[a][2] do
					if access_array[b] == bonus_map_table[a][2][c] then
						validity_counter = validity_counter + 1;
					end
				end
			end
			--print("Validity Counter: "..validity_counter);
			if validity_counter == #access_array then
				valid = 1;
				--print("Set as a temporary valid count");
			end
		end
		in_available_maps_array = 0;
		for b = 1, #bonus_map_table do -- Total Bonus maps
			if available_maps_array[b] ~= nil then
				if a == available_maps_array[b] then
					in_available_maps_array = 1;
				end
			end
		end
		if in_available_maps_array == 0 then
			valid = 0;
		end
		if bonus_map_table[bmtable_reference].ishelm then
			if bonus_map_table[a].helm_ban then
				valid = 0;
			end
		end
		if valid == 1 then
			compliance_counter = compliance_counter + 1;
			compliantMinigames[compliance_counter] = a;
		end
	end
	return compliantMinigames;
end

function generateBonusAssortmentWithLogic()
	temp_available_maps_total = {};
	bonus_map_assortment = {};
	bonus_seedSetting = seedAsNumber * 100;
	for i = 1, # bonus_map_table do
		temp_available_maps_total[i] = i;
	end
	math.randomseed(bonus_seedSetting);
	bonus_map_table_with_source = {};
	bmt_withsource_counter = 0;
	for i = 1, #bonus_map_table do
		if not bonus_map_table[i].nosource then
			bmt_withsource_counter = bmt_withsource_counter + 1;
			bonus_map_table_with_source[bmt_withsource_counter] = i;
		end
	end
	for i = 1, #bonus_map_table_with_source do
		bmt_reference = bonus_map_table_with_source[i];
		entry_kongs = {};
		for j = 1, #bonus_map_table[bmt_reference][3] do
			entry_kongs[j] = bonus_map_table[bmt_reference][3][j];
		end
		if bonus_map_table[bmt_reference].multibarrel then
			minigames_list = getListOfCompliantMinigames(entry_kongs,"and",temp_available_maps_total,bmt_reference);
		else
			minigames_list = getListOfCompliantMinigames(entry_kongs,"or",temp_available_maps_total,bmt_reference);
		end
		selected_minigame = randomBetween(1,#minigames_list);
		bonus_map_assortment[bmt_reference] = minigames_list[selected_minigame];
		for j = 1, #bonus_map_table do
			if temp_available_maps_total[j] == minigames_list[selected_minigame] then
				table.remove(temp_available_maps_total, j);
			end
		end
		--print("");
		--print("PRINTING AVAILABLE MAPS TABLE AFTER "..i);
		--for j = 1, #bonus_map_table do
		--	print(temp_available_maps_total);
		--end
	end
end

generateBonusAssortmentWithLogic();

function testAssortment()
	-- Test if all bonus barrels in the game have an assigned minigame
	bmt_ws_counter = 0;
	for i = 1, #bonus_map_table_with_source do
		if bonus_map_assortment[bonus_map_table_with_source[i]] ~= nil then
			bmt_ws_counter = bmt_ws_counter + 1;
		end
	end
	if bmt_ws_counter == #bonus_map_table_with_source then
		print("ALL BARRELS HAVE MINIGAME: Passed");
	else
		print("ALL BARRELS HAVE MINIGAME: Failed");
		for i = 1, #bonus_map_table_with_source do
			if bonus_map_assortment[bonus_map_table_with_source[i]] == nil then
				print("Failed: "..i);
			end
		end
	end
	
	print("");
	
	-- Test that all minigames assigned are unique
	repeated_table = {};
	repeated_counter = 0;
	for i = 1, #bonus_map_table do
		if bonus_map_assortment[i] ~= nil then
			stored_map = bonus_map_assortment[i];
			for j = 1, #bonus_map_table do
				if i ~= j then
					if bonus_map_assortment[i] == bonus_map_assortment[j] then
						repeated_counter = repeated_counter + 1;
						repeated_table[repeated_counter] = i;
					end
				end
			end
		end
	end
	if #repeated_table == 0 then
		print("ALL MINIGAMES ARE UNIQUE: Passed");
	else
		print("ALL MINIGAMES ARE UNIQUE: Failed");
		for i = 1, #repeated_table do
			print("Failed: "..i);
		end
	end
end

function getBonusDestination(destmap)
	reference = nil;
	for i = 1, #bonus_map_table do
		if bonus_map_table[i][1] == destmap then
			reference = i;
		end
	end
	if reference == nil then
		return destmap;
	else
		value_to_lookup = bonus_map_assortment[reference];
		new_dmap_code = bonus_map_table[value_to_lookup][1];
		return new_dmap_code;
	end
end