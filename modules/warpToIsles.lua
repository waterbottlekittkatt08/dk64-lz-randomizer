text = {
	{"TO LOBBY", 2},
	{"TO LEVEL", 5},
}

left_arrow = 0x77;
right_arrow = 0x65;
new_text = "GO HOME"; -- Must not exceed 14 characters
easter_egg_text = { -- DKC TV Show "Eddie, let me go back to my home" lyrics
	{"NO!", 30},
	{"I", 10},
	{"CANT", 10},
	{"BELIEVE", 10},
	{"WHAT", 10},
	{"I", 10},
	{"SEE!", 30},
	{"EVERYTHINGS", 10},
	{"UPSIDE", 10},
	{"DOWN", 10},
	{"AND", 10},
	{"IT", 10},
	{"MAKES", 10},
	{"NO", 10},
	{"SENSE ", 10},
	{"TO", 10},
	{"ME!", 30},
	{"IN", 10},
	{"MY", 10},
	{"CURRENT", 10},
	{"STATE,", 30},
	{"I", 10},
	{"CANT", 10},
	{"CHANGE", 10},
	{"THEIR", 10},
	{"FATE", 30},
	{"IF", 10},
	{"YOU", 10},
	{"SEND", 10},
	{"ME", 10},
	{"BACK,", 10},
	{"I", 10},
	{"SWEAR", 10},
	{"ILL", 10},
	{"SET", 10},
	{"THINGS", 10},
	{"STRAIGHT", 30},
	{"YOU", 10},
	{"GOTTA", 10},
	{"SEND", 10},
	{"ME", 10},
	{"BACK!", 30},
	{"NO", 15},
	{"CAN", 15},
	{"DO!", 40},
	{"IVE", 10},
	{"BEEN", 10},
	{"DISSED!", 30},
	{"YOU", 15},
	{"NOT", 15},
	{"EXIST!", 40},
	{"EDDIE,", 10},
	{"LET", 10},
	{"ME", 10},
	{"GO", 10},
	{"BACK", 10},
	{"TO", 10},
	{"MY", 10},
	{"HOME!", 30},
	{"WITHOUT", 10},
	{"ME,", 10},
	{"EVERYTHINGS", 10},
	{"ALL", 10},
	{"WRONG!", 30},
	{"EDDIE,", 10},
	{"LET", 10},
	{"ME", 10},
	{"GO", 10},
	{"BACK", 10},
	{"TO", 10},
	{"MY", 10},
	{"HOME!", 30},
	{"TO", 10},
	{"PUT", 10},
	{"THINGS", 10},
	{"BACK", 10},
	{"WHERE", 10},
	{"THEY", 10},
	{"BELONG!", 30},
	{"EDDIE,", 10},
	{"LET", 10},
	{"ME", 10},
	{"GO", 10},
	{"BACK", 10},
	{"TO", 10},
	{"MY", 10},
	{"HOME!", 30},
	{"WITHOUT", 10},
	{"ME,", 10},
	{"EVERYTHINGS", 10},
	{"ALL", 10},
	{"WRONG!", 30},
	{"EDDIE,", 10},
	{"LET", 10},
	{"ME", 10},
	{"GO", 10},
	{"BACK", 10},
	{"TO", 10},
	{"MY", 10},
	{"HOME!", 60},
	{"PLEASE!", 30},
	{"IM", 10},
	{"DOWN", 10},
	{"ON", 10},
	{"MY", 10},
	{"KNEES!", 30},
	{"THERES", 10},
	{"A", 10},
	{"WORLD", 10},
	{"THAT", 10},
	{"NEEDS", 10},
	{"SAVING,", 10},
	{"BABY", 10},
	{"BOBBY", 10},
	{"EDDIE", 10},
	{"YETI;", 10},
	{"JUST", 10},
	{"LET", 10},
	{"ME", 10},
	{"BE!", 30},
	{"OH", 20},
	{"MAN!", 20},
	{"WONT", 10},
	{"YOU", 10},
	{"HEAR", 10},
	{"MY", 10},
	{"PLEA?!", 30},
	{"COME", 10},
	{"ON,", 20},
	{"COME", 10},
	{"ON", 20},
	{"EDDIE,", 10},
	{"YOU", 10},
	{"GOT", 10},
	{"TO", 10},
	{"HELP", 10},
	{"ME!", 40},
	{"YOU", 10},
	{"GOTTA", 10},
	{"SEND", 10},
	{"ME", 10},
	{"BACK!", 30},
	{"ME", 15},
	{"NOT", 15},
	{"SURE!", 40},
	{"JUST", 10},
	{"ONE", 10},
	{"DAY?", 40},
	{"NO", 15},
	{"WAY,", 15},
	{"JOSE!", 40},
	{"EDDIE,", 10},
	{"LET", 10},
	{"ME", 10},
	{"GO", 10},
	{"BACK", 10},
	{"TO", 10},
	{"MY", 10},
	{"HOME!", 30},
	{"WITHOUT", 10},
	{"ME,", 10},
	{"EVERYTHINGS", 10},
	{"ALL", 10},
	{"WRONG!", 30},
	{"EDDIE,", 10},
	{"LET", 10},
	{"ME", 10},
	{"GO", 10},
	{"BACK", 10},
	{"TO", 10},
	{"MY", 10},
	{"HOME!", 30},
	{"TO", 10},
	{"PUT", 10},
	{"THINGS", 10},
	{"BACK", 10},
	{"WHERE", 10},
	{"THEY", 10},
	{"BELONG!", 30},
	{"EDDIE,", 10},
	{"LET", 10},
	{"ME", 10},
	{"GO", 10},
	{"BACK", 10},
	{"TO", 10},
	{"MY", 10},
	{"HOME!", 30},
	{"WITHOUT", 10},
	{"ME,", 10},
	{"EVERYTHINGS", 10},
	{"ALL", 10},
	{"WRONG!", 30},
	{"EDDIE,", 10},
	{"LET", 10},
	{"ME", 10},
	{"GO", 10},
	{"BACK", 10},
	{"TO", 10},
	{"MY", 10},
	{"HOME!", 60},
};
easter_egg_chance = 50; -- 1 in value (AKA 100 = 1 in 100)
free_memory_spot = 0x7FFFFF;
deadzone = 51; -- This is the deadzone for the pause menu
deadzone_y = 80;
has_chanced_for_easter_egg = false;
easter_egg_initiate_frame = -1;

