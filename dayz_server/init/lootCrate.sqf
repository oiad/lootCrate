/*
	Loot crate at random positions by salival (https://github.com/oiad)
	
	Arrays are set up to be in this format:
	[["Weapon",5],"Weapon1"], // "Weapon" will be added to the crate 5 times since it's in its own array, "Weapon1" will be only added once.
	[["Magazine",5"],"Magazine1"] // "Magazine" will be added to the crate 5 times since it's in its own array, "Magazine1" will be only added once.
	
	Sample array:
	
	[
		[["SCAR_L_STD_EGLM_TWS",5],"RH_hk417"],
		[["6Rnd_HE_M203",5],"CinderBlocks"]
	]
	
	This would spawn 5 SCAR_L_STD_EGLM_TWS and 1 RH_hk417, 5 6Rnd_HE_M203 and 1 CinderBlocks
*/

private ["_crate","_crateType","_loot","_crateLoot","_position","_positionArray"];

_crateType = "VaultStorage"; // Classname of crate to spawn
_positionArray = [ // Arrays of positions the script will choose at random
	[1151.812, 10009.139, 24.162956],
	[1223.2665, 10009.921, 24.056753],
	[1219.7129, 10105.23, 24.075146],
	[1147.6968, 10103.761, 24.143848]
];

_position = _positionArray call BIS_fnc_selectRandom;

_crate = createVehicle [_crateType,_position,[],0,"CAN_COLLIDE"];
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;

_crateLoot = [
    [
        [["RH_hk417",5],["RH_hk417sdaim",5],["RH_hk417sdeotech",5],["vil_SR25SD",3],["vil_M110sd",3],["RH_sc2eot",3],["RH_Deagleg",2],["RH_uspsd",2]], // First weapon array
        [["RH_20Rnd_762x51_hk417",10],["RH_20Rnd_762x51_SD_hk417",10],["20Rnd_762x51_DMR",20],["RH_7Rnd_50_AE",6],["RH_15Rnd_9x19_uspsd",5],["CinderBlocks",20],["MortarBucket",6],["ItemBriefcase100oz",2],["ItemSapphire",1]] // First magazine array
	], // End of first array, make sure the last array doesn't have a ,
	[
        [["RH_mas",5],["RH_masbsdaim",5],["RH_masbsdeotech",5],["Mk48_DZ",2],["M60A4_EP1_DZE",2],["vil_MG4",2],["RH_m93r",2]],
        [["30Rnd_556x45_Stanag",10],["30Rnd_556x45_StanagSD",10],["100Rnd_762x51_M240",5],["200Rnd_556x45_M249",3],["RH_20Rnd_9x19_M93",5],["CinderBlocks",20],["MortarBucket",6],["ItemBriefcase100oz",2]]
    ]
];

_loot = _crateLoot call BIS_fnc_selectRandom;

{
	if (typeName (_x) == "ARRAY") then {
		_crate addWeaponCargoGlobal [_x select 0,_x select 1];
	} else {
		_crate addWeaponCargoGlobal [_x,1];
	};
} forEach (_loot select 0);
{
	if (typeName (_x) == "ARRAY") then {
		_crate addMagazineCargoGlobal [_x select 0,_x select 1];
	} else {
		_crate addMagazineCargoGlobal [_x,1];
	};
} forEach (_loot select 1);

diag_log format ["Spawning %1 loot crate @%2 %3",_crateType,mapGridPosition _position,_position];