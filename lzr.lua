rng = {0x746A40, 0x7411A0, 0x746300};
dmap = {0x7444E4, 0x73EC34, 0x743DA4};
mode = {0x755318, 0x74FB98, 0x7553D8};
transition_speed = {0x7FD88C, 0x7FD7CC, 0x7FDD1C};
cmap = {0x76A0A8, 0x764BC8, 0x76A298};
dexit = {0x7444E8, 0x73EC38, 0x743DA8};
cs = {0x7476F4, 0x741E54, 0x746FB4};
cs_active = {0x7444EC, 0x73EC3C, 0x743DAC};
zipper_progress = {0x7ECC60, nil, nil};
frame_lag = {0x76AF10, nil, nil};
frame_real = {0x7F0560, nil, nil};

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

version = getVersion();

client.pause();

lzrForm = {
	warnings = false, -- Useful for debugging but annoying for end users, so default to false
	smooth_moving_angle = true,
	UI = {
		form_controls = {},
		form_padding = 8,
		form_width = 15,
		form_height = 15,
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

function DefaultSettings()
	inputdisplay_x = 70;
	inputdisplay_y = 10;
	inputdisplay_scale = 4;
end

DefaultSettings();

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
end

function increase1000()
	seedValue[2] = seedValue[2] + 1;
	realTime();
end

function increase100()
	seedValue[3] = seedValue[3] + 1;
	realTime();
end

function increase10()
	seedValue[4] = seedValue[4] + 1;
	realTime();
end

function increase1()
	seedValue[5] = seedValue[5] + 1;
	realTime();
end

function decrease10000()
	seedValue[1] = seedValue[1] - 1;
	realTime();
end

function decrease1000()
	seedValue[2] = seedValue[2] - 1;
	realTime();
end

function decrease100()
	seedValue[3] = seedValue[3] - 1;
	realTime();
end

function decrease10()
	seedValue[4] = seedValue[4] - 1;
	realTime();
end

function decrease1()
	seedValue[5] = seedValue[5] - 1;
	realTime();
end

function confirmSettings()
	print("Settings Confirmed");
	print("Seed: "..seedAsNumber);
	if forms.ischecked(lzrForm.UI.form_controls["Randomiser Checkbox"]) then
		require "modules.randomiser"
		print("Randomiser On");
	end
	if forms.ischecked(lzrForm.UI.form_controls["All Moves Checkbox"]) then
		require "modules.allMoves"
		print("All Moves On");
	end
	if forms.ischecked(lzrForm.UI.form_controls["No Cutscenes Checkbox"]) then
		require "modules.reducedCutscenes"
		print("No Cutscenes On");
	end
	client.unpause();
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

-- Display Modifier
lzrForm.UI.form_controls["Title Label"] = forms.label(lzrForm.UI.options_form, "DK64 LOADING ZONE RANDOMISER SETTINGS", lzrForm.UI.col(0), lzrForm.UI.row(0) + lzrForm.UI.label_offset, 410, 24);

lzrForm.UI.form_controls["Randomiser Label"] = forms.label(lzrForm.UI.options_form, "Loading Zone Randomiser:", lzrForm.UI.col(0), lzrForm.UI.row(2) - 5 + lzrForm.UI.label_offset, 180, 24);
lzrForm.UI.form_controls["Randomiser Checkbox"] = forms.checkbox(lzrForm.UI.options_form, "", lzrForm.UI.col(8) + lzrForm.UI.dropdown_offset, lzrForm.UI.row(2) + lzrForm.UI.dropdown_offset);
forms.setproperty(lzrForm.UI.form_controls["Randomiser Checkbox"], "Checked", true);

lzrForm.UI.form_controls["All Moves Label"] = forms.label(lzrForm.UI.options_form, "Give All Moves:", lzrForm.UI.col(0), lzrForm.UI.row(3) - 5 + lzrForm.UI.label_offset, 180, 24);
lzrForm.UI.form_controls["All Moves Checkbox"] = forms.checkbox(lzrForm.UI.options_form, "", lzrForm.UI.col(8) + lzrForm.UI.dropdown_offset, lzrForm.UI.row(3) + lzrForm.UI.dropdown_offset);

lzrForm.UI.form_controls["No Cutscenes Label"] = forms.label(lzrForm.UI.options_form, "Reduced Cutscenes:", lzrForm.UI.col(0), lzrForm.UI.row(4) - 5 + lzrForm.UI.label_offset, 180, 24);
lzrForm.UI.form_controls["No Cutscenes Checkbox"] = forms.checkbox(lzrForm.UI.options_form, "", lzrForm.UI.col(8) + lzrForm.UI.dropdown_offset, lzrForm.UI.row(4) + lzrForm.UI.dropdown_offset);

seed_form_height = 6;

lzrForm.UI.form_controls["Increase 10000"] = forms.button(lzrForm.UI.options_form, "+", increase10000, lzrForm.UI.col(2), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Increase 1000"] = forms.button(lzrForm.UI.options_form, "+", increase1000, lzrForm.UI.col(3), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Increase 100"] = forms.button(lzrForm.UI.options_form, "+", increase100, lzrForm.UI.col(4), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Increase 10"] = forms.button(lzrForm.UI.options_form, "+", increase10, lzrForm.UI.col(5), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Increase 1"] = forms.button(lzrForm.UI.options_form, "+", increase1, lzrForm.UI.col(6), lzrForm.UI.row(seed_form_height), lzrForm.UI.button_height, lzrForm.UI.button_height);

lzrForm.UI.form_controls["Seed Label"] = forms.label(lzrForm.UI.options_form, seedString, lzrForm.UI.col(0), lzrForm.UI.row(seed_form_height + 1) + lzrForm.UI.label_offset, 180, 24);

lzrForm.UI.form_controls["Decrease 10000"] = forms.button(lzrForm.UI.options_form, "-", decrease10000, lzrForm.UI.col(2), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Decrease 1000"] = forms.button(lzrForm.UI.options_form, "-", decrease1000, lzrForm.UI.col(3), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Decrease 100"] = forms.button(lzrForm.UI.options_form, "-", decrease100, lzrForm.UI.col(4), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Decrease 10"] = forms.button(lzrForm.UI.options_form, "-", decrease10, lzrForm.UI.col(5), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);
lzrForm.UI.form_controls["Decrease 1"] = forms.button(lzrForm.UI.options_form, "-", decrease1, lzrForm.UI.col(6), lzrForm.UI.row(seed_form_height + 2) + 5, lzrForm.UI.button_height, lzrForm.UI.button_height);

lzrForm.UI.form_controls["Settings Check Label"] = forms.label(lzrForm.UI.options_form, "SETTINGS NOT SET YET", lzrForm.UI.col(0), lzrForm.UI.row(seed_form_height + 4) + lzrForm.UI.label_offset, 180, 24);

lzrForm.UI.form_controls["Confirm Settings Button"] = forms.button(lzrForm.UI.options_form, "Confirm Settings", confirmSettings, lzrForm.UI.col(6), lzrForm.UI.row(seed_form_height + 5), lzrForm.UI.button_height, lzrForm.UI.button_height);

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