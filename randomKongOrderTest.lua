print("Testing random kong order");

kongNames = {
	[1] = "DK",
	[2] = "Diddy",
	[3] = "Lanky",
	[4] = "Tiny",
	[5] = "Chunky",
};

require "modules.commonFunctions";
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

--Distribution Statistics
kong_distribution = {
	[1] = {0,0,0,0,0},
	[2] = {0,0,0,0,0},
	[3] = {0,0,0,0,0},
	[4] = {0,0,0,0,0},
	[5] = {0,0,0,0,0},
};
iterations = 99999;

print("Generating Distribution data...")
for n=1,iterations do
	seedAsNumber = n;
	--print(seedAsNumber);
	generateRandomKongOrder();
	for cage=1,5 do
		kong = kong_cage_assortment[cage]
		kong_distribution[cage][kong] = kong_distribution[cage][kong] + 1;
	end
end

for cage=1,5 do
	print("Distribution of cage "..cage..": ")
	for kong=1,5 do
		percentage = (kong_distribution[cage][kong] / iterations) * 100;
		print("  "..kongNames[kong]..": "..percentage.."%");
	end
end
