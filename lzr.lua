Mem = {
	kong_base = {0x7FC950, 0x7FC890, 0x7FCDE0},
	rng = {0x746A40, 0x7411A0, 0x746300},
	dmap = {0x7444E4, 0x73EC34, 0x743DA4},
	mode = {0x755318, 0x74FB98, 0x7553D8},
	transition_speed = {0x7FD88C, 0x7FD7CC, 0x7FDD1C},
	cmap = {0x76A0A8, 0x764BC8, 0x76A298},
	dexit = {0x7444E8, 0x73EC38, 0x743DA8},
	cs = {0x7476F4, 0x741E54, 0x746FB4},
	cs_active = {0x7444EC, 0x73EC3C, 0x743DAC},
	zipper_progress = {0x7ECC60, 0x7ECBA0, 0x7ECE50},
	frame_lag = {0x76AF10, 0x765A30, 0x76B100},
	frame_real = {0x7F0560, 0x7F0480, 0x7F09D0},
	cutscene_value = {0x7476F4, 0x741E54, 0x746FB4},
	cutscene_timer = {0x7476F0, 0x741E50, 0x746FB0},
	pmap = {0x76A172, 0x764C92, 0x76A362},
	actor_count = {0x7FC3F0, 0x7FC310, 0x7FC860},
	pointer_list = {0x7FBFF0, 0x7FBF10, 0x7FC460},
	map_state = {0x76A0B1, 0x764BD1, 0x76A2A1},
	krool_round = {0x750AD4, 0x74B224, 0x7503B4},
	level_index_mapping = {0x7445E0, 0x73ED30, 0x743EA0},
	eeprom_copy_base = {0x7ECEA8, 0x7ECDC8, 0x7ED318},
	eeprom_file_mapping = {0x7EDEA8, 0x7EDDC8, 0x7EE318},
	file = {0x7467C8, 0x740F18, 0x746088},
};

-------------------------------
-- SOME SCRIPTHAWK FUNCTIONS --
-------------------------------

function getVersion()
	romHash = gameinfo.getromhash();
	if romHash == "F96AF883845308106600D84E0618C1A066DC6676" then
		return 2;
	elseif romHash == "F0AD2B2BBF04D574ED7AFBB1BB6A4F0511DCD87D" then
		return 3;
	elseif romHash == "CF806FF2603640A748FCA5026DED28802F1F4A50" then
		return 1;
	else
		print("The ROM you are using does not work for this script");
		return 4;
	end
end

RDRAMBase = 0x80000000;
RDRAMSize = 0x800000; 
RAMBase = RDRAMBase;
RAMSize = RDRAMSize;

function isRDRAM(value)
	return type(value) == "number" and value >= 0 and value < RDRAMSize;
end

function isPointer(value)
		return type(value) == "number" and value >= RDRAMBase and value < RDRAMBase + RDRAMSize;
end

function dereferencePointer(address)
	if type(address) == "number" and address >= 0 and address < (RDRAMSize - 4) then
		address = mainmemory.read_u32_be(address);
		if isPointer(address) then
			return address - RDRAMBase;
		end
	end
end

version = getVersion();
check_bit = bit.check;
clear_bit = bit.clear;
set_bit = bit.set;

function getFileIndex()
	return mainmemory.readbyte(Mem.file[version]);
end

local eeprom_slot_size = 0x1AC;

function getCurrentEEPROMSlot()
	local fileIndex = getFileIndex();
	for i = 0, 3 do
		local EEPROMMap = mainmemory.readbyte(Mem.eeprom_file_mapping[version] + i);
		if EEPROMMap == fileIndex then
			return i;
		end
	end
	return 0; -- Default
end

function getFlagBlockAddress()
	return Mem.eeprom_copy_base[version] + getCurrentEEPROMSlot() * eeprom_slot_size;
end

