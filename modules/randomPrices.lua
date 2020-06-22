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
price_kong_upper_limit = 21;

function setPriceRanges()
	--Initializing with the price tier to use for each move
	if settings.gameLengths == 1 then
		price_lower = {1,3,5};
		price_upper = {5,7,9};
		--average = 21, max = 31
		price_kong_upper_limit = 26;
	elseif settings.gameLengths == 2 then
		price_lower = {2,4,6};
		price_upper = {6,8,10};
		--average = 26, max = 36
		price_kong_upper_limit = 31;
	elseif settings.gameLengths == 3 then
		price_lower = {3,5,7};
		price_upper = {7,9,11};
		--average = 31, max = 41
		price_kong_upper_limit = 36;
	end
end

function generateRandomPrices()
	price_seedSetting = seedAsNumber + 69;
	--print("Price seed: "..price_seedSetting);
	math.randomseed(price_seedSetting);
	
	--print("Kong upper limit: "..price_kong_upper_limit);
	
	for kong = 1, 5 do
		--print("Cranky Moves");
		kong_total = 0;
		for tier = 1, 3 do
			cranky_solo_prices[kong][tier] = randomBetween(price_lower[tier], price_upper[tier]);
			kong_total = kong_total + cranky_solo_prices[kong][tier];
		end
		--print("Guns");
		funky_solo_prices[kong] = randomBetween(price_lower[1], price_upper[1]);
		kong_total = kong_total + funky_solo_prices[kong];
		--print("Instruments");
		candy_solo_prices[kong] = randomBetween(price_lower[1], price_upper[1]);
		kong_total = kong_total + candy_solo_prices[kong];
		
		--Adjust for kong upper limit
		--print(kongNames[kong].." Kong total unadjusted: "..kong_total);
		
		while kong_total > price_kong_upper_limit do
			move_to_adjust = randomBetween(1,5);
			if move_to_adjust == 1 and cranky_solo_prices[kong][1] > price_lower[1] then
				--print("  adjusting cranky 1st move down...");
				cranky_solo_prices[kong][1] = cranky_solo_prices[kong][1] - 1;
				kong_total = kong_total - 1;
			elseif move_to_adjust == 2 and cranky_solo_prices[kong][2] > price_lower[2] then
				--print("  adjusting cranky 2nd move down...");
				cranky_solo_prices[kong][2] = cranky_solo_prices[kong][2] - 1;
				kong_total = kong_total - 1;
			elseif move_to_adjust == 3 and cranky_solo_prices[kong][3] > price_lower[3] then
				--print("  adjusting cranky 3rd move down...");
				cranky_solo_prices[kong][3] = cranky_solo_prices[kong][3] - 1;
				kong_total = kong_total - 1;
			elseif move_to_adjust == 4 and funky_solo_prices[kong] > price_lower[1] then
				--print("  adjusting gun down...");
				funky_solo_prices[kong] = funky_solo_prices[kong] - 1;
				kong_total = kong_total - 1;
			elseif move_to_adjust == 5 and candy_solo_prices[kong] > price_lower[1] then
				--print("  adjusting instrument down...");
				candy_solo_prices[kong] = candy_solo_prices[kong] - 1;
				kong_total = kong_total - 1;
			end
		end
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

