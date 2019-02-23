function randomiseKlaptraps()
	klaptraps = {0x1B, 0x1E, 0x1F};
	klaptrap_spawners = getEnemyPointerFromIds(klaptraps);
	klap_seed = seedAsNumber + 5;
	if #klaptrap_spawners > 0 then
		for i = 1, #klaptrap_spawners do
			klap_x = mainmemory.read_s16_be(klaptrap_spawners[i] + 0x4);
			klap_y = mainmemory.read_s16_be(klaptrap_spawners[i] + 0x6);
			klap_z = mainmemory.read_s16_be(klaptrap_spawners[i] + 0x8);
			math.randomseed(klap_seed + (3 * klap_x) - (5 * klap_y) + klap_z + i);
			new_klap_value = klaptraps[randomBetween(1, #klaptraps)];
			mainmemory.writebyte(klaptrap_spawners[i], new_klap_value);
			mainmemory.writebyte(klaptrap_spawners[i] + 0x44, new_klap_value);
		end
	end
end

function randomiseBeavers()
	beavers = {0x0, 0x21};
	getEnemyPointerFromIds(beavers);
	beaver_spawners = getEnemyPointerFromIds(beavers);
	beav_seed = seedAsNumber + 6;
	if #beaver_spawners > 0 then
		for i = 1, #beaver_spawners do
			beav_x = mainmemory.read_s16_be(beaver_spawners[i] + 0x4);
			beav_y = mainmemory.read_s16_be(beaver_spawners[i] + 0x6);
			beav_z = mainmemory.read_s16_be(beaver_spawners[i] + 0x8);
			math.randomseed(beav_seed + (3 * beav_x) - (5 * beav_y) + beav_z + i);
			new_beav_value = beavers[randomBetween(1, #beavers)];
			mainmemory.writebyte(beaver_spawners[i], new_beav_value);
			mainmemory.writebyte(beaver_spawners[i] + 0x44, new_beav_value);
		end
	end
end

function changeKlaptrapsAndBeavers()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
	obj_m2_timer_value = mainmemory.read_u32_be(Mem.obj_model2_timer[version]);
	if transition_speed_value < 0 and obj_m2_timer_value == 1 and mini_enemy_rando_happened == 0 then
		randomiseBeavers();
		randomiseKlaptraps();
		mini_enemy_rando_happened = 1;
	elseif transition_speed_value > 0 then
		mini_enemy_rando_happened = 0;
	end
end

event.onframestart(changeKlaptrapsAndBeavers, "Changes Klaptraps and Beavers");