function setFlag(byte, bit)
	local flags = getFlagBlockAddress();
	if type(byte) == "number" and type(bit) == "number" and bit >= 0 and bit < 8 then
		local currentValue = mainmemory.readbyte(flags + byte);
		mainmemory.writebyte(flags + byte, set_bit(currentValue, bit));
	end
end

function checkFlag(byte, bit)
	if type(byte) == "string" then
		local flag = getFlagByName(byte);
		if type(flag) == "table" then
			byte = flag.byte;
			bit = flag.bit;
		end
	end
	if type(byte) == "number" and type(bit) == "number" and bit >= 0 and bit < 8 then
		local flags = getFlagBlockAddress();
		local currentValue = mainmemory.readbyte(flags + byte);
		if check_bit(currentValue, bit) then
			return true;
		else
			return false;
		end
	else
	end
	return false;
end

client.pause();

function getActorPointers(actor_value)
	pointers = {};
	count = 0;
	object_m1_count = math.min(255, mainmemory.read_u16_be(Mem.actor_count[version])); -- Actor Count
	for object_no = 0, object_m1_count do
		local pointer = dereferencePointer(Mem.pointer_list[version] + (object_no * 4));
		if isRDRAM(pointer) then
			actor_type = mainmemory.read_u32_be(pointer + 0x58);
			if actor_type == actor_value then
				count = count + 1;
				pointers[count] = pointer;
			end
		end
	end
	return pointers
end

----------------
-- FORM STUFF --
----------------

lzrForm = {
	warnings = false, -- Useful for debugging but annoying for end users, so default to false
	smooth_moving_angle = true,
	UI = {
		form_controls = {},
		form_padding = 8,
		form_width = 10,
		form_height = 18,
		label_offset = 5,
		dropdown_offset = 1,
		long_label_width = 140,
		button_height = 23,
	},
	bufferWidth = client.bufferwidth(),
	bufferHeight = client.bufferheight(),
};

function round(num, idp)
	return tonumber(string.format("%." .. (idp or 0) .. "f", num));
end

seedValue = {};

for i = 1, 5 do
	seedValue[i] = 0;
end

function getSeedString()
	seedAsNumber = 0;
	for i = 1, 5 do
		if seedValue[i] < 0 then
			seedValue[i] = 9;
		elseif seedValue[i] > 9 then
			seedValue[i] = 0;
		end
		seedAsNumber = seedAsNumber + ((10 ^ (5 - i)) * seedValue[i]);
	end
	seedAsString = seedValue[1];
	for i = 2, 5 do
		seedAsString = seedAsString.."    "..seedValue[i];
	end
	seedString = "Seed:   "..seedAsString;
end

getSeedString();

function increase10000()
	seedValue[1] = seedValue[1] + 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

function increase1000()
	seedValue[2] = seedValue[2] + 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

function increase100()
	seedValue[3] = seedValue[3] + 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

function increase10()
	seedValue[4] = seedValue[4] + 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

function increase1()
	seedValue[5] = seedValue[5] + 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

function decrease10000()
	seedValue[1] = seedValue[1] - 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

function decrease1000()
	seedValue[2] = seedValue[2] - 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

function decrease100()
	seedValue[3] = seedValue[3] - 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

function decrease10()
	seedValue[4] = seedValue[4] - 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

function decrease1()
	seedValue[5] = seedValue[5] - 1;
	realTime();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "SETTINGS NOT SET YET");
end

settings = {
	randomiser = 0,
	all_moves = 0,
	no_cutscenes = 0,
	all_kongs = 0,
};

