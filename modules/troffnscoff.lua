-- T&S Door Number
-- Random Boss Kong
-- Handle Boss Randomisation (If no randomisation, default to regular assortment)
-- Key Randomisation

levels_needed_count = { --not counting helm
	[1] = 2, -- Short
	[2] = 4, -- Standard
	[3] = 7, -- Long
};

boss_door_kong_permits = {
	[1] = {1, 2, 3, 4, 5}, -- Army Dillo 1
	[2] = {1, 2, 3, 4, 5}, -- Dogadon 1
	[3] = {4, 5}, -- Mad Jack
	[4] = {2, 3, 4, 5}, -- Pufftoss
	[5] = {5}, -- Dogadon 2
	[6] = {1, 2, 3, 5}, -- Army Dillo 2
	[7] = {1, 2, 3, 4}, -- King Kut Out
};

variance = { --not counting helm
	[1] = 0.2, -- Short
	[2] = 0.2, -- Standard
	[3] = 0.1, -- Long
};

--Short ---- 80 per needed door (old: 71)
--Standard - 120 per needed door (old: 142)
--Long ----- 160 per needed door (old: 214)
boss_needed_door_range = { -- Normal amount is 1680
	[1] = (40 * (settings.gameLengths + 1) * levels_needed_count[settings.gameLengths] * (1 - variance[settings.gameLengths])), -- Min
	[2] = (40 * (settings.gameLengths + 1) * levels_needed_count[settings.gameLengths] * (1 + variance[settings.gameLengths])), -- Max
};

boss_unneeded_door_range = {
	[1] = (40 * (settings.gameLengths + 1) * (7-levels_needed_count[settings.gameLengths]) * (1 - variance[settings.gameLengths])), -- Min
	[2] = (40 * (settings.gameLengths + 1) * (7-levels_needed_count[settings.gameLengths]) * (1 + variance[settings.gameLengths])), -- Max
};

print("boss_needed_door_range: "..boss_needed_door_range[1].." - "..boss_needed_door_range[2]);
print("boss_unneeded_door_range: "..boss_unneeded_door_range[1].." - "..boss_unneeded_door_range[2]);

boss_map_table = {
	[1] = 8, -- Army 1
	[2] = 197, -- Dog 1
	[3] = 154, -- MJ
	[4] = 111, -- Puff
	[5] = 83, -- Dog 2
	[6] = 196, -- Army 2
	[7] = 199, -- KKO
};

