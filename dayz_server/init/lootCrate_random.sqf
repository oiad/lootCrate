/*
	Loot crate at random positions by salival (https://github.com/oiad)

	Arrays are set up to be in this format:
	[["Weapon",5],"Weapon1"], // "Weapon" will be added to the crate 5 times since it's in its own array, "Weapon1" will be only added once.
	[["Weapon",[3,5]],"Weapon1"], // "Weapon" will be added to the crate between 3-5 (min-max) times since it's in its own array, "Weapon1" will be only added once.
	[["Magazine",5"],"Magazine1"] // "Magazine" will be added to the crate 5 times since it's in its own array, "Magazine1" will be only added once.

	Sample array:

	[
		[["SCAR_L_STD_EGLM_TWS",5],["RH_hk417",[2,5]],"RH_hk417"],
		[["6Rnd_HE_M203",5],"CinderBlocks"]
	]
	
	This would potentially spawn 5x SCAR_L_STD_EGLM_TWS, between 2-5x RH_hk417, 1x RH_hk417, 5x 6Rnd_HE_M203 and 1x CinderBlocks
*/

private ["_crate","_crateLoot","_crateType","_loot","_lootWeapons","_lootMagazines","_magazineCount","_position","_positionArray","_weaponCount"];

_crateType = "USSpecialWeaponsBox"; // Classname of crate to spawn, i.e: "VaultStorage" "USSpecialWeaponsBox", these containers should be able to support your MAXIMUM amount of weapons/ammo or they will drop on the floor!
_weaponCount = 10; // Maximum amount of weapons that can possibly be spawned
_magazineCount = 15; // Maximum amount of magazines that can possibly be spawned

_positionArray = [ // Arrays of positions the script will choose at random
	[1151.812, 10009.139, 0],
	[1223.2665, 10009.921, 0],
	[1219.7129, 10105.23, 0],
	[1147.6968, 10103.761, 0]
];

_position = _positionArray call BIS_fnc_selectRandom;

_crate = createVehicle [_crateType,_position,[],0,"CAN_COLLIDE"];
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;

_crateLoot = [
    [
        [["RH_hk417",[2,5]],["RH_hk417sdaim",3],["RH_hk417sdeotech",3],["vil_SR25SD",3],["vil_M110sd",3],["RH_sc2eot",3],["RH_Deagleg",2],["RH_uspsd",2],"vil_VAL"], // First weapon array
        [["RH_20Rnd_762x51_hk417",10],["RH_20Rnd_762x51_SD_hk417",10],["20Rnd_762x51_DMR",10],["RH_7Rnd_50_AE",6],["RH_15Rnd_9x19_uspsd",5],["CinderBlocks",[5,20]],["MortarBucket",[5,20]],["ItemBriefcase100oz",2],["ItemSapphire",1]] // First magazine array
	], // End of first array, make sure the last array doesn't have a ,
	[
        [["RH_mas",5],["RH_masbsdaim",5],["RH_masbsdeotech",5],["Mk48_DZ",2],["M60A4_EP1_DZE",2],["vil_MG4",2],["RH_m93r",2],"vil_Groza_GL"],
        [["30Rnd_556x45_Stanag",10],["30Rnd_556x45_StanagSD",10],["100Rnd_762x51_M240",5],["200Rnd_556x45_M249",3],["RH_20Rnd_9x19_M93",5],["CinderBlocks",20],["MortarBucket",6],["ItemBriefcase100oz",2]]
    ]
];

_lootWeapons = [];
_lootMagazines = [];
_loot = _crateLoot call BIS_fnc_selectRandom;

for "_i" from 1 to (ceil random _weaponCount) do {
	_lootWeapons set [count _lootWeapons,(_loot select 0) select (floor (random (count (_loot select 0))))];
};

for "_i" from 1 to (ceil random _magazineCount) do {
	_lootMagazines set [count _lootMagazines,(_loot select 1) select (floor (random (count (_loot select 1))))];
};

{
	if (typeName (_x) == "ARRAY") then {
		_crate addWeaponCargoGlobal [_x select 0,if (typeName (_x select 1) == "ARRAY") then {floor random ((_x select 1) select 1) max ((_x select 1) select 0)} else {_x select 1}];
	} else {
		_crate addWeaponCargoGlobal [_x,1];
	};
} forEach _lootWeapons;

{
	if (typeName (_x) == "ARRAY") then {
		_crate addMagazineCargoGlobal [_x select 0,if (typeName (_x select 1) == "ARRAY") then {floor random ((_x select 1) select 1) max ((_x select 1) select 0)} else {_x select 1}];
	} else {
		_crate addMagazineCargoGlobal [_x,1];
	};
} forEach _lootMagazines;

diag_log format ["Spawning %1 loot crate @%2 %3",_crateType,mapGridPosition _position,_position];