patch_maps = {
	0x07, -- Japes
	0x26, -- Aztec
	0x18, -- Aztec 5DT
	0x1A, -- Factory
	0x31, -- Galleon Lighthouse
	0x30, -- Fungi
	0x48, -- Caves
	0x57, -- Castle
	0x22, -- Isles
	0x61, -- Isles KLumsy
	0xB0, -- Isles TG
	0xC1,-- Isles Castle Lobby
};

patch_locations = {
	-- FORMAT = {X,Y,Z,ROT}
	[0x07] = { -- Japes
		{550.814,370.167,1873.436,1070}, -- Normal (Outside Painting Room)
		{2430.642,280,1130.228,3750}, -- Behind Underground Entrance
		{2114.546,680,2400.077,2250}, -- In front of Snide's
		-- Deep hole near Diddy BP
		-- Hill opposite Lanky Bonus in Alcove
		-- Diddy Cavern
		-- Minecart Exit
		-- Top of Mountain
		-- Under Chunky Bonus
		-- Next to Shellhive
	},
	[0x26] = { -- Aztec
		-- Normal (Oasis)
		-- On top of Tiny Temple
		-- Right of Candy's
		-- Under HC Barrel
		-- Behind Llama Cage
		-- Under Giant Boulder
		-- Under Vulture Rocketbarrel
		-- On Llama Temple
		-- Under SSnoop
		-- In front of Snide's
		-- Behind Gong Tower
	},
	[0x18] = { -- Aztec Chunky 5DT
		-- Normal (2nd Path Join)
		-- 1st Path Join
	},
	[0x1A] = { -- Factory
		-- Normal (Dark Room)
		-- Inbetween Candy/Cranky
		-- Under Power Shed Platform
		-- Middle of Production Room Climb
		-- Under High Prod Tag
		-- Past Krazy KK Bonus
		-- Hatch Hole 2nd Floor
		-- Number Game Room
		-- Under Grade near Arcade
		-- In Racecar Lobby
		-- In Diddy R&D 
		-- In Chunky R&D
		-- Near Xylophone
	},
	[0x31] = { -- Lighthouse
		-- Normal (Behind Tower)
		-- Top of Tower
		-- Behind Tower (2nd Floor)
	},
	[0x30] = { -- Fungi
		-- Normal (Beanstalk)
		-- Normal (Patch of Grass)
		-- Under Apple
		-- Alcove T&S Near Apple
		-- In front of Clock
		-- Behind Well 1
		-- To Left of Well 2
		-- On Mill
		-- Behind DK Barn
		-- In DK Barn Thorn Grass
		-- In Thick Grass Opposite Cranky's
		-- In Thick Grass near Rabbit Race
		-- In Alcove in Owl Tree
		-- In Owl's Sleeping Den
		-- On top of Fungi Anthill
	},
	[0x48] = { -- Caves
		-- Normal (Giant Kosha Room)
		-- Under 5DI Tag
		-- Inside Chunky Shield
		-- Inside Tiny Shield
		-- Inside W3 Room
		-- Under Giant Boulder
		-- Under Ice Castle Tag
		-- In Snide's Alcove
		-- In GGone Alcove
		-- On W5 Platform
		-- In W4 Room
		-- Under 5DC Tag
		-- Tiny BP Platform
		-- Left of Rotating Room
	},
	[0x57] = { -- Castle
		-- Normal (Behind Snide's)
		-- On Wind Tower
		-- On Wind Tower Cloud
		-- Near Museum Entrance
		-- Under Ballroom Tag
		-- Under Main Tag
		-- Outside Crypt Hub
		-- Outside Low T&S
	},
	[0x22] = { -- Isles
		-- Normal (On Aztec Roof)
		-- Normal (Under Caves Lobby)
		-- Normal (Outside Fungi)
		-- Waterfall platform
		-- Outside Caves
		-- Castle Rock
		-- Behind Lower Kroc Isle
		-- Behind Factory Entrance
		-- Small Fairy Isle
	},
	[0x61] = { -- Isles KLumsy
		-- Normal (Back of KLumsy)
		-- Inside KLumsy's Cage (KLumsy needs to be freed to get this)
	},
	[0xB0] = { -- Isles TG
		-- Normal (Back of TG)
		-- Normal (Banana Hoard)
		-- Near Training Barrels
		-- In front of Cranky
	},
	[0xC1] = { -- Isles Castle Lobby
		-- Normal (On central column)
		-- Behind entrance to Lobby from Isles
	},
}