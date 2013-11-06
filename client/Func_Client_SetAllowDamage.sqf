#include "defines.sqf"

#ifndef FT2_DISABLE_STUFF1

_distance=Config_RespawnSafeZone-Config_RespawnBuferZone;
{
	_side=_x getVariable "ft2_wf_side";
	
	if !(isNil "_side") then
	{
		if (_side==Local_EnemySide) then
		{
			if ((_x distance Local_EnemyBaseFlag) < _distance) then
			{
				_x allowDamage false;
				(vehicle _x) allowDamage false;
			}
			else
			{
				_x allowDamage true;
				(vehicle _x) allowDamage true;
			};
		};
	};
} forEach allUnits;

if ((getFatigue player) > 0.6) then
{
	player setFatigue 0.6;
};

#endif
