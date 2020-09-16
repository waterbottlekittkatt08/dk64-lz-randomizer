require "modules.regularmaptable";
require "modules.lz_validation_data";

if settings.dev_replacer == 0 then
	lz_pairs = {
		{0x0400, 0x0702}, -- Japes Mountain (From Japes)
		--0x0600, -- Japes Minecart
		{0x0C00, 0x0701}, -- Japes Shellhive
		{0x0D00, 0x0705}, -- Japes Painting Room
		{0x2100, 0x0708}, -- Japes Underground
		--0x070E, -- Japes (From Minecart)
		{0x070F, 0xA901}, -- Japes (From Lobby)
		{0x2611, 0x0E00}, -- Aztec Beetle
		{0x1300, 0x2605}, -- Aztec DK 5DT
		{0x1500, 0x2606}, -- Aztec Diddy 5DT
		{0x1600, 0x2603}, -- Aztec Tiny 5DT
		{0x1700, 0x2607}, -- Aztec Lanky 5DT
		{0x1800, 0x2604}, -- Aztec Chunky 5DT
		{0x1A00, 0xAF01}, -- Factory (From Lobby)
		{0x1A03, 0x1D00}, -- Factory Power Shed
		{0x1A08, 0x2400}, -- Factory Crusher Room
		{0x1A10, 0x1B00}, -- Factory Car Race
		{0x1E00, 0xAE01}, -- Galleon (From Lobby)
		{0x1E01, 0x2B00}, -- Galleon Diddy 5DS
		{0x1E02, 0x2B01}, -- Galleon Chunky 5DS
		{0x1E03, 0x2B02}, -- Galleon Lanky 5DS
		{0x1E04, 0x2C00}, -- Galleon Pearl Chest
		{0x1E05, 0x2D00}, -- Galleon Mermaid Palace
		{0x1E06, 0x2E01}, -- Galleon Tiny 5DS
		{0x1E07, 0x2E00}, -- Galleon DK 5DS
		{0x1E08, 0x2F00}, -- Galleon Tiny 2DS
		{0x1E09, 0x2F01}, -- Galleon Lanky 2DS
		{0x1E0A, 0x3100}, -- Galleon Lighthouse
		{0x1E13, 0x2700}, -- Galleon Seal Race
		{0x1E15, 0xB300}, -- Galleon Submarine
		{0x2202, 0xA900}, -- Isles Japes Lobby
		{0x2203, 0xAD00}, -- Isles Aztec Lobby
		{0x2204, 0xAF00}, -- Isles Factory Lobby
		{0x2205, 0xAE00}, -- Isles Galleon lobby
		{0x2206, 0xB200}, -- Isles Fungi Lobby
		{0x2208, 0xBD00}, -- Isles BFI
		{0x2209, 0xC300}, -- Isles Snide Room
		{0x220A, 0xC200}, -- Isles Caves Lobby
		{0x220B, 0xC100}, -- Isles Castle Lobby
		{0x2600, 0xAD01}, -- Aztec (From Lobby)
		{0x3000, 0xB201}, -- Fungi (From Lobby)
		{0x3001, 0x3A00}, -- Fungi Lanky Attic
		{0x3002, 0x3900}, -- Fungi Winch Room
		{0x3003, 0x3800}, -- Fungi Dark Attic
		{0x3004, 0x3B00}, -- Fungi DK Barn
		{0x3005, 0x3E00}, -- Fungi Mill Front (PPunch Door)
		{0x3006, 0x3D00}, -- Fungi Mill Rear (W1 Door)
		{0x3007, 0x3E03}, -- Fungi Mill Rear (Tiny Door)
		{0x3008, 0x4000}, -- Fungi GM (Low)
		{0x3009, 0x4002}, -- Fungi GM (Lower Middle)
		{0x300A, 0x4001}, -- Fungi GM (Middle)
		{0x300B, 0x4003}, -- Fungi GM (Upper Middle)
		{0x300C, 0x4004}, -- Fungi GM (High)
		{0x300D, 0x4700}, -- Fungi Face Puzzle
		{0x300E, 0x3F00}, -- Fungi Light Room
		{0x300F, 0x4600}, -- Fungi Dark Room
		{0x3017, 0x3400}, -- Fungi (From Anthill)
		--0x3300, -- Galleon Mech Fish
		{0x3C00, 0x3E01}, -- Fungi Spider Boss
		{0x3D01, 0x3E02}, -- Fungi Mill Front > Back Link
		{0x4800, 0xC201}, -- Caves (From Lobby)
		{0x4801, 0x6400}, -- Caves (From Diddy 5DI)
		{0x4802, 0x5600}, -- Caves (From DK 5DI)
		{0x4803, 0x5500}, -- Caves (From Lanky 5DI)
		{0x4804, 0x5F00}, -- Caves (From Chunky 5DI)
		{0x4805, 0x5400}, -- Caves (From Tiny 5DI)
		{0x4806, 0x5200}, -- Caves (From Beetle Race)
		{0x480E, 0x5B00}, -- Caves (From DK 5DC)
		{0x480F, 0x5A00}, -- Caves (From Chunky 5DC)
		{0x4810, 0x5D00}, -- Caves (From Tiny 5DC)
		{0x4811, 0x5C00}, -- Caves (From Diddy 5DC [Enemies/Lower])
		{0x4812, 0xC800}, -- Caves (From Diddy 5DC [Candles/Upper])
		{0x4813, 0x5900}, -- Caves (From Rotating Room)
		{0x4814, 0x5E00}, -- Caves (From Sprint Cabin/1DC)
		{0x481E, 0x6200}, -- Caves (From Ice Castle)
		{0x5700, 0xC101}, -- Castle (From Lobby)
		--0x5701, -- Castle (From Tree Exit)
		{0x5702, 0x9700}, -- Castle (From Dungeon Tunnel [Near])
		{0x5704, 0xB700}, -- Castle (From Crypt [Hub])
		{0x5705, 0x9702}, -- Castle (From Dungeon Tunnel [Far])
		{0x5707, 0x7100}, -- Castle (From Museum)
		{0x5708, 0xA800}, -- Castle (From Greenhouse [Front])
		{0x5709, 0xA600}, -- Castle (From Shed)
		{0x570B, 0x5800}, -- Castle (From Ballroom)
		{0x570C, 0x7200}, -- Castle (From Library [Entrance])
		{0x570D, 0x7201}, -- Castle (From Library [Exit])
		{0x570E, 0x6900}, -- Castle (From Wind Tower)
		{0x570F, 0xA400}, -- Castle From Tree
		{0x5710, 0xA700}, -- Castle (From Trash Can)
		{0x7001, 0x6A00}, -- Castle DDC Crypt (From Minecart)
		--0x5714, -- Castle (From Greenhouse Rear)
		{0x5801, 0x7102}, -- Castle Ballroom (From Museum)
		{0x6C00, 0xB704}, -- Castle Crypt [L/T] (From Crypt [Hub])
		{0x7000, 0xB703}, -- Castle Crypt [D/Di/T] (From Crypt [Hub])
		{0x7101, 0xB900}, -- Castle Museum (From Castle Car Race)
		{0x9704, 0xA300} -- Castle Tunnel (From Dungeon)
		--0xA400, -- Castle Tree (From Castle)
	};