permitted_maps = {
	-- Submaps
		0x4, 0x6, 0xC, 0xD, 0xE,
		0x10, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x1B, 0x1D, 0x1F,
		0x21, 0x24, 0x25, 0x27, 0x29, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 
		0x31, 0x33, 0x34, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
		0x40, 0x46, 0x47, 
		0x52, 0x54, 0x55, 0x56, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
		0x62, 0x64, 0x69, 0x6A, 0x6C, 0x6E,
		0x70, 0x71, 0x72, 
		0x97,
		0xA3, 0xA4, 0xA6, 0xA7, 0xA8,
		0xB3, 0xB7, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD,
		0xC3, 0xC8,
	-- Crowns
		0x35, 0x49, 0x9B, 0x9C, 0x9D, 0x9E, 0x9F, 0xA0, 0xA1, 0xA2, 
	-- Global Maps
		0x1, 0x5, 0xF,
		0x19,
		0x2A, 
		0x30,
		0x48,
		0x57, 
	-- Regular Maps
	 	0x7, 0x11,
	 	0x1A, 0x1E,
	 	0x26,
	-- Bosses
		0x8, 0x53, 0x6F, 0x9A, 0xC4, 0xC5, 0xC7,
};

function handlePerms()
	permitted = false;
	for i = 1, #permitted_maps do
		if current_cmap == permitted_maps[i] then
			permitted = true;
		end
	end
	if current_cmap == 0x11 and not checkFlag(0x60, 2) then
		permitted = false;
	end
	return permitted
end

function isRegular()
	return mainmemory.readbyte(free_memory_spot) == 0;
end

function writeText(address,text,includeLR)
	bytes = {};
	include_arrows = false;
	if includeLR and include_arrows then
		table.insert(bytes,left_arrow);
	end
	for i = 1, string.len(text) do
		table.insert(bytes, string.byte(text, i))
	end
	if includeLR and include_arrows then
		table.insert(bytes,right_arrow);
	end
	table.insert(bytes,0); -- Terminate the string
	for i = 1, #bytes do
		if isRDRAM(dereferencePointer(address)) then
			mainmemory.writebyte(dereferencePointer(address) + (i - 1), bytes[i]);
		end
	end
end

