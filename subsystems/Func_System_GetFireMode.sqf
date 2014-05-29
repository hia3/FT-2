if !((_this select 1) in System_HaveAARadarVehicleDatas) exitWith {};
if (isNull System_RadarTrackedAircraft) exitWith{};

_unit      = _this select 0;
_ammo_type = _this select 4;
_ammo      = _this select 6;

switch (getText(configFile >> 'CfgAmmo' >> _ammo_type >> 'simulation')) do
{
	case "shotMissile":
	{
	};
	case "shotBullet":
	{
		[_unit,_ammo] call Func_System_AdjustCannonGuidance;
	};
	default{ };
};