function confirmSettings()
	print("Settings Confirmed");
	print("Seed: "..seedAsNumber);
	if forms.ischecked(lzrForm.UI.form_controls["Randomiser Checkbox"]) then
		settings.randomiser = 1;
		require "modules.randomiser"
		print("Randomiser On");
	end
	if forms.ischecked(lzrForm.UI.form_controls["All Moves Checkbox"]) then
		settings.all_moves = 1;
		require "modules.allMoves"
		print("All Moves On");
	end
	if forms.ischecked(lzrForm.UI.form_controls["No Cutscenes Checkbox"]) then
		settings.no_cutscenes = 1;
		require "modules.reducedCutscenes"
		print("No Cutscenes On");
	end
	if forms.ischecked(lzrForm.UI.form_controls["All Kongs Checkbox"]) then
		settings.all_kongs = 1;
		require "modules.allKongs"
		print("All Kongs On");
	end
	client.reboot_core();
	client.unpause();
	forms.settext(lzrForm.UI.form_controls["Settings Check Label"], "");
end

function lzrForm.UI.row(row_num)
	return round(lzrForm.UI.form_padding + lzrForm.UI.button_height * row_num, 0);
end

function lzrForm.UI.col(col_num)
	return lzrForm.UI.row(col_num);
end

if type(form_width) == "number" then
	lzrForm.UI.form_height = form_width;
end
if type(form_height) == "number" then
	lzrForm.UI.form_height = form_height;
end	

lzrForm.UI.options_form = forms.newform(lzrForm.UI.col(lzrForm.UI.form_width), lzrForm.UI.row(lzrForm.UI.form_height), "Donkey Kong 64 Loading Zone Randomiser");

function lzrForm.UI.checkbox(col, row, tag, caption, default)
	lzrForm.UI.form_controls[tag] = forms.checkbox(lzrForm.UI.options_form, caption, lzrForm.UI.col(col) + lzrForm.UI.dropdown_offset, lzrForm.UI.row(row) + lzrForm.UI.dropdown_offset);
	forms.setproperty(lzrForm.UI.form_controls[tag], "Height", 22);
	if default then
		forms.setproperty(lzrForm.UI.form_controls[tag], "Checked", true);
	end
end

lzrForm.UI.form_controls["Title Label 1"] = forms.label(lzrForm.UI.options_form, "DONKEY KONG 64", lzrForm.UI.col(1) + 10, lzrForm.UI.row(0) + lzrForm.UI.label_offset, 410, 24);
lzrForm.UI.form_controls["Title Label 2"] = forms.label(lzrForm.UI.options_form, "LOADING ZONE RANDOMISER", lzrForm.UI.col(0), lzrForm.UI.row(1) + lzrForm.UI.label_offset, 410, 24);
lzrForm.UI.form_controls["Title Label 3"] = forms.label(lzrForm.UI.options_form, "SETTINGS", lzrForm.UI.col(2) + 10, lzrForm.UI.row(2) + lzrForm.UI.label_offset, 410, 24);

lzrForm.UI.form_controls["Randomiser Label"] = forms.label(lzrForm.UI.options_form, "Loading Zone Randomiser:", lzrForm.UI.col(0), lzrForm.UI.row(4) - 5 + lzrForm.UI.label_offset, 180, 24);
lzrForm.UI.form_controls["Randomiser Checkbox"] = forms.checkbox(lzrForm.UI.options_form, "", lzrForm.UI.col(8) + lzrForm.UI.dropdown_offset, lzrForm.UI.row(4) + lzrForm.UI.dropdown_offset);
forms.setproperty(lzrForm.UI.form_controls["Randomiser Checkbox"], "Checked", true);

lzrForm.UI.form_controls["All Moves Label"] = forms.label(lzrForm.UI.options_form, "Give All Moves:", lzrForm.UI.col(0), lzrForm.UI.row(5) - 5 + lzrForm.UI.label_offset, 180, 24);
lzrForm.UI.form_controls["All Moves Checkbox"] = forms.checkbox(lzrForm.UI.options_form, "", lzrForm.UI.col(8) + lzrForm.UI.dropdown_offset, lzrForm.UI.row(5) + lzrForm.UI.dropdown_offset);

