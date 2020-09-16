require "modules.bananaport_names"

function getObjM2DataFromSetup()
	local header = dereferencePointer(Mem.setup_pointer[version]);
	local setup_data = {};
	if isRDRAM(header) then
		local count = mainmemory.read_u32_be(header);
		if count > 0 then
			for i = 1, count do
				local slot = header + 0x04 + ((i - 1) * 0x30);
				table.insert(setup_data, slot);
			end
		end
	end
	return setup_data
end

function getSetupPointersFromID(id)
	local setup = getObjM2DataFromSetup();
	local matching_setup = {};
	local setup_id = 0;
	if #setup > 0 then
		for i = 1, #setup do
			setup_id = mainmemory.read_u16_be(setup[i] + 0x28);
			if id == setup_id then
				table.insert(matching_setup, setup[i]);
			end
		end
	end
	return matching_setup
end

function excludeGalleonPlanks(array_of_pointers)
	local pointerTable = {};
	local exclusion_table = {
		{{3175.064,3175.066},{1543.22,1543.24},{1844.806,1844.808}}, -- Plank W5
		{{1556.672,1556.674},{1548.118,1548.12},{2008.955,2008.957}}, -- Plank W2
		{{2762.928,2762.93},{1550.855,1550.857},{1431.043,1431.045}}, -- Plank W4
	}
	local current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	if current_cmap == 30 then
		for ptr_index = 1, #array_of_pointers do
			local ptr_x = mainmemory.readfloat(array_of_pointers[ptr_index] + 0, true);
			local ptr_y = mainmemory.readfloat(array_of_pointers[ptr_index] + 4, true);
			local ptr_z = mainmemory.readfloat(array_of_pointers[ptr_index] + 8, true);
			local exclude_warp = false;
			for exclusion_index = 1, #exclusion_table do
				if ptr_x > exclusion_table[exclusion_index][1][1] and ptr_x < exclusion_table[exclusion_index][1][2] then
					if ptr_y > exclusion_table[exclusion_index][2][1] and ptr_y < exclusion_table[exclusion_index][2][2] then
						if ptr_z > exclusion_table[exclusion_index][3][1] and ptr_z < exclusion_table[exclusion_index][3][2] then
							exclude_warp = true;
						end
					end
				end
			end
			if not exclude_warp then
				table.insert(pointerTable,array_of_pointers[ptr_index]);
			end
		end
		return pointerTable;
	else
		return array_of_pointers
	end
	return pointerTable
end

-- Gonna have to swap out object ids and their map object setup code

warp_object_ids = {0x214, 0x213, 0x211, 0x212, 0x210};
warp_map_data = {
	-- {map_value, warp_count, filtered_warp_count},
	{7,10, 10}, -- Japes Main
	{38,10, 10}, -- Aztec Main
	{20,4, 4}, -- Aztec Llama Temple
	{26,10, 10}, -- Factory Main
	{30,10, 7}, -- Galleon Main
	{48,10, 10}, -- Fungi Main
	{72,10, 10}, -- Caves Main
	{87,10, 10}, -- Castle Main
	{112,6, 6}, -- Castle DDC Crypt
	{34,10, 10}, -- Isles Main
	-- Helm & Helm Lobby only have two warps, not worth it
};

