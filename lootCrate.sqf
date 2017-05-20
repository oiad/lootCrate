/*
	Loot crate at random positions by salival (https://github.com/oiad)
	
	Arrays are set up to be in this format:
	[["Weapon",5],"Weapon1"], // "Weapon" will be added to the crate 5 times since it's in its own array, "Weapon1" will be only added once.
	[["Magazine,5"],"Magazine1"] // "Magazine" will be added to the crate 5 times since it's in its own array, "Magazine1" will be only added once.
*/

private ["_crate","_crateType","_loot","_crateLoot","_position","_positionArray"];

_crateType = "VaultStorage"; // Classname of crate to spawn
_positionArray = [ // Arrays of positions the script will choose at random
	[1042.0227, 2465.2156],
	[989.57031, 2563.2703],
	[1098.3041, 2582.1516],
	[1150.9042, 2614.4866],
	[1163.7711, 2707.1145],
	[1160.1978, 2524.0662],
	[1208.244, 2631.4075]
];

_position = _positionArray call BIS_fnc_selectRandom;

_crate = createVehicle [_crateType,_position,[],0,"CAN_COLLIDE"];
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;

_crateLoot = [
	[
		[["ChainSaw",5],"BAF_L85A2_RIS_SUSAT","M4A1_HWS_GL_SD_camo","DMR","SCAR_H_LNG_Sniper_SD","BAF_LRR_scoped","BAF_AS50_scoped"],
		[["30Rnd_556x45_Stanag",10],["30Rnd_556x45_StanagSD",10],["20Rnd_762x51_DMR",10],["5Rnd_127x99_as50",20],["5Rnd_86x70_L115A1",20],"transfusionKit","forest_large_net_kit",["CinderBlocks",20],"cinder_door_kit",["MortarBucket",5],["ItemBriefcase100oz",2],["half_cinder_wall_kit",5],"ItemComboLock","bloodTester"]],
		[["SCAR_L_STD_EGLM_TWS","SCAR_L_STD_EGLM_RCO","Mk13_EP1","M16A4_ACG_GL","SCAR_H_LNG_Sniper"],
		[["6Rnd_HE_M203",5],["20Rnd_762x51_B_SCAR",20],["20Rnd_762x51_SB_SCAR",20],["30Rnd_556x45_Stanag",10],"Skin_Soldier_Bodyguard_AA12_PMC_DZ","ItemMixOil","cinder_garage_kit",["ItemSandbagExLarge5X",10],["ItemBriefcase100oz",1],"full_cinder_wall_kit",["metal_floor_kit",5],"ItemComboLock","ItemFuelcan","ItemAntibacterialWipe"]
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