lzrForm.UI.form_controls["No Cutscenes Label"] = forms.label(lzrForm.UI.options_form, "Reduced Cutscenes:", lzrForm.UI.col(0), lzrForm.UI.row(6) - 5 + lzrForm.UI.label_offset, 180, 24);
lzrForm.UI.form_controls["No Cutscenes Checkbox"] = forms.checkbox(lzrForm.UI.options_form, "", lzrForm.UI.col(8) + lzrForm.UI.dropdown_offset, lzrForm.UI.row(6) + lzrForm.UI.dropdown_offset);

lzrForm.UI.form_controls["All Kongs Label"] = forms.label(lzrForm.UI.options_form, "Unlock All Kongs:", lzrForm.UI.col(0), lzrForm.UI.row(7) - 5 + lzrForm.UI.label_offset, 180, 24);
lzrForm.UI.form_controls["All Kongs Checkbox"] = forms.checkbox(lzrForm.UI.options_form, "", lzrForm.UI.col(8) + lzrForm.UI.dropdown_offset, lzrForm.UI.row(7) + lzrForm.UI.dropdown_offset);


seed_form_height = 9;
seed_form_offset = 0.5;

lzrForm.UI.form_controls["Increase 10000"] = forms.button(lzrForm.UI.options_form, "+", increase10000, lzrForm.UI.col(seed_form_offset + 2), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Increase 1000"] = forms.button(lzrForm.UI.options_form, "+", increase1000, lzrForm.UI.col(seed_form_offset + 3), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Increase 100"] = forms.button(lzrForm.UI.options_form, "+", increase100, lzrForm.UI.col(seed_form_offset + 4), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Increase 10"] = forms.button(lzrForm.UI.options_form, "+", increase10, lzrForm.UI.col(seed_form_offset + 5), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Increase 1"] = forms.button(lzrForm.UI.options_form, "+", increase1, lzrForm.UI.col(seed_form_offset + 6), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);

lzrForm.UI.form_controls["Seed Label"] = forms.label(lzrForm.UI.options_form, seedString, lzrForm.UI.col(seed_form_offset), lzrForm.UI.row(seed_form_height + 1) + lzrForm.UI.label_offset, 180, 24);

lzrForm.UI.form_controls["Decrease 10000"] = forms.button(lzrForm.UI.options_form, "-", decrease10000, lzrForm.UI.col(seed_form_offset + 2), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Decrease 1000"] = forms.button(lzrForm.UI.options_form, "-", decrease1000, lzrForm.UI.col(seed_form_offset + 3), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Decrease 100"] = forms.button(lzrForm.UI.options_form, "-", decrease100, lzrForm.UI.col(seed_form_offset + 4), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Decrease 10"] = forms.button(lzrForm.UI.options_form, "-", decrease10, lzrForm.UI.col(seed_form_offset + 5), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Decrease 1"] = forms.button(lzrForm.UI.options_form, "-", decrease1, lzrForm.UI.col(seed_form_offset + 6), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);

lzrForm.UI.form_controls["Settings Check Label"] = forms.label(lzrForm.UI.options_form, "SETTINGS NOT SET YET", lzrForm.UI.col(0.5), lzrForm.UI.row(seed_form_height + 4) + lzrForm.UI.label_offset, 180, 24);

lzrForm.UI.form_controls["Confirm Settings Button"] = forms.button(lzrForm.UI.options_form, "Confirm Settings", confirmSettings, lzrForm.UI.col(0.6), lzrForm.UI.row(seed_form_height + 5) + 5, 7 * lzrForm.UI.button_height, lzrForm.UI.button_height);

function lzrForm.UI.updateReadouts()
	getSeedString();
	forms.settext(lzrForm.UI.form_controls["Seed Label"], seedString);
end

function realTime()
	lzrForm.UI.updateReadouts();
end

while true do
	if client.ispaused() then
		lzrForm.UI.updateReadouts();
	end
	if not client.ispaused() then
		lzrForm.UI.updateReadouts();
	end
	emu.yield();
	emu.frameadvance();
end