function generateWarpAssortment()
	warp_assortment = {};
	local warpSeed = seedAsNumber - 12;
	math.randomseed(warpSeed)
	for i = 1, #warp_map_data do
		local warp_choices_temp = {};
		local warp_assortment_temp = {};
		for j = 1, warp_map_data[i][3] do
			table.insert(warp_choices_temp, j);
		end
		for j = 1, warp_map_data[i][3] do
			local warp_temp_selection = randomBetween(1, #warp_choices_temp);
			table.insert(warp_assortment_temp, warp_choices_temp[warp_temp_selection]);
			table.remove(warp_choices_temp, warp_temp_selection);
		end
		warp_assortment[warp_map_data[i][1]] = warp_assortment_temp;
	end
end
generateWarpAssortment();

function getObjFromCode(code)
	return (code - (code % 65536)) / 65536;
end

function getIndexFromCode(code)
	return code % 65536;
end

-- Used to change the fake port in KLumsy's Prison
klumsy_fakeport = -1;

warpCodesPrinted = false;
mapReset = true;
function printWarpCodes()
	local current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	local obj_m2_timer_value = mainmemory.read_u32_be(Mem.obj_model2_timer[version]);
	local setup_pointer_value = mainmemory.read_u32_be(Mem.setup_pointer[version]);
	if obj_m2_timer_value == 0 and not warpCodesPrinted and mapReset then
		local warp_count = -1;
		for i = 1, #warp_map_data do
			if warp_map_data[i][1] == current_cmap then
				warp_count = warp_map_data[i][2];
			end
		end
		if warp_count ~= -1 then -- Is Warp Map
			--print("Warp Map Found: "..warp_count.." Warps");
			-- Determines if all warps are in setup
			local all_warps_in_setup = true;
			local warps_found = 0;
			for i = 1, (warp_count / 2) do
				local warp_cap = 2;
				if current_cmap == 30 then
					if i == 2 or i == 4 or i == 5 then
						warp_cap = 1;
					end
				end
				local warp_pointers = excludeGalleonPlanks(getSetupPointersFromID(warp_object_ids[i]));
				if #warp_pointers ~= warp_cap then
					all_warps_in_setup = false;
				end
				warps_found = warps_found + #warp_pointers;
			end
			--print("Found "..warps_found.." warps")
			-- Grabs all warps and their codes
			if all_warps_in_setup then
				local codes_list = {};
				for i = 1, (warp_count / 2) do
					warp_pointers = excludeGalleonPlanks(getSetupPointersFromID(warp_object_ids[i]));
					local warp_cap = 2;
					if current_cmap == 30 then
						if i == 2 or i == 4 or i == 5 then
							warp_cap = 1;
						end
					end
					for j = 1, warp_cap do
						local inputObj = {warp_pointers[j], mainmemory.read_u32_be(warp_pointers[j] + 0x28)};
						table.insert(codes_list, inputObj);
					end
				end
				-- Randomises Warp Code Assortment
				addToCrashLog("Bananaport Randomisation Summary")
				warpCodesPrinted = true;
				mapReset = false;
				for i = 1, #codes_list do
					local new_code = codes_list[warp_assortment[current_cmap][i]][2];
					local input_code = mainmemory.read_u32_be(codes_list[i][1] + 0x28)
					local input_warp = "Unknown ID";
					for j = 1, #warp_object_ids do
						if warp_object_ids[j] == getObjFromCode(input_code) then
							input_warp = "Warp "..j;
						end
					end
					local new_warp = "Unknown ID";
					for j = 1, #warp_object_ids do
						if warp_object_ids[j] == getObjFromCode(new_code) then
							new_warp = "Warp "..j;
						end
					end
					if current_cmap == 0x22 then -- Isles
						if getIndexFromCode(input_code) == 0x11 then -- outside K-Lumsy's
							klumsy_fakeport = getObjFromCode(new_code);
						end
					end
					addToCrashLog(port_names[current_cmap][getIndexFromCode(input_code)]..": "..input_warp.." > "..new_warp);
					mainmemory.write_u32_be(codes_list[i][1] + 0x28, new_code);
				end
			end
		end
	elseif obj_m2_timer_value > 0 then
		warpCodesPrinted = false;
	end
	if setup_pointer_value == 0 then
		mapReset = true;
	end
end

facade_warp_map_data = {
	-- {map_value, warp_count, filtered_warp_count},
	{170,2, 2}, -- Helm Lobby
	{17,2, 2}, -- Helm
	{97,1, 1}, -- KLumsy
};

function generateWarpFacadeAssortment()
	warp_facade_assortment = {};
	local warpSeed = seedAsNumber - 15;
	math.randomseed(warpSeed)
	warp_facade_assortment[170] = randomBetween(1,5);
	warp_facade_assortment[17] = randomBetween(1,5);
end
generateWarpFacadeAssortment();

facade_warpCodesPrinted = false;
facade_mapReset = true;
function changePortFacade()
	local current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	local obj_m2_timer_value = mainmemory.read_u32_be(Mem.obj_model2_timer[version]);
	local setup_pointer_value = mainmemory.read_u32_be(Mem.setup_pointer[version]);
	if obj_m2_timer_value == 0 and not facade_warpCodesPrinted and facade_mapReset then
		local warp_count = -1;
		for i = 1, #facade_warp_map_data do
			if facade_warp_map_data[i][1] == current_cmap then
				warp_count = facade_warp_map_data[i][2];
			end
		end
		if warp_count ~= -1 then -- Is Warp Map
			--print("Warp Map Found: "..warp_count.." Warps");
			-- Determines if all warps are in setup
			local all_warps_in_setup = true;
			local warps_found = 0;
			local warp_cap = warp_count;
			local warp_pointers = getSetupPointersFromID(0x214);
			if #warp_pointers ~= warp_cap then
				all_warps_in_setup = false;
			end
			if all_warps_in_setup then
				addToCrashLog("All warps in setup found");
				if current_cmap == 97 then
					if klumsy_fakeport ~= -1 then
						for i = 1, #warp_pointers do
							mainmemory.write_u16_be(warp_pointers[i] + 0x28, klumsy_fakeport)
						end
						addToCrashLog("K. Lumsy warp object (0x"..bizstring.hex(warp_pointers[1])..") changed to object 0x"..bizstring.hex(klumsy_fakeport));
					end
				else
					local new_warp_id = warp_object_ids[warp_facade_assortment[current_cmap]];
					for i = 1, #warp_pointers do
						mainmemory.write_u16_be(warp_pointers[i] + 0x28, new_warp_id)
					end
					addToCrashLog("Warp Facade Changed in map 0x"..bizstring.hex(current_cmap).." to Warp "..warp_facade_assortment[current_cmap]);
				end
				warpCodesPrinted = true;
				mapReset = false;			
			end
		end
	elseif obj_m2_timer_value > 0 then
		facade_warpCodesPrinted = false;
	end
	if setup_pointer_value == 0 then
		facade_mapReset = true;
	end
end

event.onframeend(printWarpCodes, "Randomises Warps");
event.onframeend(changePortFacade, "Changes port facades");