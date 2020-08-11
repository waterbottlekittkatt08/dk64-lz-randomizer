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

