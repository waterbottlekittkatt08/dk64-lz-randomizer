--[[
	Gameplay Modifier
	> No Trees
]]--

function checkForTrees()
	obj_m2_timer = mainmemory.read_u32_be(Mem.obj_model2_array_count[version]);
	obj_m2_pointer = mainmemory.read_u32_be(Mem.obj_model2_array_pointer[version]);
	if obj_m2_timer == 0 and isPointer(obj_m2_pointer) then
		tree_types = {0x03, 0x20, 0x29, 0x58, 0x59, 0x5A, 0x5B, 0x6C, 0x6D, 0x6E, 0xE2, 0x1F1};
		tree_new_y = -10000;
		for i = 1, #tree_types do
			tree_pointers = getOM2PointersFromId(tree_types[i]);
			if #tree_pointers > 0 then
				for j = 1, #tree_pointers do
					mainmemory.writefloat(tree_pointers[j] + 0x4, tree_new_y, true);
					tree_model = dereferencePointer(tree_pointers[j] + 0x20)
					mainmemory.writefloat(tree_model + 0x4, tree_new_y, true);
				end
			end
		end
	end
end

event.onframeend(checkForTrees, "Shifts Trees");