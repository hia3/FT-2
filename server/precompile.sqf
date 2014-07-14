/**/

Server_RegisteredObjects=[];

Func_Server_Animals=compile preprocessFile ("server\Func_Server_Animals.sqf");
Func_Server_CheckTSUsers=compile preprocessFile ("server\Func_Server_CheckTSUsers.sqf");
Func_Server_ClearRegisteredObjects=compile preprocessFile ("server\Func_Server_ClearRegisteredObjects.sqf");
Func_Server_ControlPoints=compile preprocessFile ("server\Func_Server_ControlPoints.sqf");
Func_Server_DynamicWeather=compile preprocessFile ("server\Func_Server_DynamicWeather.sqf");
Func_Server_MissionTiming=compile preprocessFile ("server\Func_Server_MissionTiming.sqf");
Func_Server_RepairTents=compile preprocessFile ("server\Func_Server_RepairTents.sqf");
Func_Server_OnPlayerConnected=compile preprocessFile ("server\Func_Server_OnPlayerConnected.sqf");
Func_Server_OnPlayerDisconnected=compile preprocessFile ("server\Func_Server_OnPlayerDisconnected.sqf");
Func_Server_RespawnVehicle=compile preprocessFile ("server\Func_Server_RespawnVehicle.sqf");
Func_Server_WeatherBroadcast=compile preprocessFile ("server\Func_Server_WeatherBroadcast.sqf");

[Func_Server_CheckTSUsers, []] call Func_Common_Spawn;
[] call Func_Common_ParamsArray;

[
{
	"Global_GameEnded" call Func_Common_PublicVariable;

	{
		clearWeaponCargoGlobal _x; 
		clearMagazineCargoGlobal _x;
		clearItemCargoGlobal _x;
	} forEach (call Config_AmmoCrates);
	
	/*onPlayerConnected "[Func_Server_OnPlayerConnected, []] call Func_Common_Spawn;";*/
	onPlayerDisconnected {[Func_Server_OnPlayerDisconnected, _name] call Func_Common_Spawn;};

	{ private ["_flag", "_texture"]; _flag = _x select 0; _texture = _x select 1; _flag setFlagTexture _texture; } forEach [[Config_EastBaseFlag, Config_EastFlagTexture],[Config_WestBaseFlag, Config_WestFlagTexture]];
	{_x setVariable ["score",0,true]; _x setVariable ["bonus",0,true]} forEach [Config_EastBaseFlag,Config_WestBaseFlag];
	{
		private ["_cp_flags", "_first_flag"];

		_cp_flags = _x select 8;
		_first_flag = _cp_flags select 0;

		_first_flag setVariable ["last_owner_side","none",false];
		_first_flag setVariable ["owner_side","none",false];
		_first_flag setVariable ["flag_timing_east",0,false];
		_first_flag setVariable ["flag_timing_west",0,false];
		_first_flag setVariable ["flag_timing_award",0,false];
	} forEach Config_TotalCheckPointData;

	"Public_UnitRegistered" addPublicVariableEventHandler {Server_RegisteredObjects=Server_RegisteredObjects+[_this select 1]};
	"Public_VehicleLock" addPublicVariableEventHandler {if (local (_this select 1)) then {(_this select 1) lock !((locked (_this select 1))==2)}};
	"Public_DeadUnit" addPublicVariableEventHandler {private["_name"];_name=format["body%1",((_this select 1) select 0) getVariable "playername"]; if ((_this select 1) select 1) then {createMarkerLocal[_name,position ((_this select 1) select 0)]} else {deleteMarkerLocal _name}};
	"Public_PlayerConnected" addPublicVariableEventHandler {call Func_Server_OnPlayerConnected};

	//param daytime
	if (Local_Param_Daytime != 99) then
	{
		skipTime Local_Param_Daytime;
	}
	else
	{
		/*skipTime (4.5+(random 14));*/
		skipTime (6.0+(random 12));
	};

	//param weather
	if !(Config_DisableWeatherChange) then
	{
		10 setOvercast Local_Param_Weather;
		10 setRain Local_Param_Weather;
		10 setFog 0;
	};

	//param mission duration
	Param_RoundDuration = Local_Param_Duration + Config_GameStartDelay;
	"Param_RoundDuration" call Func_Common_PublicVariable;

	while {isNil 'FT2_WF_Logic'} do {sleep 0.1};

	sleep 0.1;

	[Func_Server_ControlPoints, []] call Func_Common_Spawn;
	[Func_Server_ClearRegisteredObjects, []] call Func_Common_Spawn;
	[Func_Server_RespawnVehicle, []] call Func_Common_Spawn;
	[Func_Server_MissionTiming, []] call Func_Common_Spawn;
	[Func_Server_Animals, []] call Func_Common_Spawn;

	if ((count ([] call Config_Hospitals)) > 0) then
	{
		[Func_Server_RepairTents, []] call Func_Common_Spawn;
	};
}
] call Func_Common_Spawn;
