function dkoupled_init()
	available_pairs = regenerateAvailablePairs({});
	generatePriorityMaps();
	generateNoRestrictionsArray();
	generatePopularExitsArray();

end

function generatePriorityMaps()
	local base_priority_maps = {
		{0x4, 0x6, 0x7, 0xC, 0xD, 0x21, 0x25, 0xA9}, -- Japes Set
		{0x1A, 0x1B, 0x1D, 0x24, 0x6E, 0xAF}, -- Factory Set

	};
	priority_maps = {};
	print("Available Pairs: "..#available_pairs)
	--[[
	for i = 1, #available_pairs do
		print(bizstring.hex(available_pairs[i][1]))
		print(bizstring.hex(available_pairs[i][2]))
	end
	]]--
	for i = 1, #base_priority_maps do
		local temp_priority_map_set = {};
		for j = 1, #base_priority_maps[i] do
			local available = false;
			for k = 1, #available_pairs do
				for m = 1, #available_pairs[k] do
					if ((available_pairs[k][m] - (available_pairs[k][m] % 256)) / 256) == base_priority_maps[i][j] then
						available = true;
					end
				end
			end
			if available then
				table.insert(temp_priority_map_set,base_priority_maps[i][j]);
			end
		end
		table.insert(priority_maps,temp_priority_map_set);
	end
end


priority_map_connections = { -- Aztec, Galleon, Fungi, Caves, Castle, Isles
	0x1E, 0x26, 0x30, 0x48, 0x57, 0x22
};

function generateNoRestrictionsArray()
	local base_no_restrictions = {
		0x2600, 0x2608, 0x2609, 0x260A, 0x260C, 0x260D, 0x260E, 0x260F, 0x2610, 0x2612, -- Aztec
		0x1E00, 0x1E0A, 0x1E0C, 0x1E0D, 0x1E0E, 0x1E11, 0x1E12, 0x1E14, 0x1E16, 0x1E17, -- Galleon
		0x3000, 0x3001, 0x3006, 0x3008, 0x3009, 0x300A, 0x300B, 0x300C, 0x3011, 0x3012, 0x3013, 0x3014, 0x3015, 0x3016, 0x3018, 0x3019, -- Fungi
		0x4800, 0x480C, 0x480D, 0x4815, 0x4816, 0x4817, 0x4818, 0x4819, 0x481A, -- Caves
		0x5700, 0x5702, 0x5703, 0x5704, 0x5705, 0x5706, 0x5712, 0x5713, -- Castle
		0x2200, 0x2201, 0x2202, -- Isles
	};
	local keys_access_table = {
		{0x2203}, -- Key 1
		{0x2204, 0x2205, 0x2209}, -- Key 2
		{}, -- Key 3
		{0x2206}, -- Key 4
		{0x220A,0x220B}, -- Key 5
		{}, -- Key 6
		{}, -- Key 7
		{}, -- Key 8
	};
	for i = 1, #antikeys_table do
		local zones_opened_by_key = keys_access_table[antikeys_table[i]];
		if #zones_opened_by_key > 0 then
			for j = 1, #zones_opened_by_key do
				table.insert(base_no_restrictions, zones_opened_by_key[j]);
			end
		end
	end
	priority_map_connections_no_restrictions = {};
	for i = 1, #available_pairs do
		for j = 1, 2 do
			local focused_code = available_pairs[i][j];
			local is_in_base = false;
			for k = 1, #base_no_restrictions do
				if base_no_restrictions[k] == focused_code then
					is_in_base = true;
				end
			end
			if is_in_base then
				table.insert(priority_map_connections_no_restrictions, focused_code);
			end
		end
	end
end

function generatePopularExitsArray()
	popular_exits = {};
	for pair_index = 1, #available_pairs do
		for popular_map_index = 1, #priority_map_connections do
			for chain = 1, 2 do
				local pair_chain_index_map = (available_pairs[pair_index][chain] - (available_pairs[pair_index][chain] % 256)) / 256;
				if pair_chain_index_map == priority_map_connections[popular_map_index] then
					table.insert(popular_exits, available_pairs[pair_index][chain])
				end
			end 
		end
	end
end

function generateDeadEndMapsArray()
	local base_dead_end_maps = {
		-- {lz_code, kongs_needed_array, has_tag (or/and case)}
		{0x0C00,{4}, false}, -- Shell
		{0x0D00,{3}, false}, -- Painting Room
		{0x0E00,{4}, false}, -- Aztec Beetle
		{0x1000,{2,3,4,5}, false}, -- Tiny Temple
		{0x1100,{1,2,3,4,5}, true}, -- Helm
		{0x1300,{1}, false}, -- DK 5DT
		{0x1400,{1,3,4}, true}, -- Llama Temple
		{0x1500,{2}, false}, -- Diddy 5DT
		{0x1600,{4}, false}, -- Tiny 5DT
		{0x1700,{3}, false}, -- Lanky 5DT
		{0x1800,{5}, false}, -- Chunky 5DT
		{0x1B00,{4}, false}, -- Factory Car Race
		{0x1D00,{1}, false}, -- Power Shed
		{0x1F00,{5}, false}, -- Seasick Ship
		{0x2100,{5}, false}, -- Underground
		{0x2400,{1}, false}, -- Crusher Room
		{0x2500,{1}, false}, -- Japes BBlast
		{0x2700,{1}, false}, -- Seal Race
		{0x2900,{1}, false}, -- Aztec BBlast
		{0x2C00,{4}, false}, -- Pearl Chest
		{0x2D00,{4}, false}, -- Mermaid Palace
		{0x3100,{1}, false}, -- Lighthouse
		{0x3300,{2}, false}, -- Mech Fish
		{0x3400,{4}, false}, -- Anthill
		{0x3600,{1}, false}, -- Galleon BBlast
		{0x3700,{5}, false}, -- Fungi Minecart
		{0x3800,{2}, false}, -- Dark Attic
		{0x3900,{2}, false}, -- Winch Room
		{0x3A00,{3}, false}, -- Lanky Attic
		{0x3B00,{1}, false}, -- DK Barn
		{0x3C00,{4}, false}, -- Spider Boss
		{0x3F00,{3}, false}, -- Mush Slam
		{0x4600,{3}, false}, -- Mush Bounce
		{0x4700,{5}, false}, -- Face Puzzle
		{0x5200,{3}, false}, -- Caves Beetle
		{0x5400,{4}, false}, -- Tiny 5DI
		{0x5500,{3}, false}, -- Lanky 5DI
		{0x5600,{1}, false}, -- DK 5DI
		{0x5900,{1}, false}, -- Rotating Room
		{0x5A00,{5}, false}, -- Chunky 5DC
		{0x5B00,{1}, false}, -- DK 5DC
		{0x5C00,{2}, false}, -- Diddy Enemies 5DC
		{0x5D00,{4}, false}, -- Tiny 5DC
		{0x5E00,{3}, false}, -- 1DC
		{0x5F00,{5}, false}, -- Chunky 5DI
		{0x6200,{3}, false}, -- Ice Castle
		{0x6400,{2}, false}, -- Diddy 5DI
		{0x6900,{3}, false}, -- Wind Tower
		{0x6A00,{1}, false}, -- Castle Minecart
		{0x6C00,{3,4}, false}, -- LT Crypt
		{0x6E00,{1}, false}, -- Factory BBlast
		{0xA300,{1,2,3,5}, true}, -- Dungeon
		{0xA600,{5}, false}, -- Shed
		{0xA700,{4}, false}, -- Trash Can
		{0xB300,{4}, false}, -- Submarine
		{0xB900,{4}, false}, -- Castle Car Race
		{0xBA00,{1}, false}, -- Caves BBlast
		{0xBB00,{1}, false}, -- Castle BBlast
		{0xBC00,{1}, false}, -- Fungi BBlast
		{0xBD00,{4}, false}, -- BFI
		{0xC300,{2,5}, true}, -- Isles Snide's Room
		{0xC800,{2}, false}, -- Diddy Candles 5DC
	};
	dead_end_maps = {};
	for i = 1, #available_pairs do
		for j = 1, #available_pairs[i] do
			for k = 1, #base_dead_end_maps do
				if base_dead_end_maps[k][1] == available_pairs[i][j] then
					table.insert(dead_end_maps, base_dead_end_maps[k]);
				end
			end
		end
	end
end

zone_requirements = { -- Requirements to enter a loading zone that would take you to a specified zone code
	-- {zone_code, {kongs_required}}
	{0x0400, {2}}, -- Japes Mountain from Japes
	{0x0600, {2}}, -- Japes Minecart from Mountain
	{0x0700, {}}, -- Japes from Lobby
	{0x0701, {2,3,4}}, -- Japes from Shellhive (Only Diddy, Lanky & Tiny can go through the hole)
	{0x0702, {}}, -- Japes from Mountain
	{0x0703, {}}, -- Japes from Cranky
	{0x0704, {}}, -- Japes from Funky
	{0x0705, {}}, -- Japes from Painting Room
	{0x0706, {}}, -- Japes from Snide's
	{0x0707, {}}, -- Japes from BBlast
	{0x0708, {}}, -- Japes from Underground
	{0x0709, {}}, -- Japes from some T&S that doesn't matter
	{0x070A, {}}, -- Japes from some T&S that doesn't matter
	{0x070B, {}}, -- Japes from some T&S that doesn't matter
	{0x070C, {}}, -- Japes from some T&S that doesn't matter
	{0x070D, {}}, -- Japes from some T&S that doesn't matter
	{0x070E, {}}, -- Japes from Minecart
	{0x070F, {}}, -- Japes from Lobby (Intro/void spot?)
	{0x0710, {}}, -- Japes from DKTV
	{0x0800, {}}, -- AD1 from T&S
	{0x0900, {}}, -- Jetpac from Cranky
	{0x0C00, {4}}, -- Shell from Japes (Tiny is the only one who can go through)
	{0x0D00, {3}}, -- Painting Room from Japes (Lanky is the only one who is intended to enter. Diddy is required to open it up, but we're not saying he can enter)
	{0x0E00, {4}}, -- Az Beetle Race from Aztec (Tiny is the only one who can trigger the flight sequence from Squawks)
	{0x1000, {2,3,4,5}}, -- Tiny Temple from Aztec (Everyone but DK can enter)
	{0x1100, {}}, -- Helm from Lobby
	{0x1300, {1,2,3,4,5}}, -- DK 5DT from Aztec (DK is normally required to enter, but everyone can with some forward planning)
	{0x1400, {1,3,4}}, -- Llama Temple from Aztec
	{0x1500, {1,2,3,4,5}}, -- Diddy 5DT from Aztec (Diddy is normally required to enter, but everyone can with some forward planning)
	{0x1600, {4}}, -- Tiny 5DT from Aztec (Technically DK can enter, but it's too tight and requires a moonkick/some glitchy stuff to do so)
	{0x1700, {3}}, -- Lanky 5DT from Aztec (Technically DK can enter, but it's too tight and requires a moonkick/some glitchy stuff to do so)
	{0x1800, {5}}, -- Chunky 5DT from Aztec (Technically DK can enter, but it's too tight and requires a moonkick/some glitchy stuff to do so)
};