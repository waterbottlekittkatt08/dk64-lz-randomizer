-- Random Move/Upgrade Prices

--Initializing with the standard prices
cranky_solo_prices = {
	[1] = {3,5,7}, -- Donkey
	[2] = {3,5,7}, -- Diddy
	[3] = {3,5,7}, -- Lanky
	[4] = {3,5,7}, -- Tiny
	[5] = {3,5,7}, -- Chunky
};
cranky_slam_prices = {
	[2] = 5, --Super
	[3] = 7, --Duper
};
funky_solo_prices = {
	[1] = 3, -- Donkey
	[2] = 3, -- Diddy
	[3] = 3, -- Lanky
	[4] = 3, -- Tiny
	[5] = 3, -- Chunky
};
funky_ammo_prices = {
	[1] = 3, --Ammo 1
	[2] = 5, --Ammo 2
};
funky_upgrade_prices = {
	[2] = 5, --Homing
	[3] = 7, --Sniper
};
candy_solo_prices = {
	[1] = 3, -- Donkey
	[2] = 3, -- Diddy
	[3] = 3, -- Lanky
	[4] = 3, -- Tiny
	[5] = 3, -- Chunky
};
candy_upgrade_prices = {
	[2] = 5, --Upgrade 1
	[3] = 7, --3rd Melon
	[4] = 9, --Upgrade 2
};

price_lower = {3,5,7};
price_upper = {3,5,7};
price_upper_limit = 15;

function setPriceRanges()
	--Initializing with the price tier to use for each move
	if settings.gameLengths == 1 then
		price_lower = {1,3,5};
		price_upper = {5,7,9};
		--average = 15
		price_upper_limit = 18;
	elseif settings.gameLengths == 2 then
		price_lower = {2,4,6};
		price_upper = {8,10,12};
		--average = 21
		price_upper_limit = 25;
	elseif settings.gameLengths == 3 then
		price_lower = {3,6,9};
		price_upper = {9,12,15};
		--average = 27
		price_upper_limit = 32;
	end
end

function generateRandomPrices()
	price_seedSetting = seedAsNumber + 69;
	--print("Price seed: "..price_seedSetting);
	math.randomseed(price_seedSetting);
	for kong = 1, 5 do
		--print("Cranky Moves");
		for tier = 1, 3 do
			cranky_solo_prices[kong][tier] = randomBetween(price_lower[tier], price_upper[tier]);
		end
		--print("Guns");
		funky_solo_prices[kong] = randomBetween(price_lower[1], price_upper[1]);
		--print("Instruments");
		candy_solo_prices[kong] = randomBetween(price_lower[1], price_upper[1]);
	end
	--print("Simian Slams");
	for tier = 2, 3 do
		cranky_slam_prices[tier] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--print("Funky Ammo");
	for tier = 1, 2 do
		funky_ammo_prices[tier] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--print("Funky Upgrades");
	for tier = 2, 3 do
		funky_upgrade_prices[tier] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--print("Candy Upgrades");
	for tier = 2, 4 do
		if tier == 4 then
			candy_upgrade_prices[tier] = 801;
		else
			candy_upgrade_prices[tier] = randomBetween(price_lower[tier], price_upper[tier]);
		end
	end
end

--Variables to determine price
move_types = {
	[0] = 'Cranky',
	[1] = 'Slam',
	[2] = 'Gun',
	[3] = 'Ammo',
	[4] = 'Candy',
};

function getPriceToUse(kong, move_type, price_tier)
	price = nil;
	if move_types[move_type] == 'Cranky' then
		price = cranky_solo_prices[kong][price_tier];
	elseif move_types[move_type] == 'Slam' then
		price = cranky_slam_prices[price_tier];
	elseif move_types[move_type] == 'Gun' then
		if price_tier == 1 then
			price = funky_solo_prices[kong];
		else
			price = funky_upgrade_prices[price_tier];
		end
	elseif move_types[move_type] == 'Ammo' then
		price = funky_ammo_prices[price_tier];
	elseif move_types[move_type] == 'Candy' then
		if price_tier == 1 then
			price = candy_solo_prices[kong];
		else
			price = candy_upgrade_prices[price_tier];
		end
	end
	if price == nil then
		price = "N/A"
	end
	return price;
end

