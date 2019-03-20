transferred_actor_type = {0x7FD570,nil,nil};
controls_bitfield = {0x014DC4,nil,nil};
	-- +0x0
		-- 1000 0000 = A
		-- 0100 0000 = B
		-- 0010 0000 = Z
		-- 0001 0000 = S
		-- 0000 1000 = DU
		-- 0000 0100 = DD
		-- 0000 0010 = DL
		-- 0000 0001 = DR
	-- +0x1
		-- 0010 0000 = L
		-- 0001 0000 = R
		-- 0000 1000 = CU
		-- 0000 0100 = CD
		-- 0000 0010 = CL
		-- 0000 0001 = CR

acceptable_tagMaps = {
	0x26
};

function getBoneArray1(actorPointer)
	if isRDRAM(actorPointer) then
		local animationParamObject = dereferencePointer(actorPointer + 0x4);
		if isRDRAM(animationParamObject) then
			return mainmemory.read_u32_be(animationParamObject + 0x14);
		end
	end
	return 0;
end

function getBoneArray2(actorPointer)
	if isRDRAM(actorPointer) then
		local animationParamObject = dereferencePointer(actorPointer + 0x4);
		if isRDRAM(animationParamObject) then
			return mainmemory.read_u32_be(animationParamObject + 0x18);
		end
	end
	return 0;
end

function writeStoredX1(actorPointer,value)
	local boneArray1 = getBoneArray1(actorPointer);
	if isPointer(boneArray1) then
		boneArray1 = boneArray1 - RDRAMBase;
		mainmemory.write_s16_be(boneArray1 + 0x58,value);
	end
end

function writeStoredX2(actorPointer,value)
	local boneArray2 = getBoneArray2(actorPointer);
	if isPointer(boneArray2) then
		boneArray2 = boneArray2 - RDRAMBase;
		mainmemory.write_s16_be(boneArray2 + 0x58,value);
	end
end

function writeStoredY1(actorPointer,value)
	local boneArray1 = getBoneArray1(actorPointer);
	if isPointer(boneArray1) then
		boneArray1 = boneArray1 - RDRAMBase;
		mainmemory.write_s16_be(boneArray1 + 0x5A,value);
	end
end

function writeStoredY2(actorPointer,value)
	local boneArray2 = getBoneArray2(actorPointer);
	if isPointer(boneArray2) then
		boneArray2 = boneArray2 - RDRAMBase;
		mainmemory.write_s16_be(boneArray2 + 0x5A,value);
	end
end

function writeStoredZ1(actorPointer,value)
	local boneArray1 = getBoneArray1(actorPointer);
	if isPointer(boneArray1) then
		boneArray1 = boneArray1 - RDRAMBase;
		mainmemory.write_s16_be(boneArray1 + 0x5C,value);
	end
end

function writeStoredZ2(actorPointer,value)
	local boneArray2 = getBoneArray2(actorPointer);
	if isPointer(boneArray2) then
		boneArray2 = boneArray2 - RDRAMBase;
		mainmemory.write_s16_be(boneArray2 + 0x5C,value);
	end
end

function tagBarrel_isAcceptable(destmap)
	for i = 1, #acceptable_tagMaps do
		if acceptable_tagMaps[i] == destmap then
			return true;
		end
	end
	return false
end

function tagBarrel_getDistance(A,B)
	Dx = math.abs(B[1]-A[1]);
	Dy = math.abs(B[2]-A[2]);
	Dz = math.abs(B[3]-A[3]);
	DiagXZ = math.sqrt(((Dx) ^ 2) + ((Dz) ^ 2));
	DiagXYZ = math.sqrt(((Dy) ^ 2) + ((DiagXZ) ^ 2));
	return DiagXYZ;
end

tagBarrel_target = 0;
tagBarrel_dest = -500;
tagBarrel_reposition = true;

function tagBarrel_displace()
	obj_m2_timer_value = mainmemory.read_u32_be(Mem.obj_model2_timer[version]);
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	is_acceptableMap = tagBarrel_isAcceptable(current_cmap);
	player = getPlayerObject();
	if obj_m2_timer_value < 5 and obj_m2_timer_value > 0 and is_acceptableMap then
		if tagBarrel_target == 0 then
			tagBarrels = getActorPointers(136); -- Tag Barrels
			if isRDRAM(player) then
				if #tagBarrels > 0 then
					minDist = 10000;
					minTag = 0;
					p_coords = {};
					for i = 0, 2 do
						p_coords[i + 1] = mainmemory.readfloat(player + 0x7C + (4 * i),true);
					end
					for i = 1, #tagBarrels do
						t_coords = {};
						for j = 0, 2 do
							t_coords[j + 1] = mainmemory.readfloat(tagBarrels[i] + 0x7C + (4 * j),true);
						end
						p_to_t_dist = tagBarrel_getDistance(p_coords,t_coords)
						if p_to_t_dist < minDist then
							minDist = p_to_t_dist;
							minTag = i;
						end
					end
				end
			end
		end
		if minTag ~= nil then
			if minTag > 0 then
				tagBarrels = getActorPointers(136)
				tagBarrel_target = tagBarrels[minTag];
				tagBarrel_reposition = true;
			end
		end
	end
