--[[
	Play test LUA script to test
	a simple version of randomiser that would likely
	be the premise of the first rando ROM Hack

	Core differences to vanilla:
	- First 7 levels are shuffled from the point of the DK Portal
	- Exiting to lobby takes you to the randomised point rather than vanilla
	- Keys and T&S Level counts are tied to the level order rather than the level
		- In this, key randomisation won't work this way due to problems that would be caused with exiting T&S Portals, all
		keys will be turned in by default, the player (for now) will just have to ensure they have collected the key from the previous level
	- All Kongs unlocked
	- Two Galleon gates opened

	Concept by "Hey 2dos, why don't you play DK64 Anymore"
]]--

function bootMessage()
	print("Donkey Kong 64 Level Randomiser")
	print("Play test LUA Script")
	print("-------------------------------")
	print("Concept by 2dos, Coded by theballaam96")
	print("-------------------------------")
	print("Level order is swapped around, T&S door numbers are also swapped. ")
	print("Bosses are in vanilla levels, keys are meant to be tied to level progression")
	print("rather than level, but this would cause fundamental bugs")
	print("that aren't worth trying to work around for a test LUA Script.")
	print("-------------------------------")
	print("To set a specific seed, type 'setSeed(yourNumberHere)', which will automatically")
	print("regenerate the assortment.")
	print("To look at the seed spoiler log, type 'spoiler()'")
	print("")
end
bootMessage();

function selectRandom(min,max)
	local random = math.random();
	local diff = (max - min) + 1;
	local preVal = math.floor(random * diff) + min;
	if preVal > max then
		preVal = max;
	end
	if preVal < min then
		preVal = min;
	end
	return preVal;
end

