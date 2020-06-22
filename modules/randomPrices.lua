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
	[1] = 1, -- Donkey
	[2] = 1, -- Diddy
	[3] = 1, -- Lanky
	[4] = 1, -- Tiny
	[5] = 1, -- Chunky
};
funky_ammo_prices = {1,2}; --Ammo 1, Ammo 2
funky_upgrade_prices = {2,3}; --Homing, Sniper

candy_solo_prices = {
	[1] = 1, -- Donkey
	[2] = 1, -- Diddy
	[3] = 1, -- Lanky
	[4] = 1, -- Tiny
	[5] = 1, -- Chunky
};
candy_upgrade_prices = {2,3,4}; --Upgrade 1, 3rd Melon, Upgrade 2

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

function generateRandomPrices()
	price_seedSetting = seedAsNumber + 69;
	--print("Price seed: "..price_seedSetting);
	math.randomseed(price_seedSetting);
	for kong = 1, 5 do
		--print("Cranky Moves");
		for move = 1, 3 do
			tier = cranky_solo_prices[kong][move];
			cranky_solo_prices[kong][move] = randomBetween(price_lower[tier], price_upper[tier]);
		end
		--print("Guns");
		tier = funky_solo_prices[kong];
		funky_solo_prices[kong] = randomBetween(price_lower[tier], price_upper[tier]);
		--print("Instruments");
		tier = candy_solo_prices[kong];
		candy_solo_prices[kong] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--print("Simian Slams");
	for i = 1, #cranky_slam_prices do
		tier = cranky_slam_prices[i];
		cranky_slam_prices[i] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--print("Funky Ammo");
	for i = 1, #funky_ammo_prices do
		tier = funky_ammo_prices[i];
		funky_ammo_prices[i] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--print("Funky Upgrades");
	for i = 1, #funky_ammo_prices do
		tier = funky_upgrade_prices[i];
		funky_upgrade_prices[i] = randomBetween(price_lower[tier], price_upper[tier]);
	end
	--print("Candy Upgrades");
	for i = 1, #candy_upgrade_prices do
		tier = candy_upgrade_prices[i];
		if tier == 4 then
			candy_upgrade_prices[i] = 801;
		else
			candy_upgrade_prices[i] = randomBetween(price_lower[tier], price_upper[tier]);
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
		price = cranky_slam_prices[price_tier - 1];
	elseif move_types[move_type] == 'Gun' then
		if price_tier == 1 then
			price = funky_solo_prices[kong];
		else
			price = funky_upgrade_prices[price_tier - 1];
		end
	elseif move_types[move_type] == 'Ammo' then
		price = funky_ammo_prices[price_tier];
	elseif move_types[move_type] == 'Candy' then
		if price_tier == 1 then
			price = candy_solo_prices[kong];
		else
			price = candy_upgrade_prices[price_tier - 1];
		end
	end
	if price == nil then
		price = "N/A"
	end
	return price;
end