tns_parent_maps_table = {
	[1] = {0x7}, -- Japes (Japes Main Map)
	[2] = {0x26}, -- Aztec (Aztec Main, 
	[3] = {0x1A}, -- Factory
	[4] = {0x1E}, -- Galleon
	[5] = {0x30}, -- Fungi
	[6] = {0x48}, -- Caves
	[7] = {0x57, 0x97, 0xB7}, -- Castle
};

level_tns_inputs = {
	[1] = 397, -- Japes
	[2] = 281, -- Aztec
	[3] = 345, -- Factory
	[4] = 353, -- Galleon
	[5] = 322, -- Fungi
	[6] = 322, -- Caves
	[7] = 350, -- Castle
};

boss_key_flag_addresses = {
	[1] = 0x0258FA, -- Army 1
	[2] = 0x02C136, -- Dog 1
	[3] = 0x035676, -- MJ
	[4] = 0x02A0C2, -- Puff
	[5] = 0x02B3F6, -- Dog 2
	[6] = 0x025C4E, -- Army 2
	[7] = 0x0327EE, -- KKO
};

tns_hard_cap = 350;
tns_ratios = {3,5,6};

if settings.randomiser == 0 then
	boss_map_assortment = {1, 2, 3, 4, 5, 6, 7};
end

function generateCaps()
	level_tns_caps = {};
	for i = 1, #level_tns_inputs do
		update_cap = level_tns_inputs[i] * (tns_ratios[settings.gameLengths] / 7);
		update_cap = math.floor(update_cap / 5);
		level_tns_caps[i] = update_cap * 5;
	end
	
	for i = 1, #level_tns_caps do
		if level_tns_caps[i] > tns_hard_cap then
			level_tns_caps[i] = tns_hard_cap;
		end
	end
end

function generateTnSNumberAssortment()
	tns_number_seedSetting = seedAsNumber + 120;
	math.randomseed(tns_number_seedSetting);
	generateCaps(); --sets upper limit for each level tns Count
	
	--variable to hold final tns counts
	tns_number_assortment = {};
	for i = 1, 7 do
		tns_number_assortment[i] = 0;
	end
	
	num_levels_needed = levels_needed_count[settings.gameLengths];
	num_levels_unneeded = 7 - num_levels_needed;

	--Generates probability array for the needed levels (based on needed_keys)
	--each level appears between 1 and 7 times
	tns_needed_probability_array = {};
	tns_array_counter = 0;
	for i = 1, num_levels_needed do
		relative_probability = randomBetween(1,7);
		for j = 1, relative_probability do
			tns_array_counter = tns_array_counter + 1;
			tns_needed_probability_array[tns_array_counter] = needed_keys[i];
		end
	end
	
	--Generates probability array for the unneeded levels (based on antikeys_table)
	--each level appears between 1 and 7 times
	tns_unneeded_probability_array = {};
	tns_array_counter = 0;
	for i = 1, num_levels_unneeded do
		relative_probability = randomBetween(1,7);
		for j = 1, relative_probability do
			tns_array_counter = tns_array_counter + 1;
			tns_unneeded_probability_array[tns_array_counter] = antikeys_table[i];
		end
	end
	
	--Picks random sum of all doors, rounded down to nearest multiple of 5
	tns_total_temp = randomBetween(boss_needed_door_range[1],boss_needed_door_range[2]);
	tns_total_needed = tns_total_temp - (tns_total_temp % 5);
	
	print("tns_total_needed: "..tns_total_needed);
	
	--Assigning to all needed levels first
	--for every division of 5 bananas
	for i = 1, (tns_total_needed / 5) do
		--Select random level out of the probability array
		selected_index = randomBetween(1,#tns_needed_probability_array);
		selected_level = tns_needed_probability_array[selected_index];
		
		--Add 5 bananas to that level
		tns_number_assortment[selected_level] = tns_number_assortment[selected_level] + 5;

		--If the selected level reached its cap, remove it from the probability array
		list_to_remove = {};
		removal_count_tns = 0;
		if tns_number_assortment[selected_level] == level_tns_caps[selected_level] then
			for j = 1, #tns_needed_probability_array do
				if tns_needed_probability_array[j] == selected_level then
					removal_count_tns = removal_count_tns + 1;
					list_to_remove[removal_count_tns] = j;
				end
			end
		end
		if #list_to_remove > 0 then
			for j = #list_to_remove, 1, -1 do
				table.remove(tns_needed_probability_array, list_to_remove[j]);
			end
		end
	end
	
	tns_total_temp = randomBetween(boss_unneeded_door_range[1],boss_unneeded_door_range[2]);
	tns_total_unneeded = tns_total_temp - (tns_total_temp % 5);
	
	print("tns_total_unneeded: "..tns_total_unneeded);
	
	--Assigning to remaining (unneeded) levels
	--for every division of 5 bananas
	for i = 1, (tns_total_unneeded / 5) do
		--Select random level out of the probability array
		selected_index = randomBetween(1,#tns_unneeded_probability_array);
		selected_level = tns_unneeded_probability_array[selected_index];
		
		--Add 5 bananas to that level
		tns_number_assortment[selected_level] = tns_number_assortment[selected_level] + 5;

		--If the selected level reached its cap, remove it from the probability array
		list_to_remove = {};
		removal_count_tns = 0;
		if tns_number_assortment[selected_level] == level_tns_caps[selected_level] then
			for j = 1, #tns_unneeded_probability_array do
				if tns_unneeded_probability_array[j] == selected_level then
					removal_count_tns = removal_count_tns + 1;
					list_to_remove[removal_count_tns] = j;
				end
			end
		end
		if #list_to_remove > 0 then
			for j = #list_to_remove, 1, -1 do
				table.remove(tns_unneeded_probability_array, list_to_remove[j]);
			end
		end
	end
end

function generateListOfNeededKeys()
	amount_needed = levels_needed_count[settings.gameLengths] + 1;	--plus 1 for key 8
	temporary_keys_table = {};
	needed_keys = {};
	keys_seedSetting = seedAsNumber + 8;
	for i = 1, 7 do
		temporary_keys_table[i] = i;
	end
	math.randomseed(keys_seedSetting);
	for i = 1, (amount_needed - 1) do
		selected_temp_value = randomBetween(1,#temporary_keys_table);
		needed_keys[i] = temporary_keys_table[selected_temp_value];
		table.remove(temporary_keys_table, selected_temp_value);
	end
	needed_keys[amount_needed] = 8; -- Always need key 8
end

function generateListOfUnneededKeys()
	antikeys_table = {};
	antikeys_count = 0;
	for i = 1, 8 do
		keyNeeded = false;
		for j = 1, #needed_keys do
			if needed_keys[j] == i then
				keyNeeded = true;
			end
		end
		if not keyNeeded then
			antikeys_count = antikeys_count + 1;
			antikeys_table[antikeys_count] = i;
		end
	end
	fileFlagsCount = #newFileFlags;
	for i = 1, #antikeys_table do
		key_to_set = antikeys_table[i];
		turnedInByte = keys[key_to_set][4][1];
		turnedInBit = keys[key_to_set][4][2];
		newFileFlags[fileFlagsCount + i] = {turnedInByte,turnedInBit}; -- K-Lumsy Key
	end
end

function generateBossDoorAssortment()
	boss_door_assortment = {};
	boss_door_seedSetting = seedAsNumber + 5;
	math.randomseed(boss_door_seedSetting);
	for i = 1, #boss_door_kong_permits do
		selected_temp_value = randomBetween(1,#boss_door_kong_permits[i]);
		boss_door_assortment[i] = boss_door_kong_permits[i][selected_temp_value];
	end
end

function generateBLockerAssortment()
	b_locker_assortment = {};
	b_locker_assortment[8] = 100 / (2 ^ (3 - settings.gameLengths));
	b_locker_seedSetting = seedAsNumber + 801;
	math.randomseed(b_locker_seedSetting);
	for i = 1, 7 do
		b_locker_assortment[i] = randomBetween(1,b_locker_assortment[8] - 1);
	end
end

function setTnSAssortments()
	generateBossDoorAssortment();
	generateBLockerAssortment();
	generateListOfNeededKeys();
	generateListOfUnneededKeys();
	generateTnSNumberAssortment();
end

function setTnSDoorStuff()
	for i = 0, 6 do
		mainmemory.write_u16_be(Mem.tnsdoor_header[version] + (2 * i), tns_number_assortment[i + 1]);
	end
	for i = 0, 7 do
		mainmemory.write_u16_be(Mem.tnsdoor_header[version] + 0x10 + (2 * i), b_locker_assortment[i + 1]);
	end
	for i = 1, 7 do
		boss_assigned = boss_map_assortment[i]; -- check the value of the boss assigned to it
		kong_assigned = boss_door_assortment[boss_assigned];-- Use that value as a lookup for the kong used
		mainmemory.writebyte(Mem.tnsdoor_header[version] + 0x30 + (i - 1), kong_assigned - 1); -- Set that value of kong
	end
end

function getKeyNumberFromBossMap(input)
	selected_key_number = 0;
	for i = 1, #boss_map_assortment do
		if boss_map_table[boss_map_assortment[i]] == input then
			selected_key_number = i;
		end
	end
	if selected_key_number > 0 then
		return selected_key_number;
	end
	return 0;
end

function changeKeyFlag()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	boss_number = 0;
	for i = 1, #boss_map_table do
		if boss_map_table[i] == current_cmap then
			boss_number = i;
		end
	end
	if boss_number > 0 then -- Is Boss
		for i = 1, 7 do
			boss_map = boss_map_table[i];
			key_output = getKeyNumberFromBossMap(boss_map);
			key_byte = keys[key_output][2][1];
			key_bit = keys[key_output][2][2];
			key_flag_data = (key_byte * 8) + key_bit;
			mainmemory.write_u16_be(boss_key_flag_addresses[i],key_flag_data);
		end
	end
end

event.onframestart(changeKeyFlag, "Alters Key flags of spawned key and checked flag for spawning");