function generateLevelAssortment()
	baseValues = {1,2,3,4,5,6,7};
	levelAssortment = {};
	for i = 1, 7 do
		local selectedIndex = selectRandom(1,#baseValues);
		local selectedValue = baseValues[selectedIndex];
		table.insert(levelAssortment, selectedValue);
		table.remove(baseValues, selectedIndex);
	end
	--printAssortment();
end

function printAssortment()
	local levelNames = {
		[1] = "Japes",
		[2] = "Aztec",
		[3] = "Factory",
		[4] = "Galleon",
		[5] = "Fungi",
		[6] = "Caves",
		[7] = "Castle",
	};
	for i = 1, 7 do
		print(levelNames[i].." Lobby > "..levelNames[levelAssortment[i]].." (level)")
	end
end

function setCountsFromAssortment()
	local normalTNSCount = {
		60, 120, 200, 250, 300, 350, 400
	};
	local door_info = 0x7446C0;
	for i = 1, 7 do
		local levelSlot = table.find(levelAssortment,i);
		local newCount = normalTNSCount[levelSlot];
		mainmemory.write_u16_be(door_info + (2 * (i - 1)), newCount);
	end
end

function table.find(tbl, val)
	local index = -1;
	for tblIndex = 1, #tbl do
		if tbl[tblIndex] == val then
			index = tblIndex
		end
	end
	return index;
end

set_bit = bit.set;

function getFileIndex()
	return mainmemory.readbyte(0x7467C8);
end

local eeprom_slot_size = 0x1AC;

function getCurrentEEPROMSlot()
	local fileIndex = getFileIndex();
	for i = 0, 3 do
		local EEPROMMap = mainmemory.readbyte(0x7EDEA8 + i);
		if EEPROMMap == fileIndex then
			return i;
		end
	end
	return 0; -- Default
end

function getFlagBlockAddress()
	return 0x7ECEA8 + getCurrentEEPROMSlot() * eeprom_slot_size;
end

function setFlag(byte, bit)
	local flags = getFlagBlockAddress();
	if type(byte) == "number" and type(bit) == "number" and bit >= 0 and bit < 8 then
		local currentValue = mainmemory.readbyte(flags + byte);
		mainmemory.writebyte(flags + byte, set_bit(currentValue, bit));
	end
end

function performRandomisation(currentMap, initialDestinationMap)
	local lobbies = {
		0xA9, -- Japes
		0xAD, -- Aztec
		0xAF, -- Factory
		0xAE, -- Galleon
		0xB2, -- Fungi
		0xC2, -- Caves
		0xC1, -- Castle
	};
	local levelMain = {
		0x7, -- Japes
		0x26, -- Aztec
		0x1A, -- Factory
		0x1E, -- Galleon
		0x30, -- Fungi
		0x48, -- Caves
		0x57, -- Castle
	};
	local currentIsLobby = table.find(lobbies,currentMap) > -1;
	local currentIsLevel = table.find(levelMain,currentMap) > -1;
	local destinationIsLobby = table.find(lobbies,initialDestinationMap) > -1;
	local destinationIsLevel = table.find(levelMain,initialDestinationMap) > -1;
	if currentIsLobby and destinationIsLevel then
		local focusedLobby = table.find(lobbies,currentMap);
		local newLevelIndex = levelAssortment[focusedLobby];
		mainmemory.write_u32_be(0x7444E4,levelMain[newLevelIndex]); -- Going through DK Portal to level
	elseif currentIsLevel and destinationIsLobby then
		local focusedLevel = table.find(levelMain, currentMap);
		local newLobbyIndex = table.find(levelAssortment, focusedLevel);
		mainmemory.write_u32_be(0x7444E4,lobbies[newLobbyIndex]); -- Some action from Level to Lobby (Exit Level, through DK Portal)
	end
end

function updateValues()
	currentMap = mainmemory.read_u32_be(0x76A0A8);
	destinationMap = mainmemory.read_u32_be(0x7444E4);
	transitionSpeed = mainmemory.readfloat(0x7FD88C, true);
end

function flagsToSet()
	setFlag(0x13,3) -- Galleon Coconut Gate
	setFlag(0x14,1) -- Galleon Peanut Gate
	setFlag(0x30,1) -- DK
	setFlag(0x0,6) -- Diddy
	setFlag(0x8,6) -- Lanky
	setFlag(0x8,2) -- Tiny
	setFlag(0xE,5) -- Chunky
	-- setFlag(0x38,5) -- Story: Japes
	-- setFlag(0x38,6) -- Story: Aztec
	-- setFlag(0x38,7) -- Story: Factory
	-- setFlag(0x39,0) -- Story: Galleon
	-- setFlag(0x39,1) -- Story: Fungi
	-- setFlag(0x39,2) -- Story: Caves
	-- setFlag(0x39,3) -- Story: Castle
	setFlag(0x37,4) --Key 1 Turned
	setFlag(0x37,5) --Key 2 Turned
	setFlag(0x37,7) --Key 4 Turned
	setFlag(0x38,0) --Key 5 Turned
	setFlag(0x38,1) --Key 6 Turned
	setFlag(0x38,2) --Key 7 Turned
end
flagsToSet()

randoHappened = false;
function frameLoop()
	updateValues();
	if transitionSpeed > 0 then
		if currentMap ~= destinationMap then
			if not randoHappened then
				performRandomisation(currentMap, destinationMap);
				flagsToSet();
				randoHappened = true;
			end
		end
	elseif transitionSpeed < 0 then
		randoHappened = false
	end
	if currentMap == 0x50 then -- Main Menu
		if destinationMap == 0xB0 or destinationMap == 0x22 then
			flagsToSet();
		end
	end
end

generateLevelAssortment();
setCountsFromAssortment();
print("Generated Assortment with no defined seed")
print("")

function setSeed(number)
	math.randomseed(number);
	generateLevelAssortment();
	setCountsFromAssortment();
	print("Generated Assortment for seed: "..number)
	print("")
end

function spoiler()
	printAssortment();
	print("")
end

event.onframeend(frameLoop, "Event series on a frame");