elseif settings.dev_replacer == 1 then
	lz_pairs = {
		{0x0400, 0x0702}, -- Japes Mountain (From Japes)
		--0x0600, -- Japes Minecart
		{0x0C00, 0x0701}, -- Japes Shellhive
		{0x0D00, 0x0705}, -- Japes Painting Room
		{0x2100, 0x0708}, -- Japes Underground
		--0x070E, -- Japes (From Minecart)
		{0x1300, 0x2605}, -- Aztec DK 5DT
		{0x1500, 0x2606}, -- Aztec Diddy 5DT
		{0x1600, 0x2603}, -- Aztec Tiny 5DT
		{0x1700, 0x2607}, -- Aztec Lanky 5DT
		{0x1800, 0x2604}, -- Aztec Chunky 5DT
		{0x1A03, 0x1D00}, -- Factory Power Shed
		{0x1A08, 0x2400}, -- Factory Crusher Room
		{0x1E01, 0x2B00}, -- Galleon Diddy 5DS
		{0x1E02, 0x2B01}, -- Galleon Chunky 5DS
		{0x1E03, 0x2B02}, -- Galleon Lanky 5DS
		{0x1E04, 0x2C00}, -- Galleon Pearl Chest
		{0x1E05, 0x2D00}, -- Galleon Mermaid Palace
		{0x1E06, 0x2E01}, -- Galleon Tiny 5DS
		{0x1E07, 0x2E00}, -- Galleon DK 5DS
		{0x1E08, 0x2F00}, -- Galleon Tiny 2DS
		{0x1E09, 0x2F01}, -- Galleon Lanky 2DS
		{0x1E0A, 0x3100}, -- Galleon Lighthouse
		{0x1E15, 0xB300}, -- Galleon Submarine
		{0x2202, 0xA900}, -- Isles Japes Lobby
		{0x2203, 0xAD00}, -- Isles Aztec Lobby
		{0x2204, 0xAF00}, -- Isles Factory Lobby
		{0x2205, 0xAE00}, -- Isles Galleon lobby
		{0x2206, 0xB200}, -- Isles Fungi Lobby
		{0x2208, 0xBD00}, -- Isles BFI
		{0x2209, 0xC300}, -- Isles Snide Room
		{0x220A, 0xC200}, -- Isles Caves Lobby
		{0x220B, 0xC100}, -- Isles Castle Lobby
		{0x3001, 0x3A00}, -- Fungi Lanky Attic
		{0x3002, 0x3900}, -- Fungi Winch Room
		{0x3003, 0x3800}, -- Fungi Dark Attic
		{0x3004, 0x3B00}, -- Fungi DK Barn
		{0x3005, 0x3E00}, -- Fungi Mill Front (PPunch Door)
		{0x3006, 0x3D00}, -- Fungi Mill Rear (W1 Door)
		{0x3007, 0x3E03}, -- Fungi Mill Rear (Tiny Door)
		{0x3008, 0x4000}, -- Fungi GM (Low)
		{0x3009, 0x4002}, -- Fungi GM (Lower Middle)
		{0x300A, 0x4001}, -- Fungi GM (Middle)
		{0x300B, 0x4003}, -- Fungi GM (Upper Middle)
		{0x300C, 0x4004}, -- Fungi GM (High)
		{0x300D, 0x4700}, -- Fungi Face Puzzle
		{0x300E, 0x3F00}, -- Fungi Light Room
		{0x300F, 0x4600}, -- Fungi Dark Room
		{0x3017, 0x3400}, -- Fungi (From Anthill)
		--0x3300, -- Galleon Mech Fish
		{0x3C00, 0x3E01}, -- Fungi Spider Boss
		{0x3D01, 0x3E02}, -- Fungi Mill Front > Back Link
		{0x4801, 0x6400}, -- Caves (From Diddy 5DI)
		{0x4802, 0x5600}, -- Caves (From DK 5DI)
		{0x4803, 0x5500}, -- Caves (From Lanky 5DI)
		{0x4804, 0x5F00}, -- Caves (From Chunky 5DI)
		{0x4805, 0x5400}, -- Caves (From Tiny 5DI)
		{0x480E, 0x5B00}, -- Caves (From DK 5DC)
		{0x480F, 0x5A00}, -- Caves (From Chunky 5DC)
		{0x4810, 0x5D00}, -- Caves (From Tiny 5DC)
		{0x4811, 0x5C00}, -- Caves (From Diddy 5DC [Enemies/Lower])
		{0x4812, 0xC800}, -- Caves (From Diddy 5DC [Candles/Upper])
		{0x4813, 0x5900}, -- Caves (From Rotating Room)
		{0x4814, 0x5E00}, -- Caves (From Sprint Cabin/1DC)
		{0x481E, 0x6200}, -- Caves (From Ice Castle)
		--0x5701, -- Castle (From Tree Exit)
		{0x5702, 0x9700}, -- Castle (From Dungeon Tunnel [Near])
		{0x5704, 0xB700}, -- Castle (From Crypt [Hub])
		{0x5705, 0x9702}, -- Castle (From Dungeon Tunnel [Far])
		{0x5707, 0x7100}, -- Castle (From Museum)
		{0x5708, 0xA800}, -- Castle (From Greenhouse [Front])
		{0x5709, 0xA600}, -- Castle (From Shed)
		{0x570B, 0x5800}, -- Castle (From Ballroom)
		{0x570C, 0x7200}, -- Castle (From Library [Entrance])
		{0x570D, 0x7201}, -- Castle (From Library [Exit])
		{0x570E, 0x6900}, -- Castle (From Wind Tower)
		{0x570F, 0xA400}, -- Castle From Tree
		{0x5710, 0xA700}, -- Castle (From Trash Can)
		{0x7001, 0x6A00}, -- Castle DDC Crypt (From Minecart)
		--0x5714, -- Castle (From Greenhouse Rear)
		{0x5801, 0x7102}, -- Castle Ballroom (From Museum)
		{0x6C00, 0xB704}, -- Castle Crypt [L/T] (From Crypt [Hub])
		{0x7000, 0xB703}, -- Castle Crypt [D/Di/T] (From Crypt [Hub])
		{0x9704, 0xA300} -- Castle Tunnel (From Dungeon)
		--0xA400, -- Castle Tree (From Castle)
	};
