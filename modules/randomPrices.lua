-- Random Move/Upgrade Prices

--Initializing with the price tier to use for each move
cranky_solo_prices = {
	[1] = {1,2,3}, -- Donkey
	[2] = {1,2,3}, -- Diddy
	[3] = {1,2,3}, -- Lanky
	[4] = {1,2,3}, -- Tiny
	[5] = {1,2,3}, -- Chunky
};
cranky_slam_prices = {2,3}; --Super, Super Duper
funky_solo_prices = {
	[1] = {1}, -- Donkey
	[2] = {1}, -- Diddy
	[3] = {1}, -- Lanky
	[4] = {1}, -- Tiny
	[5] = {1}, -- Chunky
};
funky_ammo_prices = {1,2,2,3}; --Ammo 1, Homing, Ammo 2, Sniper
candy_solo_prices = {
	[1] = {1}, -- Donkey
	[2] = {1}, -- Diddy
	[3] = {1}, -- Lanky
	[4] = {1}, -- Tiny
	[5] = {1}, -- Chunky
};
candy_upgrade_prices = {2,3,4}; --Upgrade 1, 3rd Melon, Upgrade 2

if settings.gameLengths == 1 then
	price_lower = {1,3,5,7};
	price_upper = {5,7,9,11};
elseif settings.gameLengths == 2 then
	price_lower = {3,6,9,12};
	price_upper = {9,12,15,18};
elseif settings.gameLengths == 3 then
	price_lower = {5,10,15,20};
	price_upper = {15,20,25,30};
end

function generateRandomPrices()
	price_seedSetting = seedAsNumber + 69;
	math.randomseed(price_seedSetting);
	for kong = 1, 5 do
		--Cranky Moves
		for move = 1, 3 do
			tier = cranky_solo_prices[kong][move];
			cranky_solo_prices[kong][move] = randomBetween(price_lower[tier], price_upper[tier]);
		end
		--Guns
		tier = funky_solo_prices[kong];
		funky_solo_prices[kong] = randomBetween(price_lower[tier], price_upper[tier]);
		--Instruments
		tier = candy_solo_prices[kong];
		candy_solo_prices[kong] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--Simian Slams
	for i = 1, #cranky_slam_prices
		tier = cranky_slam_prices[i];
		cranky_slam_prices[i] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--Funky Upgrades
	for i = 1, #funky_ammo_prices
		tier = funky_ammo_prices[i];
		funky_ammo_prices[i] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--Candy Upgrades
	for i = 1, #candy_upgrade_prices
		tier = candy_upgrade_prices[i];
		candy_upgrade_prices[i] = randomBetween(price_lower[tier], price_upper[tier]);
	end
end

--Variables to determine price
shop_types {
	[1] = 'Cranky',
	[2] = 'Funky',
	[3] = 'Candy',
};

price_tiers {
	[1] = '3',
	[2] = '5',
	[3] = '7',
	[4] = '9',
};

move_types {
	[0] = 'Cranky'
	[1] = 'Slam',
	[2] = 'Gun',
	[3] = 'Ammo',
	[4] = 'Candy',
};

function getPriceToUse(kong, shop_type, move_type, price_tier)
	price = 0;
	if shop_types[shop_type] == 'Cranky' then
		if move_types[move_type] = 'Cranky' then
			price = cranky_solo_prices[kong][price_tier];
		else if move_types[move_type] = 'Slam' then
			price = cranky_slam_prices[price_tier-1];
		end
	else if shop_types[shop_type] == 'Funky' then
	
	end
	else if shop_types[shop_type] == 'Candy' then
	
	end
	return price;
end

