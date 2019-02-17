fileFlagsCount = #newFileFlags;
if settings.gameLengths < 3 then	
	newFileFlags[fileFlagsCount + 2] = {0x60,3};
	newFileFlags[fileFlagsCount + 2] = {0x60,4};
end