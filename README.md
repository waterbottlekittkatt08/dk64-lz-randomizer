<p align="center">
  <img src ="https://raw.githubusercontent.com/theballaam96/dk64-lz-randomizer/master/image/readme%20-%20logo%20(450%2Cus).png" />
</p>

<p align="center">
A randomizer lua script for Donkey Kong 64. Intended for BizHawk.
<br>
<a href="https://discordapp.com/invite/6GCuY7B">Discord Invite</a>
</p>

<br>

![Installation and Usage](https://github.com/theballaam96/dk64-lz-randomizer/blob/master/image/readme%20-%20install.png)

- Step 1: Open the [BizHawk emulator](https://github.com/TASVideos/BizHawk/releases/)
- Step 2: Open any valid DK64 US ROM
- Step 3: Open the Lua Console (Tools > Lua Console)
- Step 4: Open the Loading Zone Randomizer (Script > Open Script > lzr.lua)
- Step 5: Select the settings you want to use and determine your seed
- Step 6: Click confirm and enjoy the oncoming madness!

![Features](https://github.com/theballaam96/dk64-lz-randomizer/blob/master/image/readme%20-%20features.png)
- Randomization of regular loading zones
	-For example: Trying to enter the loading zone to DK Isles from Aztec Lobby could take you to the Winch Room in Fungi Forest. Exiting the Winch Room however could take you to the Library in Creepy Castle.
	- Some maps are excluded from this randomization (Snide's, Cranky's, Candy's, Funky's, Troff 'n' Scoff, Helm Lobby and Helm Entrance)
- Randomization of Bonus Barrels
	- For Example: Trying to enter the bonus barrel near Arcade in Frantic Factory (Which would take you to Stash Snatch) might take you to Mad Maze Maul
	- This also includes the unused bonus barrels not accessible via normal gameplay!
	- Beaver Bother, the two harder Minecart Mayhems, and a couple unused minigames cannot appear in Hideout Helm (We are nice sometimes)
- Randomized Kasplats
	- Over 100 locations which the 40 kasplats in the game can be
	- All are collectable glitchless as every kong
	- Some are just shifted to [new locations](https://twitter.com/2dosSRL/status/1087442940094500865) and some are [in completely new maps!](https://twitter.com/2dosSRL/status/1087800177765818368)
	- Blueprints stay in the levels you find them in (no blueprint-sanity)
		- One exception, the Kasplat in Kut Out will belong to Castle regardless of what level Kut Out appears in
- Randomized bosses
	- The boss you fight in each level is random (the spawned keys are not)
	- The kong used to fight each boss is random
	- The coloured bananas required to open a boss is randomised
		- The counts cannot go above a certain cap that's determined on a level-by-level basis
	- Exceptions: Chunky must fight Dogadon 2, Lanky cannot fight Mad Jack, Tiny can't fight Army Dillo II, DK can't fight pufftoss
- Access to K Rool has been modified
	- Depends on Game Length selected
- Game Length Modifiers
	- Either Short, Standard or Long
	- Modifies the following:
		- Total amount of Coloured Bananas required to open all 7 T&S Doors
			- Short: 250 - 750
			- Standard: 750 - 1250
			- Long: 1250 - 1750
		- B-Locker Requirements
			- Short: 25 for Helm, others are less (but random)
			- Standard: 50 for Helm, others are less (but random)
			- Long: 100 for Helm, others are less (but random)
		- Doors open at the end of Helm
			- Short: Both Coin & Crown Doors are open, and the Blast-o-matic is off
			- Standard: Coin Door open
			- Long: Neither Coin or Crown Door are open
		- Requirements to unlock K Rool
			- Short: Keys 3 & 8
			- Standard: Keys 3, 6, 7 & 8
			- Long: All 8 Keys
		- K Rool Phases if phases are randomised
			- Short: 2 Phases
			- Standard: 3 Phases
			- Long: 5 Phases
- Cutscenes are reduced/excessive text removed
	- You will be taken to the main menu right after the Nintendo Logo, skipping the DK Rap, Rareware & N64 Logo and DK TV
	- Training barrels are completed and Simian Slam is already learned
	- Start in DK Isles instead of DK’s house
	- Snide's contraption cutscenes are reduced to just the initial pulley cutscene
	- Snide's GB drops are just limited to one "Oh Banana", even if you are turning in 2+ BPs for a kong
	- K Rool phases immediately start at the "In the red corner" cutscene
	- First time text descriptions when you use a move are removed
	- Story skip is permanently on
	- Level Open Cutscenes are completely removed
	- K-Lumsy turns all keys in your inventory at once
	- Other excessive cutscenes are removed
- Option to start with all moves
	- Cuts out some coin collection
- Option to start with all kongs unlocked
	- Cuts out having to hunt for King Kutout/searching for kongs
	- Make loading zone randomization possible glitchless
- Certain Enemies are randomised
	- Klaptraps can either be green, purple or the unused red klaptrap!
	- Beavers can either be blue or gold.
- Spoiler log
	
![Future Features](https://github.com/theballaam96/dk64-lz-randomizer/blob/master/image/readme%20-%20future%20features.png)
- ROM generation instead of running a Lua script
- Logic to improve the gameplay experience for all skill levels
- Upgrade/Gun/Instrument randomization
- Randomization of Kongs
- Randomization of what keys open what levels
- [Randomization of coloured bananas](https://cdn.discordapp.com/attachments/460646910919966732/461750596152590356/unknown.png)
- [Randomization of Battle Crowns](https://twitter.com/2dosSRL/status/1087804011418390528)
	- Random enemies
	- Random timers
	- Random crown names
- Music Randomization
- Tag anywhere!
- Hard Mode for those wanting a further challenge
	- Crazy Kasplat locations!
	- Harder and **revamped** boss fights
	- Certain accessibility decisions (eg. Llama Temple entrance not randomized) removed
- Wrinkly gives randomizer hints
- Various Quality of life changes
	- Shortening timers on some minigames (Eg. Teetering Turtle Trouble)
	- Altered requirements for some minigames (Eg. Beaver Bother)
	
![BizHawk Setup Guide](https://github.com/theballaam96/dk64-lz-randomizer/blob/master/image/readme%20-%20setup.png)
- Click the following link to go to the guide: [Click Here](https://docs.google.com/document/d/1FmMYjsgSc7EspCEIBDOuLAvUCc6UXTlZQdBPeQowwCc/edit?usp=sharing)

![devs](https://github.com/theballaam96/dk64-lz-randomizer/blob/master/image/readme%20-%20devs.png)
- Developers
	- [theballaam96](https://www.youtube.com/c/theballaam96srl)
	- [Bismuth](https://www.youtube.com/c/Bismuth9)
	- [Znernicus](https://www.twitch.tv/znernicus)
	- [Mittenz](http://twitch.tv/mittenzsrl)
	- [2dos](http://www.twitch.tv/2dos)
- Additional Code
	- [Isotarge](http://twitter.com/isotarge) & [ScriptHawk](https://github.com/Isotarge/ScriptHawk)
- Playtesters
	- [EmoArbiter](http://twitch.tv/emoarbiter)
	- [Obiyo](https://www.twitch.tv/obiyosrl)
	- [KaptainKohl](https://www.twitch.tv/kaptainkohl)
	- [Connor75](https://www.twitch.tv/connor75)
	- [GloriousLiar](https://www.twitch.tv/gloriousliar)
	- [Ciyon](https://www.twitch.tv/ciyon)
	- [Cfox](https://www.twitch.tv/cfox)
	- [Jag](https://www.twitch.tv/jaguar_002/)
	- [Mouse](https://www.twitch.tv/mouse1093)
	- [NamajnaG](https://www.twitch.tv/naramgamjan)
	- [Youngster_Joey](https://www.twitch.tv/yungster_joey)
	- [KiwiKiller67](https://www.twitch.tv/kiwikiller67)
	- [Iateyourpie](https://www.twitch.tv/iateyourpie)
