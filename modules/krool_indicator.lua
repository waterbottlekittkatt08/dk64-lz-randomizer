centre_spawn = {3050,578,640};
left_even_spawn = {3027,578,646};
right_even_spawn = {3073,578,634};

differential = {
	[1] = 47, -- x
	[2] = 0, -- y
	[3] = -11, -- z
};

spawn = {};

spawn_count = #k_rool_assortment;

for i = 1, spawn_count do
	spawn[i] = {};
end

if spawn_count % 2 == 0 then -- Even
	central_divisor = spawn_count / 2;
	for i = central_divisor, 1, -1 do
		for j = 1, 3 do
			spawn[i][j] = left_even_spawn[j] - (differential[j] * math.abs(i - central_divisor));
		end
	end
	for i = central_divisor + 1, spawn_count do
		for j = 1, 3 do
			spawn[i][j] = right_even_spawn[j] + (differential[j] * math.abs(i - (central_divisor + 1)));
		end
	end
elseif spawn_count % 2 == 1 then -- Odd
	central_spawn = math.floor(spawn_count / 2) + 1;
	for i = 1, spawn_count do
		for j = 1, 3 do
			spawn[i][j] = centre_spawn[j] + (differential[j] * (i - central_spawn));
		end
	end
end

krool_indicator_input_enemies = {
	[1] = 0x5, -- Zinger
	[2] = 0x1C, -- Zinger
};

cutscene_kong_models = {
	[1] = 0x13,
	[2] = 0x14,
	[3] = 0x15,
	[4] = 0x16,
	[5] = 0x17, -- 0x9
};

function replaceIndicators()
	indicator_pointers = getEnemyPointerFromIds(krool_indicator_input_enemies);
	if #indicator_pointers > 0 then
		for i = 1, spawn_count do
			focused_pointer = indicator_pointers[i];
			kong = k_rool_assortment[i];
			mainmemory.writebyte(focused_pointer + 0x44, cutscene_kong_models[kong]); -- Alt Spawn Val
			mainmemory.writebyte(focused_pointer, cutscene_kong_models[kong]); -- Spawn Val
			for j = 1, 3 do
				mainmemory.write_s16_be(focused_pointer + 0x2 + (j * 2), spawn[i][j]); -- Position
			end
		end
	end
end

function writeIndicators()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
	obj_m2_timer_value = mainmemory.read_u32_be(Mem.obj_model2_timer[version]);
	if transition_speed_value < 0 and obj_m2_timer_value == 1 and indicator_placement_happened == 0 then
		if current_cmap == 34 then
			replaceIndicators();
			indicator_placement_happened = 1;
		end
	elseif transition_speed_value > 0 then
		indicator_placement_happened = 0;
	end
end

event.onframeend(writeIndicators, "Places Indicators");