end

function tagBarrel_insert()
	transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
	zipProg = mainmemory.readbyte(Mem.zipper_progress[version]);
	current_dmap = mainmemory.read_u32_be(Mem.dmap[version]);
	if transition_speed_value > 0 and zipProg < 10 then
		is_acceptableMap = tagBarrel_isAcceptable(current_dmap);
		if is_acceptableMap then
			mainmemory.write_u16_be(transferred_actor_type[version],136);
		end
		tagBarrel_target = 0;
		minTag = nil;
		tagBarrel_reposition = false;
	end
end

function tagBarrel_reinsert()
	player = getPlayerObject();
	if isRDRAM(player) then
		p_coords = {};
		p_chunk = mainmemory.read_u16_be(player + 0x12C);
		mainmemory.write_u16_be(tagBarrel_target + 0x12C, p_chunk);
		for j = 0, 2 do
			p_coords[j + 1] = mainmemory.readfloat(player + 0x7C + (4 * j),true);
			mainmemory.writefloat(tagBarrel_target + 0x7C + (4 * j),p_coords[j + 1],true);
			if j == 0 then
				writeStoredX1(tagBarrel_target,math.floor(p_coords[j + 1]));
				writeStoredX2(tagBarrel_target,math.floor(p_coords[j + 1]));
			end
			if j == 1 then
				writeStoredY1(tagBarrel_target,math.floor(p_coords[j + 1]));
				writeStoredY2(tagBarrel_target,math.floor(p_coords[j + 1]));
				mainmemory.writefloat(tagBarrel_target + 0xA4,p_coords[j + 1],true);
				mainmemory.writefloat(tagBarrel_target + 0x19C,p_coords[j + 1],true);
			end
			if j == 2 then
				writeStoredZ1(tagBarrel_target,math.floor(p_coords[j + 1]));
				writeStoredZ2(tagBarrel_target,math.floor(p_coords[j + 1]));
			end
		end
		tagBarrel_reposition = false;
	end
end

function tagBarrel_redisplace()
	tagBarrel_reposition = true;
end

function tagBarrel_setStartingKong(kong)
	mainmemory.writebyte(tagBarrel_target + 0x17E,kong); -- Current
	mainmemory.writebyte(tagBarrel_targer + 0x17F,kong); -- Previous
end

function tagBarrel_getDPadCharacters()
	current_kong = mainmemory.readbyte(Mem.character[version]);
	dpad_kongs = {}; -- DU,DR,DD,DL
	dpad_counter = 0;
	for i = 0, 4 do
		if current_kong ~= i then
			dpad_counter = dpad_counter + 1;
			dpad_kongs[dpad_counter] = i;
		end
	end
	return dpad_kongs;
end

function tagBarrel_positioning()
	player = getPlayerObject();
	if isRDRAM(player) and tagBarrel_target ~= nil then
		if tagBarrel_target > 0 then
			p_chunk = mainmemory.read_u16_be(player + 0x12C);
			mainmemory.write_u16_be(tagBarrel_target + 0x12C, p_chunk);
			p_coords = {};
			for j = 0, 2 do
				p_coords[j + 1] = mainmemory.readfloat(player + 0x7C + (4 * j),true);
				mainmemory.writefloat(tagBarrel_target + 0x7C + (4 * j),p_coords[j + 1],true);
				if j == 0 then
					writeStoredX1(tagBarrel_target,math.floor(p_coords[j + 1]));
					writeStoredX2(tagBarrel_target,math.floor(p_coords[j + 1]));
					p_coords[j + 1] = mainmemory.readfloat(player + 0x7C + (4 * j),true);
				end
				if j == 1 then
					writeStoredY1(tagBarrel_target,math.floor(tagBarrel_dest + p_coords[j + 1]));
					writeStoredY2(tagBarrel_target,math.floor(tagBarrel_dest + p_coords[j + 1]));
					mainmemory.writefloat(tagBarrel_target + 0xA4,tagBarrel_dest + p_coords[j + 1],true);
					mainmemory.writefloat(tagBarrel_target + 0x19C,tagBarrel_dest + p_coords[j + 1],true);
					mainmemory.writefloat(tagBarrel_target + 0x7C + (4 * j),tagBarrel_dest + p_coords[j + 1],true);
					mainmemory.writefloat(tagBarrel_target + 0x19C, tagBarrel_dest + p_coords[j + 1],true);
				end
				if j == 2 then
					writeStoredZ1(tagBarrel_target,math.floor(p_coords[j + 1]));
					writeStoredZ2(tagBarrel_target,math.floor(p_coords[j + 1]));
					p_coords[j + 1] = mainmemory.readfloat(player + 0x7C + (4 * j),true);
				end
			end
		end
	end
