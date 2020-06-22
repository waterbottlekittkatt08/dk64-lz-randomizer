print("Testing random prices");

settings = {
	randomiser = 0,
	all_moves = 0,
	no_cutscenes = 0,
	all_kongs = 0,
	using_jabos = 0,
	random_kasplats = 0,
	randomiser_barrel = 0,
	tag_anywhere = 0,
	gameLengths = 1,
};

kongNames = {
	[1] = "DK",
	[2] = "Diddy",
	[3] = "Lanky",
	[4] = "Tiny",
	[5] = "Chunky",
};

function randomBetween(min_rand,max_rand)
	rand_diff = max_rand - min_rand + 1;
	rand_numb = (min_rand - 1) + math.ceil(math.random() * rand_diff);
	if rand_numb < (min_rand + 1) then
		rand_numb = min_rand;
	elseif rand_numb > max_rand then
		rand_numb = max_rand;
	end
	return rand_numb;
end

require "modules.randomPrices";

for length = 1,3 do
	print("Setting Game Length to "..length);
	settings.gameLengths = length;
	
	seedAsNumber = randomBetween(0,99999);
	print("Seed: "..seedAsNumber);

	setPriceRanges();
	
	print("Price ranges:");
	for i = 1, 3 do
		print("  Tier "..i..": "..price_lower[i].." to "..price_upper[i]);
	end

	print("Generating Random Prices...");
	generateRandomPrices();
	
	print("Prices: ");
	for move_type = 0, 4 do
		for tier = 1,4 do
			for kong = 1, 5 do
				print("  "..kongNames[kong].." "..move_types[move_type].." "..tier..": "..getPriceToUse(kong,move_type,tier));
			end
		end
	end
end
