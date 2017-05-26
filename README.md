# [EPOCH 1.0.6.1] Random position Loot Crate

* Discussion URL: https://epochmod.com/forum/topic/43992-release-random-position-loot-crate/
	
* Tested as working on a blank Epoch 1.0.6.1
* Uses nested arrays to make loot lists easier to manage

# REPORTING ERRORS/PROBLEMS

1. Please, if you report issues can you please attach (on pastebin or similar) your SERVER rpt log file as this helps find out the errors very quickly.

# Install:

**[>> Download <<](https://github.com/oiad/lootCrate/archive/master.zip)**

# dayz_server folder install:

1. In dayz_server\system\server_monitor.sqf find: <code>[] spawn server_spawnEvents;</code> and add directly below:

	```sqf
	[] execVM "\z\addons\dayz_server\init\lootCrate.sqf";
	```
	
2. Move the supplied file <code>lootCrate.sqf</code> to the <code>dayz_server\init</code> folder.