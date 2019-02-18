if settings.gameLengths < 3 then	
	fileFlagsCount = #newFileFlags;
	newFileFlags[fileFlagsCount + 1] = {0x60,3}; -- Coin Door
end

if settings.gameLengths < 2 then
	fileFlagsCount = #newFileFlags;
	newFileFlags[fileFlagsCount + 1] = {0x60,4}; -- Crown Door
end