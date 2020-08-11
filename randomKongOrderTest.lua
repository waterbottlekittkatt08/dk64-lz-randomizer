print("Testing random kong order");

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

function chooseRandomIndex(tbl)
	local random_index = randomBetween(1,#tbl);
	return random_index;
end

require "modules.randomKongOrder";

seedAsNumber = randomBetween(0,99999);
print("Seed: "..seedAsNumber);

print("Generating Random Kong Order...");
generateRandomKongOrder();

print("Random Kong Order:");
print("  Starting Kong is   "..kongNames[kong_cage_assortment[1]]);
print("  Kong in Japes is   "..kongNames[kong_cage_assortment[2]]);
print("  Kong in Llama is   "..kongNames[kong_cage_assortment[3]]);
print("  Kong in OKONG is   "..kongNames[kong_cage_assortment[4]]);
print("  Kong in Factory is "..kongNames[kong_cage_assortment[5]]);

