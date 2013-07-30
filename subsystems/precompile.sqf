#include "Config_Subsystems.sqf";

System_HeliCargoTransportState=0;
System_AntiAirMissileChances=[];
System_AntiTankMissileChances=[];
System_FlareLauncherMagazines=[];
System_SmokeLauncherMagazines=[];
System_ArmoredVehicleCM=[];
System_AircraftVehicleCM=[];
System_CargoChopperCategories=[];
System_GuidedMissileDatas=[];
System_DisposableRPGDatas=[];
System_HaveRadarVehicleDatas=[];
System_LoadableStaticsDatas=[];
System_HaveAARadarVehicleDatas=[];
System_HaveAARadarVehicleRanges=[];

Func_System_AdjustCannonGuidance = compile preprocessFile "SubSystems\Func_System_AdjustCannonGuidance.sqf";
Func_System_AdjustMissileGuidance = compile preprocessFile "SubSystems\Func_System_AdjustMissileGuidance.sqf";
Func_System_AdjustStingerGuidance = compile preprocessFile "SubSystems\Func_System_AdjustStingerGuidance.sqf";
Func_System_AttachExplosives = compile preprocessFile "SubSystems\Func_System_AttachExplosives.sqf";
Func_System_BackBlast = compile preprocessFile "SubSystems\Func_System_BackBlast.sqf";
Func_System_ClearFlaresAndSmokes = compile preprocessFile "SubSystems\Func_System_ClearFlaresAndSmokes.sqf";
Func_System_Deafness = compile preprocessFile "SubSystems\Func_System_Deafness.sqf";
Func_System_DropFlares = compile preprocessFile "SubSystems\Func_System_DropFlares.sqf";
Func_System_FiredNear = compile preprocessFile "SubSystems\Func_System_FiredNear.sqf";
Func_System_GetFireMode = compile preprocessFile "SubSystems\Func_System_GetFireMode.sqf";
Func_System_GetPitchBank = compile preprocessFile "SubSystems\Func_System_GetPitchBank.sqf";
Func_System_GrenadeIntoTank = compile preprocessFile "SubSystems\Func_System_GrenadeIntoTank.sqf";
Func_System_HeliCargoManager = compile preprocessFile "SubSystems\Func_System_HeliCargoManager.sqf";
Func_System_HeliCargoPick = compile preprocessFile "SubSystems\Func_System_HeliCargoPick.sqf";
Func_System_IncomingATMissile = compile preprocessFile "SubSystems\Func_System_IncomingATMissile.sqf";
Func_System_IncomingAAMissile = compile preprocessFile "SubSystems\Func_System_IncomingAAMissile.sqf";
Func_System_KeyPressed = compile preprocessFile "SubSystems\Func_System_KeyPressed.sqf";
Func_System_LaunchSmokes = compile preprocessFile "SubSystems\Func_System_LaunchSmokes.sqf";
Func_System_RadarAiming = compile preprocessFile "SubSystems\Func_System_RadarAiming.sqf";
Func_System_Repaint = compile preprocessFile "SubSystems\Func_System_Repaint.sqf";
Func_System_SetPitchBank = compile preprocessFile "SubSystems\Func_System_SetPitchBank.sqf";
Func_System_SpawnSmoke = compile preprocessFile "SubSystems\Func_System_SpawnSmoke.sqf";
Func_System_TankExploded = compile preprocessFile "SubSystems\Func_System_TankExploded.sqf";

[] spawn 
{

	//Interpriting AA missile types data to be more convenient
	_i=0;
	{
		System_AntiAirMissileChances set [_i,_x select 1];
		System_AntiAirMissileTypes set [_i,_x select 0];
		_i=_i+1;
	} forEach System_AntiAirMissileTypes;
	//End AA missile types data

	//Interpriting AT missile types data to be more convenient
	_i=0;
	{
		System_AntiTankMissileChances set [_i,_x select 1];
		System_AntiTankMissileTypes set [_i,_x select 0];
		_i=_i+1;
	} forEach System_AntiTankMissileTypes;
	//End AT missile types data

	//Interpriting Aircraft vehicles data to be more convenient
	_i=0;
	{
		System_AircraftVehicleCM set [_i,_x select 1];
		System_AircraftVehicleTypes set [_i,_x select 0];
		_i=_i+1;
	} forEach System_AircraftVehicleTypes;
	//End Aircraft vehicles data

	//Interpriting Armored vehicles data to be more convenient
	_i=0;
	{
		System_ArmoredVehicleCM set [_i,_x select 1];
		System_ArmoredVehicleTypes set [_i,_x select 0];
		_i=_i+1;
	} forEach System_ArmoredVehicleTypes;
	//End Armored vehicles data

	//Interpriting Cargo choppers data to be more convenient
	_i=0;
	{
		System_CargoChopperCategories set [_i,_x select 1];
		System_CargoChopperVehicles set [_i,_x select 0];
		_i=_i+1;
	} forEach System_CargoChopperVehicles;
	//End Cargo choppers data

	//Interpriting Guided missiles data to be more convenient
	_i=0;
	{
		System_GuidedMissileDatas set [_i,[_x select 1,_x select 2,_x select 3]];
		System_GuidedMissileTypes set [_i,_x select 0];
		_i=_i+1;
	} forEach System_GuidedMissileTypes;
	//End Guided missiles data
	
	//Interpriting Reloadable static weapons data to be more convenient
	_i=0;
	{
		System_LoadableStaticsDatas set [_i,_x select 1];
		System_LoadableStaticsTypes set [_i,_x select 0];
		_i=_i+1;
	} forEach System_LoadableStaticsTypes;
	//End Reloadable static weapons data to be more convenient

	
	//Interpriting vehicle types with AA radar data to be more convenient
	_i=0;
	_j=0;
	{
		System_HaveAARadarVehicleRanges set [_i,_x select 2];		
		{
			System_HaveAARadarVehicleDatas set [_j,_x];
			_j=_j+1;
		} forEach (_x select 1);			
		System_HaveAARadarVehicleTypes set [_i,_x select 0];
		_i=_i+1;
	} forEach System_HaveAARadarVehicleTypes;
	//End vehicle types with AA radar data to be more convenient


	//Arma vehicle Smoke and Flare launcher systems data
	System_FlareLauncherMagazines=getArray(configFile>>"cfgWeapons">>"CMFlareLauncher">>"Magazines");
	System_SmokeLauncherMagazines=getArray(configFile>>"cfgWeapons">>"SmokeLauncher">>"Magazines");	
	//End data

};