function handleInput()
	past_frame = mainmemory.read_s8(Mem.player1_input_last_frame[version]);
	current_frame = mainmemory.read_s8(Mem.player1_input_current_frame[version]);
	current_yinput = mainmemory.read_s8(Mem.player1_input_current_frame[version] + 1);
	if math.abs(current_yinput) < deadzone_y then
		if (math.abs(past_frame) < deadzone) and (math.abs(current_frame) > (deadzone - 1)) then
			return true;
		end
	end
	return false;
end

function handleEasterEgg(activated)
	if not activated then
		output = math.random() * easter_egg_chance;
		if output < 1 then
			easter_egg_initiate_frame = emu.framecount();
			return {true, true};
		else
			return {false, true};
		end
	end
	return {false, true};
end

function handleEasterEggText(initiate_frame, current_frame)
	time_into_easter_egg = current_frame - initiate_frame;
	for i = 1, #easter_egg_text do
		time_into_easter_egg = time_into_easter_egg - easter_egg_text[i][2];
		if time_into_easter_egg < 1 then
			return easter_egg_text[i][1];
		end
	end
	easter_egg_initiate_frame = -1;
	return new_text;
end

function handleText()
	transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
	if transition_speed_value < 0 then
		mainmemory.writebyte(free_memory_spot, 0);
	end
	pausemenu_pointers = getActorPointers(95);
	if #pausemenu_pointers > 0 then
		selected = mainmemory.readbyte(pausemenu_pointers[1] + 0x18F);
		is_allowed = handlePerms();
		if is_allowed then
			is_regular = isRegular();
			if selected > 1 and not is_regular then -- 2 = No "Are you sure", 3 = "Are you sure"
				handleWarp();
			end
			if selected == 2 and isRDRAM(dereferencePointer(Mem.text_pointers[version])) then -- Bottom Option Selected
				if is_regular then
					for i = 1, #text do
						writeText(dereferencePointer(Mem.text_pointers[version]) + (4 * text[i][2]), text[i][1], true);
					end
				else
					attempt = handleEasterEgg(has_chanced_for_easter_egg);
					has_chanced_for_easter_egg = attempt[2];
					if easter_egg_initiate_frame > -1 then
						for i = 1, #text do
							writeText(dereferencePointer(Mem.text_pointers[version]) + (4 * text[i][2]), handleEasterEggText(easter_egg_initiate_frame, emu.framecount()), true);
						end
					else
						for i = 1, #text do
							writeText(dereferencePointer(Mem.text_pointers[version]) + (4 * text[i][2]), new_text, true);
						end
					end
					
				end
				should_change = handleInput();
				if should_change and not emu.islagged() then
					mainmemory.writebyte(free_memory_spot, 1 - mainmemory.readbyte(free_memory_spot));
					has_chanced_for_easter_egg = false;
					easter_egg_initiate_frame = -1;
				end
			else
				if is_regular then
					for i = 1, #text do
						writeText(dereferencePointer(Mem.text_pointers[version]) + (4 * text[i][2]), text[i][1], false);
					end
				else
					attempt = handleEasterEgg(has_chanced_for_easter_egg);
					has_chanced_for_easter_egg = attempt[2];
					if easter_egg_initiate_frame > -1 then
						for i = 1, #text do
							writeText(dereferencePointer(Mem.text_pointers[version]) + (4 * text[i][2]), handleEasterEggText(easter_egg_initiate_frame, emu.framecount()), false);
						end
					else
						for i = 1, #text do
							writeText(dereferencePointer(Mem.text_pointers[version]) + (4 * text[i][2]), new_text, true);
						end
					end
				end
			end
		end
	else
		mainmemory.writebyte(free_memory_spot, 0);
	end
end

function handleWarp()
	transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
	mainmemory.writebyte(Mem.cutscene_fade_active[version], 0);
	mainmemory.writebyte(Mem.mode[version], 6);
	mainmemory.writebyte(Mem.mode[version] - 4, 6);
	-- transition_type = mainmemory.readbyte(Mem.loading_zone_transition_type[version]);
	-- if transition_type == 1 then
	-- 	mainmemory.writebyte(Mem.loading_zone_transition_type[version], 3);
	-- elseif not transition_type == 3 then
		mainmemory.writebyte(Mem.loading_zone_transition_type[version], 1);
	--end
	if transition_speed_value > 0 then
		mainmemory.write_u32_be(Mem.dmap[version],0x22) -- Isles
		mainmemory.write_u32_be(Mem.dexit[version],0);
	end
end

event.onframestart(handleText, "Handles Text");