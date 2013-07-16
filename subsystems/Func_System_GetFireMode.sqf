if !((_this select 1) in System_HaveAARadarVehicleDatas) exitWith {};
if (isNull System_RadarTrackedAircraft) exitWith{};
	
_unit=_this select 0;
_ammo=_this select 4;

switch (getText(configFile >> 'CfgAmmo' >> _ammo >> 'simulation')) do
{
	case "shotMissile":
	{
		_ammo=nearestObject [_unit,_ammo];	
		[System_RadarTrackedAircraft,_ammo,_unit] spawn Func_System_AdjustStingerGuidance;
	};
	case "shotBullet":
	{
		_ammo=nearestObject [_unit,_ammo];
		[_unit,_ammo] call Func_System_AdjustCannonGuidance;
	};
	default{};
};
