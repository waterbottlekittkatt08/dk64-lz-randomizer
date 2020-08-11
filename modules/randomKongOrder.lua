-- Randomize where kongs are unlocked

kong_cage_assortment = {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4,
	[5] = 5,
}

function generateRandomKongOrder()
	kongcage_seed = seedAsNumber;
	math.randomseed(kongcage_seed);
	
	kong_freers = {1,2,3} --can only be DK/Diddy/Lanky to free more kongs
	kong_non_freers = {4,5} --Tiny/Chunky cannot free more kongs

	kong_cages_openable = { --which cages each kong is able to open
		[1] = {2,3},
		[2] = {4},
		[3] = {5},
		[4] = {},
		[5] = {},
	}

	cage_status_locked = 0;
	cage_status_available = 1;
	cage_status_used = 2;
	cage_statuses = {
		[1] = 1, --cage 1 is the starting kong
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
	};
	cages_available = {1};
	
	--Determine where the kong freers will go
	while #kong_freers > 0 do
		--for a random available cage, choose next freeing kong
		nextCage = RemoveRandomValueFromTable(cages_available);
		current_kong = RemoveRandomValueFromTable(kong_freers);
		kong_cage_assortment[nextCage] = current_kong;
		
		--make sure we don't use the same cage twice
		cage_statuses[nextCage] = cage_status_used;
		
		--check which cages our current kong can open & mark as available
		for i = 1, #kong_cages_openable[current_kong] do
			--only add if cage is not used up yet
			cage = kong_cages_openable[current_kong][i];
			if cage_statuses[cage] == cage_status_locked then
				cage_statuses[cage] = cage_status_available;
				table.insert(cages_available, cage);
			end
		end
		--iterate for remaining kong freers
	end
	
	--after all kong freers are assigned, randomly assign the non-freers to the remaining available cages
	while #kong_non_freers > 0 do
		nextCage = RemoveRandomValueFromTable(cages_available);
		kong_cage_assortment[nextCage] = RemoveRandomValueFromTable(kong_non_freers);
	end
end

function RemoveRandomValueFromTable(tableOfValues)
	if #tableOfValues == 0 then
		return nil;
	end
	index = randomBetween(1,#tableOfValues);
	selectedValue = tableOfValues[index];
	table.remove(tableOfValues, index);
	return selectedValue;
end