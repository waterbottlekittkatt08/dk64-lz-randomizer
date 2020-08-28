require "modules.regularmaptable";

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
	{0x1E0B, 0x1F00}, -- Galleon Seasick Ship
	{0x1E13, 0x2700}, -- Galleon Seal Race
	{0x1E15, 0xB300}, -- Galleon Submarine
	{0x2202, 0xA900}, -- Isles Japes Lobby
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
	{0x3005, 0x3D00}, -- Fungi Mill Front (PPunch Door)
	{0x3006, 0x3E00}, -- Fungi Mill Rear (W1 Door)
	{0x3007, 0x3E03}, -- Fungi Mill Rear (Tiny Door)
	{0x3008, 0x4000}, -- Fungi GM (Low)
	{0x3009, 0x4001}, -- Fungi GM (Lower Middle)
	{0x300A, 0x4002}, -- Fungi GM (Middle)
	{0x300B, 0x4003}, -- Fungi GM (Upper Middle)
	{0x300C, 0x4004}, -- Fungi GM (High)
	{0x300D, 0x4700}, -- Fungi Face Puzzle
	{0x300E, 0x3F00}, -- Fungi Light Room
	{0x300F, 0x4600}, -- Fungi Dark Room
	{0x3010, 0x3700}, -- Fungi From Minecart
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
	{0x570C, 0x7200}, -- Castle (From Library [Entrance])
	{0x570D, 0x7201}, -- Castle (From Library [Exit])
	{0x570E, 0x6900}, -- Castle (From Wind Tower)
	{0x5710, 0xA700}, -- Castle (From Trash Can)
	--0x5714, -- Castle (From Greenhouse Rear)
	{0x5801, 0x7102}, -- Castle Ballroom (From Museum)
	{0x6C00, 0xB704}, -- Castle Crypt [L/T] (From Crypt [Hub])
	{0x7000, 0xB703}, -- Castle Crypt [D/Di/T] (From Crypt [Hub])
	{0x7101, 0xB900}, -- Castle Museum (From Castle Car Race)
	{0x9704, 0xA300} -- Castle Tunnel (From Dungeon)
	--0xA400, -- Castle Tree (From Castle)
};

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