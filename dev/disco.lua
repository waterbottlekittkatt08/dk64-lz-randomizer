model_base = 0x75C41B;

models = {
	4, -- DK
	1, -- Diddy
	6, -- Lanky
	9, -- Tiny
	14, -- Chunky
};

for i = 1, 5 do
	mainmemory.writebyte(model_base + ((i - 1) * 0x10),models[i]);
end