end

function generateRegularMapTable()
	regular_map_table = {};
	for i = 1, #lz_pairs do
		table.insert(regular_map_table, lz_pairs[i][1]);
		table.insert(regular_map_table, lz_pairs[i][2]);
	end
end

function generateLoadingZoneChain()
	pair_available = {};
	paired_set = {};
	for i = 1, #lz_pairs do
		pair_available[i] = true;
		paired_set[i] = 0;
	end
	for i = 1, #lz_pairs do
		--if pair_available[i] then
			available_array = {};
			for j = 1, #pair_available do
				if pair_available[j] and (j ~= i) then
					table.insert(available_array,j)
				end
			end
			-- print(available_array)
			selected_set = available_array[randomBetween(1,#available_array)];
			--print(i.." > "..selected_set)
			paired_set[i] = selected_set;
			pair_available[selected_set] = false;
		--end
	end
end

--[[
A LZ Set is 2 loading zones where entering one takes you to the entrance
value associated to the other loading zone.
For Example: Entering Factory from Lobby and going back from Factory to Lobby
are a set

Lets say Painting Room LZ Set (S1) and Power Shed LZ Set (S2) are paired
Painting Room Entrance = 0x0D00 > E1
Japes from Painting Room = 0x0705 > E2
Factory from Power Shed = 0x1A03 > E1
Factory Power Shed = 0x1D00 > E2

paired_set = {
	S1 = S2,
	S2 = S3,
	S3 = S1,
}

S1E1 > S2E1
S2E2 > S1E2

This essentially generates LZ Chains

S1    S2    S3

E1 -> E1 -> E1
|     |     |
E2 <- E2 <- E2


Original Dest 0D00
New Dest 1A03

Original Dest 1D00
New Dest 0705
]]--

function getNewDestinationCode(old_destination_code)
	for i = 1, #lz_pairs do
		if lz_pairs[i][1] == old_destination_code then
			linked_set = paired_set[i];
			chain_link = 1;
		elseif lz_pairs[i][2] == old_destination_code then
			for j = 1, #paired_set do
				if paired_set[j] == i then
					linked_set = j;
				end
			end
			chain_link = 2;
		end
	end
	--print(old_destination_code)
	new_destination_code = lz_pairs[linked_set][chain_link];
	return new_destination_code
end


function generateAssortmentObject()
	generateRegularMapTable();
	generateLoadingZoneChain();
	regular_map_assortment = {};
	for i = 1, #regular_map_table do
		old_code = regular_map_table[i];
		new_code = getNewDestinationCode(old_code);
		reference = nil;
		for j = 1, #regular_map_table do
			if regular_map_table[j] == new_code then
				reference = j;
			end
		end
		if reference == nil then
			--print("nil")
			table.insert(regular_map_assortment,i);
		else
			--print("non-nil")
			table.insert(regular_map_assortment,reference);
		end
		--print(regular_map_assortment)
		--print(i.." > "..regular_map_assortment[i]);
	end
end

function validateAssortment()
	accessed_maps = {0x22}; -- Always start in isles
	access_kongs = {1};
	if settings.all_kongs == 1 then
		access_kongs = {1,2,3,4,5};
	end
	accessed_maps_by_kong = {}
	for i = 0, 215 do
		accessed_maps_by_kong[i] = {};
	end
	for i = 1, #access_kongs do
		table.insert(accessed_maps_by_kong[0x22],access_kongs[i]);
	end
	keys_acquired = {};
	for i = 1, #antikeys_table do
		table.insert(keys_acquired,antikeys_table[i]); -- Not defined?
	end
	exploreAccessibility()
end

function exploreAccessibility()
	for i = 1, #accessed_maps do
		assessMap(accessed_maps[i],accessed_maps_by_kong[accessed_maps[i]])
	end
end

function assessMap(map_val,kong_list)
	-- Check for Pause Exit Trick
	for i = 1, #pause_exit_maps do
		pe_map = pause_exit_maps[i];
		for j = 1, #pause_exit_trick[pe_map] do
			if map_val == pause_exit_trick[pe_map][j] then
				accessed_maps = pushToList(accessed_maps,pe_map);
				for k = 1, #kong_list do
					accessed_maps_by_kong[pe_map] = pushToList(accessed_maps_by_kong[pe_map],kong_list[k])
				end
			end
		end
	end
	-- Check for kongs which can be freed
	for i = 1, #kong_free_maps do
		if kong_free_maps[i] == map_val then
			access_kongs = pushToList(access_kongs, i);
		end
	end
	-- Checks for T&S in map which can be accessed
	boss_maps = {0x8, 0xC5, 0x9A, 0x6F, 0x53, 0xC4, 0xC7};
	for i = 1, #maps_with_tns do
		for j = 1, #maps_with_tns[i] do
			if map_val == j then -- is a map with T&S
				kong_required = boss_door_assortment[boss_map_assortment[i]];
				has_kong = false;
				for k = 1, #access_kongs do
					if access_kongs[k] == kong_required then
						has_kong = true
					end
				end
				if has_kong then
					boss = boss_maps[boss_map_assortment[i]];
					keys_acquired = pushToList(keys_acquired,i);
					accessed_maps = pushToList(accessed_maps,boss);
					accessed_maps_by_kong[boss] = pushToList(accessed_maps_by_kong[boss],kong_required);
					accessed_maps = pushToList(accessed_maps,0x2A) -- T&S
					for k = 1, #access_kongs do
						accessed_maps_by_kong[0x2A] = pushToList(accessed_maps_by_kong[0x2A],access_kongs[k]);
					end
					if boss == 0xC7 then -- Kut Out
						access_kongs = {1,2,3,4,5};
					end
				end
			end
		end
	end
	-- Get array of accessible maps and access kong arrays
	lz_origin_map_keys = {};
	for k, v in pairs(lz_origin_map_table) do
		table.insert(lz_origin_map_keys,k)
	end

	for i = 1, #lz_origin_map_keys do
		for j = 1, #lz_origin_map_table[lz_origin_map_keys[i]] do
			if lz_origin_map_table[lz_origin_map_keys[i]][j] == map_val then -- exit code is possible exit under *some* circumstance we may not have obtained yet
				-- Determine whether we have kong to open gateway to loading zone if necessary
				valid_entrance_test_one = false;
				has_extra_conditions_test_one = false;
				for k, v in pairs(also_requires_kong_map_table) do
					if k == lz_origin_map_keys[i] then
						has_extra_conditions_test_one = true;
						for l = 1, #access_kongs do
							if v == access_kongs[l] then
								valid_entrance_test_one = true;
							end
						end
					end
				end
				if not has_extra_conditions_test_one then -- If no conditions, accept as passing test one
					valid_entrance_test_one = true;
				end

				-- Determine if we have entered a required map in order for a map to open
				valid_entrance_test_two = false;
				has_extra_conditions_test_two = false;
				for k, v in pairs(also_requires_reached_map_table) do
					if k == lz_origin_map_keys[i] then
						has_extra_conditions_test_two = true;
						for l = 1, #accessed_maps do
							if v == accessed_maps[l] then
								valid_entrance_test_two = true;
							end
						end
					end
				end
				if not has_extra_conditions_test_two then -- If no conditions, accept as passing test two
					valid_entrance_test_two = true;
				end

				-- Determine if lobbies are open
				valid_entrance_test_three = false;
				has_extra_conditions_test_three = false;
				if map_val == 0x22 then -- in Isles
					new_map = getDestinationMapFromCode(lz_origin_map_keys[i]);
					for k = 1, #lobby_data do
						if new_map == lobby_data[k][0] then
							has_extra_conditions_test_three = true;
							has_all_keys = true;
							for l = 1, #lobby_data[k][1] do
								has_key = false;
								for m = 1, #keys_acquired do
									if keys_acquired[m] == lobby_data[k][1][l] then
										has_key = true;
									end
								end
								if not has_key then
									has_all_keys = false;
								end
							end
							if has_all_keys then
								valid_entrance_test_three = true;
							else
								valid_entrance_test_three = false;
							end
						end
					end
				end
				if not has_extra_conditions_test_three then -- If no conditions, accept as passing test three
					valid_entrance_test_three = true;
				end

				-- Generate list of non-permitted kongs
				banned_kongs = {};
				for k = 1, #inaccessible_map_table_DK do
					if k == lz_origin_map_keys[i] then
						table.insert(banned_kongs,1);
					end
				end
				for k = 1, #inaccessible_map_table_Diddy do
					if k == lz_origin_map_keys[i] then
						table.insert(banned_kongs,2);
					end
				end
				for k = 1, #inaccessible_map_table_Lanky do
					if k == lz_origin_map_keys[i] then
						table.insert(banned_kongs,3);
					end
				end
				for k = 1, #inaccessible_map_table_Tiny do
					if k == lz_origin_map_keys[i] then
						table.insert(banned_kongs,4);
					end
				end
				for k = 1, #inaccessible_map_table_Chunky do
					if k == lz_origin_map_keys[i] then
						table.insert(banned_kongs,5);
					end
				end

				-- Generate access list for next map
				access_list = {};
				for k = 1, #access_kongs do
					banned = false;
					for l = 1, #banned_kongs do
						if l == k then -- kong banned
							banned = true;
						end
					end
					if not banned then
						table.insert(access_list,k)
					end
				end

				if valid_entrance_test_one and valid_entrance_test_two and valid_entrance_test_three then
					new_map = getNewDestinationCode(lz_origin_map_keys[i]);
					new_map_is_tagless = false;
					for k = 1, #tagless_map_table do
						if tagless_map_table[k][0] == getDestinationMapFromCode(new_map) then
							new_map_is_tagless = true;
						end
					end
					if not new_map_is_tagless then
						access_list = {};
						for k = 1, #access_kongs do
							table.insert(access_list, access_kongs[k]);
						end
					end
					for k = 1, #access_list do
						accessed_maps_by_kong[new_map] = pushToList(accessed_maps_by_kong[new_map],access_list[k]);
					end
				end
			end
		end
	end
end

function pushToList(list,value)
	list_copy = list;
	value_present = false;
	if list_copy then
		for i = 1, #list_copy do
			if list_copy[i] == value then
				value_present = true;
			end
		end
		if not value_present then
			table.insert(list_copy,value);
		end
	else
		list_copy = {};
		table.insert(list_copy,value);
	end
	return list_copy
end

function getCodeFromDestination()
	destination_map = mainmemory.read_u32_be(Mem.dmap);
	destination_exit = mainmemory.read_u32_be(Mem.dexit);
	code = (256 * destination_map) + destination_exit;
	return code;
end

function getDestinationMapFromCode(destination_code)
	destination_map = destination_code - (destination_code % 256);
	return destination_map;
end

function getDestinationExitFromCode(destination_code)
	destination_exit = destination_code % 256;
	return destination_exit;
end


generateAssortmentObject();
require "modules.replaceLZCode";