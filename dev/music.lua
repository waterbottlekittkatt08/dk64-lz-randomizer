valid_songs = {
	1, 2, 3, 4, 5, 6, 8, 14, 16, 17, 19, 21, 25, 26, 27, 28, 29, 30, 31,
	36, 37, 39, 48, 49, 50, 51, 52, 53, 55, 56, 58, 60, 61, 62, 63, 64, 68, 70,
	71, 72, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 84, 85, 88, 89, 90, 91, 92,
	93, 94, 95, 97, 98, 99, 100, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
	112, 113, 116, 117, 118, 119, 120, 121, 122, 123, 124, 126, 129, 130, 131, 132,
	133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 148, 149, 150, 152, 153, 154,
	155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169,
};

randomise_song_happened = 0;

function randomiseSong()
	transition_speed_value = mainmemory.readfloat(Mem.transition_speed[version], true);
	song = mainmemory.readbyte(Mem.music[version]);
	if transition_speed_value < 0 and randomise_song_happened == 0 then
		song_value = valid_songs[(emu.framecount() % #valid_songs) + 1];
		mainmemory.writebyte(Mem.music[version], song_value);
		randomise_song_happened = 1;
	elseif transition_speed_value > 0 then
		randomise_song_happened = 0;
	end
end

event.onframeend(randomiseSong, "Randomises Song");