end

previous_A = false;
previous_B = false;
previous_L = false;
previous_Z = false;
previous_DU = false;
previous_DD = false;
previous_DL = false;
previous_DR = false;

function tagBarrel_checkNewA()
	new_A = check_bit(mainmemory.readbyte(controls_bitfield[version]),7);
	if new_A and not previous_A then
		previous_A = new_A;
		print("A");
		return true;
	end
	previous_A = new_A;
	return false;
end

function tagBarrel_checkNewB()
	new_B = check_bit(mainmemory.readbyte(controls_bitfield[version]),6);
	if new_B and not previous_B then
		previous_B = new_B;
		print("B");
		return true;
	end
	previous_B = new_B;
	return false;
end

function tagBarrel_checkNewL()
	new_L = check_bit(mainmemory.readbyte(controls_bitfield[version]+0x1),5);
	if new_L and not previous_L then
		previous_L = new_L;
		print("L");
		return true;
	end
	previous_L = new_L;
	return false;
end

function tagBarrel_checkNewZ()
	new_Z = check_bit(mainmemory.readbyte(controls_bitfield[version]),5);
	if new_Z and not previous_Z then
		previous_Z = new_Z;
		print("Z");
		return true;
	end
	previous_Z = new_Z;
	return false;
end

function tagBarrel_checknewDU()
	new_DU = check_bit(mainmemory.readbyte(controls_bitfield[version]),3);
	if new_DU and not previous_DU then
		previous_DU = new_DU;
		print("DU");
		return true;
	end
	previous_DD = new_DU;
	return false;
end

function tagBarrel_checkNewDD()
	new_DD = check_bit(mainmemory.readbyte(controls_bitfield[version]),2);
	if new_DD and not previous_DD then
		previous_DD = new_DD;
		print("DD");
		return true;
	end
	previous_DD = new_DD;
	return false;
end

function tagBarrel_checkNewDL()
	new_DL = check_bit(mainmemory.readbyte(controls_bitfield[version]),1);
	if new_DL and not previous_DL then
		previous_DL = new_DL;
		print("DL");
		return true;
	end
	previous_DL = new_DL;
	return false;
end

function tagBarrel_checkNewDR()
	new_DR = check_bit(mainmemory.readbyte(controls_bitfield[version]),0);
	if new_DR and not previous_DR then
		previous_DR = new_DR;
		print("DR");
		return true;
	end
	previous_DR = new_DR;
	return false;
end

function tagBarrel_reinsert_conditions()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	is_acceptableMap = tagBarrel_isAcceptable(current_cmap);
	L_new = tagBarrel_checkNewL();
	if is_acceptableMap then
		if L_new then -- L
			return true;
		end
	end
	return false;
end

function tagBarrel_coordsGet()
	tag_coords = {};
	for i = 1, 3 do
		tag_coords[i] = mainmemory.readfloat(tagBarrel_target + 0x78 + (4 * i),true);
	end
	return tag_coords;
end

function tagBarrel_redisplace_conditions()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	is_acceptableMap = tagBarrel_isAcceptable(current_cmap);
	A_new = tagBarrel_checkNewA();
	B_new = tagBarrel_checkNewB();
	Z_new = tagBarrel_checkNewZ();
	if is_acceptableMap then
		if Z_new or B_new or A_new then -- Z/B/A
			return true;
		end
	end
	return false;
end

function tagBarrel_switchKong()
	DU_new = tagBarrel_checknewDU();
	DD_new = tagBarrel_checknewDD();
	DL_new = tagBarrel_checknewDL();
	DR_new = tagBarrel_checknewDR();
	dpad = tagBarrel_getDPadCharacters()
	if DU_new then
		tagBarrel_setStartingKong(dpad[1]);
	elseif DR_new then
		tagBarrel_setStartingKong(dpad[2]);
	elseif DD_new then
		tagBarrel_setStartingKong(dpad[3]);
	elseif DL_new then
		tagBarrel_setStartingKong(dpad[4]);
	end
end

function tagBarrel_eventCycle()
	tagBarrel_insert();
	tagBarrel_displace();
	tB_ri_c = tagBarrel_reinsert_conditions();
	tB_rd_c = tagBarrel_redisplace_conditions();
	if tB_ri_c then
		tagBarrel_reinsert();
	end
	if tB_rd_c then
		tagBarrel_redisplace();
	end
	if tagBarrel_reposition then
		tagBarrel_positioning();
	end
end

event.onframestart(tagBarrel_eventCycle, "Tag Barrel Event Cycle");