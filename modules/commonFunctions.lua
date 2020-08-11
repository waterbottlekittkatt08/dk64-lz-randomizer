function table_invert(t)
   local s={}
   for k,v in pairs(t) do
	 s[v]=k
   end
   return s
end

function isValInTable(v, tbl)
	for key,val in ipairs(tbl) do if val==v then return true end end
end

function differenceOfSets(setA,setB)
	local ret = {}
	for key,val in ipairs(setA) do
		if not isValInTable(val,setB) then table.insert(ret, val) end
	end
	return ret
end

function unionOfSets(setA,setB)
	local ret = {}
	for key,val in ipairs(setA) do
		table.insert(ret, val);
	end
	for key,val in ipairs(setB) do
		if not isValInTable(val,setA) then table.insert(ret, val) end
	end
	return ret
end

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
