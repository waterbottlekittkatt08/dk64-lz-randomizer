enemyTypes = {
	[0x0] = {"Beaver", permissable = true},
	[0x1] = {"Giant Clam", permissable = false},
	[0x2] = {"Krash", permissable = false},
	[0x3] = {"Book", permissable = true},
	[0x4] = {"0", permissable = false}, -- Beta Jack
	[0x5] = {"Zinger (Charger)", permissable = true, y = 250},
	[0x6] = {"Klobber", permissable = false},
	[0x7] = {"Snide", permissable = false},
	[0x8] = {"Army Dillo", permissable = false},
	[0x9] = {"Klump", permissable = true},
	[0xA] = {"0", permissable = false}, -- Beta Army
	[0xB] = {"Cranky", permissable = false},
	[0xC] = {"Funky", permissable = false},
	[0xD] = {"Candy", permissable = false},
	[0xE] = {"Beetle", permissable = false},
	[0xF] = {"Mermaid", permissable = false},
	[0x10] = {"Kabooom", permissable = false},
	[0x11] = {"Vulture", permissable = false},
	[0x12] = {"Squawks", permissable = false},
	[0x13] = {"Cutscene DK", permissable = false},
	[0x14] = {"Cutscene Diddy", permissable = false},
	[0x15] = {"Cutscene Lanky", permissable = false},
	[0x16] = {"Cutscene Tiny", permissable = false},
	[0x17] = {"Cutscene Chunky", permissable = false},
	[0x18] = {"Padlock (T&S)", permissable = false},
	[0x19] = {"Llama", permissable = false},
	[0x1A] = {"Mad Jack", permissable = false},
	[0x1B] = {"Klaptrap (Green)", permissable = true},
	[0x1C] = {"Zinger (Bomber)", permissable = true, y = 250},
	[0x1D] = {"Vulture (Race)", permissable = true},
	[0x1E] = {"Klaptrap (Purple)", permissable = true},
	[0x1F] = {"Klaptrap (Red)", permissable = true},
	[0x20] = {"Get Out Controller", permissable = true, controller = true},
	[0x21] = {"Beaver (Gold)", permissable = true},
	[0x22] = {"0", permissable = false}, -- Beta Re-Koil
	[0x23] = {"Fire Column Spawner", permissable = true},
	[0x24] = {"Minecart (TNT)", permissable = false},
	[0x25] = {"Minecart (TNT)", permissable = false},
	[0x26] = {"Pufftoss", permissable = false},
	[0x27] = {"Cannon (Seasick)", permissable = true},
	[0x28] = {"K Rool's Foot", permissable = false},
	[0x29] = {"0", permissable = false},
	[0x2A] = {"Fireball Spawner", permissable = true},
	[0x2B] = {"0", permissable = false}, -- Beta Boxing Glove
	[0x2C] = {"Mushroom Man", permissable = true},
	[0x2D] = {"0", permissable = false}, -- Beta Rareware Logo
	[0x2E] = {"Troff", permissable = false},
	[0x2F] = {"0", permissable = false},
	[0x30] = {"Bad Hit Detection Man", permissable = true},
	[0x31] = {"0", permissable = false},
	[0x32] = {"0", permissable = false},
	[0x33] = {"Ruler", permissable = true},
	[0x34] = {"Toy Box", permissable = false},
	[0x35] = {"Squawks", permissable = false},
	[0x36] = {"Seal", permissable = false},
	[0x37] = {"Scoff", permissable = false},
	[0x38] = {"Robo-Kremling", permissable = true},
	[0x39] = {"Dogadon", permissable = false},
	[0x3A] = {"0", permissable = false},
	[0x3B] = {"Kremling", permissable = true},
	[0x3C] = {"Spotlight Fish", permissable = false},
	[0x3D] = {"Kasplat (DK)", permissable = true},
	[0x3E] = {"Kasplat (Diddy)", permissable = true},
	[0x3F] = {"Kasplat (Lanky)", permissable = true},
	[0x40] = {"Kasplat (Tiny)", permissable = true},
	[0x41] = {"Kasplat (Chunky)", permissable = true},
	[0x42] = {"Mechanical Fish", permissable = false},
	[0x43] = {"Seal", permissable = false},
	[0x44] = {"Banana Fairy", permissable = false},
	[0x45] = {"Squawks (w/ Spotlight)", permissable = false},
	[0x46] = {"0", permissable = false},
	[0x47] = {"0", permissable = false},
	[0x48] = {"Rabbit", permissable = false},
	[0x49] = {"Owl", permissable = false},
	[0x4A] = {"Nintendo Logo", permissable = false},
	[0x4B] = {"Fire Breath Spawner", permissable = true},
	[0x4C] = {"Minigame Controller", permissable = false, controller = true},
	[0x4D] = {"Battle Crown Controller", permissable = false, controller = true},
	[0x4E] = {"Toy Car", permissable = false},
	[0x4F] = {"Minecart (TNT)", permissable = false},
	[0x50] = {"Cutscene Object", permissable = false},
	[0x51] = {"Guard", permissable = false},
	[0x52] = {"Rareware Logo", permissable = false},
	[0x53] = {"Robo-Zinger", permissable = true, y = 250},
	[0x54] = {"Krossbones", permissable = true},
	[0x55] = {"Shuri", permissable = true},
	[0x56] = {"Gimpfish", permissable = true},
	[0x57] = {"Mr. Dice", permissable = true},
	[0x58] = {"Sir Domino", permissable = true},
	[0x59] = {"Mr. Dice", permissable = true},
	[0x5A] = {"Rabbit", permissable = false},
	[0x5B] = {"0", permissable = false},
	[0x5C] = {"Fireball (w/ Glasses)", permissable = true},
	[0x5D] = {"K. Lumsy", permissable = false},
	[0x5E] = {"Spider (Boss)", permissable = false},
	[0x5F] = {"Spider (Spiderling)", permissable = true},
	[0x60] = {"Squawks", permissable = false},
	[0x61] = {"K Rool (DK Phase)", permissable = false},
	[0x62] = {"Skeleton Head", permissable = false},
	[0x63] = {"Bat", permissable = true},
	[0x64] = {"Tomato (Fungi)", permissable = true},
	[0x65] = {"Kritter-in-a-Sheet", permissable = true},
	[0x66] = {"Pufftup", permissable = false},
	[0x67] = {"Kosha", permissable = true},
	[0x68] = {"0", permissable = false},
	[0x69] = {"Enemy Car", permissable = false},
	[0x6A] = {"K. Rool (Diddy Phase)", permissable = false},
	[0x6B] = {"K. Rool (Lanky Phase)", permissable = false},
	[0x6C] = {"K. Rool (Tiny Phase)", permissable = false},
	[0x6D] = {"K. Rool (Chunky Phase)", permissable = false},
	[0x6E] = {"Bug", permissable = false},
	[0x6F] = {"Banana Fairy (BFI)", permissable = false},
	[0x70] = {"Tomato (Ice)", permissable = false},
};


function configureCrown(enemy_array,timer,crown_name)
	local enemyRespawnObject = dereferencePointer(Mem.enemy_respawn_object[version]);
	local enemySlotSize = 0x48;
	local character_spawners = {};
	if isRDRAM(enemyRespawnObject) then
		local numberOfEnemies = mainmemory.read_u16_be(Mem.num_enemies[version]);
		for i = 1, numberOfEnemies do
			slotBase = enemyRespawnObject + (i - 1) * enemySlotSize;
			table.insert(character_spawners,slotBase)
		end
	end
	local index = 0;
	if #character_spawners > 0 then
		for i = 1, #character_spawners do
			local enemy_type = mainmemory.readbyte(character_spawners[i]);
			if enemy_type ~= 0x4D then -- Not Battle Crown
				index = index + 1;
				mainmemory.writebyte(character_spawners[i], enemy_array[index])
				mainmemory.writebyte(character_spawners[i] + 0x44, enemy_array[index])
			end
		end
	end
end