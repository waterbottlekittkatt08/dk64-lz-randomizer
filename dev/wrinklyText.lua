
-- insertText(0x4A42A0,copypasta_text)

copypasta_text = "HEY 2DOS WHY DON'T YOU PLAY DK64 ANYMORE? I THINK IT'S PRETTY FKIN RUDE HOW YOU'RE ACTING RIGHT NOW. MOST PEOPLE ONLY FOLLOW FOR YOUR DK64 AND YOU'RE LOSING FOLLOWERS TONIGHT ACTING LIKE A CHILD.";
copypasta_text_2 = "is there a vid I can use for beetle race skip. Two amazing friends selflessly find a video for your lazy ass, you call them slow because you had it before them. Why the fuck did you ask you ungrateful little shit?"

wrinklyText = {
	"Slamming the Big X in DK Isles reveals more than it might seem",
};

textChars = {
	[0x20] = {" ",9},
	[0x21] = {"!",2},
	[0x25] = {"%",9},
	[0x27] = {"'",2},
	[0x28] = {"(",2},
	[0x29] = {")",2},
	[0x2C] = {",",9},
	[0x2D] = {"-",9},
	[0x2E] = {".",9},
	[0x30] = {"0",9},
	[0x31] = {"1",9},
	[0x32] = {"2",9},
	[0x33] = {"3",9},
	[0x34] = {"4",9},
	[0x35] = {"5",9},
	[0x36] = {"6",9},
	[0x37] = {"7",9},
	[0x38] = {"8",9},
	[0x39] = {"9",9},
	[0x3A] = {":",2},
	[0x3B] = {";",2},
	[0x3F] = {"?",9},
	[0x41] = {"A",9},
	[0x42] = {"B",9},
	[0x43] = {"C",9},
	[0x44] = {"D",9},
	[0x45] = {"E",9},
	[0x46] = {"F",9},
	[0x47] = {"G",9},
	[0x48] = {"H",9},
	[0x49] = {"I",9},
	[0x4A] = {"J",9},
	[0x4B] = {"K",9},
	[0x4C] = {"L",9},
	[0x4D] = {"M",9},
	[0x4E] = {"N",9},
	[0x4F] = {"O",9},
	[0x50] = {"P",9},
	[0x51] = {"Q",9},
	[0x52] = {"R",9},
	[0x53] = {"S",9},
	[0x54] = {"T",9},
	[0x55] = {"U",9},
	[0x56] = {"V",9},
	[0x57] = {"W",9},
	[0x58] = {"X",9},
	[0x59] = {"Y",9},
	[0x5A] = {"Z",9},
	[0xEF] = {"?",9},
};

function textToHex(character)
	for i = 1, 0xEF do
		if textChars[i] ~= nil then
			if textChars[i][1] == character then
				return i;
			end
		end
	end
	return 0x20;
end

textboxSet = 0;

function getTextboxPointer()
	current_cmap = mainmemory.read_u32_be(Mem.cmap[version]);
	inLobby = 0;
	for i = 0, 8 do
		if lobbies[i] == current_cmap then
			inLobby = 1;
		end
	end
	local cutsceneType = dereferencePointer(Mem.cutscene_type[version]);
	cutscene = mainmemory.read_u16_be(Mem.cs[version]);
	if inLobby == 1 then
		if cutsceneType == Mem.cutscene_type_kong[version] and cutscene == 34 then -- Wrinkly Cutscene
			if textboxSet == 0 then
				textbox_pointers = getActorPointers(299);
				if #textbox_pointers > 0 then
					textToRecall = randomBetween(1,#wrinklyText);
					insertText(textbox_pointers[1], wrinklyText[textToRecall]);
					textboxSet = 1;
				end
			end
		else
			textboxSet = 0;
		end
	end
end

function insertText(TextboxPointer,textString)
	TextPointer = dereferencePointer(TextboxPointer +  0x17C);
	CharPointer = {};
	CharValueAddress = {};
	textStringLength = string.len(textString);
	textString = string.upper(textString);
	lineCount = 0;
	lineLengths = {};
	lineLengthArray = {};
	lineStrings = {};
	prevLinesTotalChars = 0;
	charRemaining = textStringLength;
	for j = 1, 10 do -- 10 lines
		if charRemaining > 0 then
			if #lineLengths > 0 then
				prevLinesTotalChars = 0;
				for k = 1, #lineLengths do
					prevLinesTotalChars = prevLinesTotalChars + lineLengths[k];
				end
			end
			if lineCount < 2 then
				CharPointer[1] = dereferencePointer(TextPointer + 0xC + ((lineCount) * 0x90));
				linePixLength = mainmemory.readfloat(TextPointer + 0x14 + ((lineCount) * 0x90),true);
				char_lengths = 0;
				current_line_length = 1;
				for i = 1, 20 do
					if char_lengths < linePixLength then
						nextChar = textToHex(string.sub(textString, prevLinesTotalChars + i,prevLinesTotalChars + i));
						nextCharLength = textChars[nextChar][2]; -- Intercharacter distance
						char_lengths = char_lengths + nextCharLength;
						if char_lengths < linePixLength + 1 then
							current_line_length = current_line_length + 1;
						end
					end
				end
				lineLengthArray[lineCount + 1] = current_line_length;
			else
				CharPointer[1] = dereferencePointer(TextPointer + 0x9C + ((lineCount - 1) * 0x30));
				linePixLength = mainmemory.readfloat(TextPointer + 0xA4 + ((lineCount - 1) * 0x30),true);
				char_lengths = 0;
				current_line_length = 1;
				for i = 1, 20 do
					if char_lengths < linePixLength then
						nextChar = textToHex(string.sub(textString, prevLinesTotalChars + i,prevLinesTotalChars + i));
						nextCharLength = textChars[nextChar][2]; -- Intercharacter distance
						char_lengths = char_lengths + nextCharLength;
						if char_lengths < linePixLength + 1 then
							current_line_length = current_line_length + 1;
						end
					end
				end
				lineLengthArray[lineCount + 1] = current_line_length;
			end
			
			lineStrings[j] = string.sub(textString, prevLinesTotalChars + 1,prevLinesTotalChars + lineLengthArray[j]);
			for i = 1, lineLengthArray[j] do
				if CharPointer[i] ~= nil then
					CharValueAddress[i] = CharPointer[i] + 0x12;
					nextChar = textToHex(string.sub(textString, prevLinesTotalChars + i,prevLinesTotalChars + i));
					mainmemory.writebyte(CharPointer[i] + 1, textChars[nextChar][2]); -- Intercharacter distance
					mainmemory.writebyte(CharValueAddress[i],nextChar);
					CharPointer[i + 1] = dereferencePointer(CharPointer[i] + 0xA0);
				end
			end
			charRemaining = charRemaining - lineLengthArray[j];
			lineLengths[j] = lineLengthArray[j];
			lineCount = lineCount + 1;
		end
	end
end

event.onframestart(getTextboxPointer, "Get Textbox");