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

-- Gonna have to swap out object ids and their map object setup code


function getWarpsTable()
	local warp_obj_types = {0x210, 0x211, 0x212, 0x213, 0x214}; -- W5 > W1
	local warp_pointers = {};
	local warp_pointers_of_one_type = {};
	for i = 1, #warp_obj_types do
		warp_pointers_of_one_type = getOM2PointersFromId(warp_obj_types[i])
		for j = 1, #warp_pointers_of_one_type do
			table.insert(warp_pointers, warp_pointers_of_one_type[j])
		end
	end
	return warp_pointers
end

function geteWarpLocations()
	local warps = getWarpsTable();
	local warp_locations = {};
	if #warps > 0 then
		for i = 1, #warps do
			local x = mainmemory.readfloat(warps[i] + 0, true);
			local y = mainmemory.readfloat(warps[i] + 4, true);
			local z = mainmemory.readfloat(warps[i] + 8, true);
			local coords = {x, y, z};
			table.insert(warp_locations, coords);
		end
	end
	return warp_locations
end

function randomiseBananaports()
	local locations = geteWarpLocations();
	local warps = getWarpsTable();
	local model_location = 0;
	for i = 1, #warps do
		local new_location_index = randomBetween(1, #locations);
		model_location = dereferencePointer(warps[i] + 0x20);
		if isRDRAM(model_location) then
			for j = 1, 3 do
				mainmemory.writefloat(warps[i] + ((4 * j) - 4), locations[new_location_index][j], true);
				mainmemory.writefloat(model_location + ((4 * j) - 4), locations[new_location_index][j], true);
			end
		end
		table.remove(locations, new_location_index);
	end
end