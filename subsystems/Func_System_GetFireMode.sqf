if !((_this select 1) in System_HaveAARadarVehicleDatas) exitWith {};
if (isNull System_RadarTrackedAircraft) exitWith{};
	
_unit=_this select 0;
_ammo=_this select 4;

switch (getText(configFile >> 'CfgAmmo' >> _ammo >> 'simulation')) do
{
	case "shotMissile":
	{
		_ammo=nearestObject [_unit,_ammo];	
		[Func_System_AdjustStingerGuidance, [System_RadarTrackedAircraft,_ammo,_unit]] call Func_Common_Spawn;
	};
	case "shotBullet":
	{
		_ammo=nearestObject [_unit,_ammo];
		[_unit,_ammo] call Func_System_AdjustCannonGuidance;
	};
	default{};
};
