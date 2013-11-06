#include "defines.sqf"

#ifndef FT2_DISABLE_STUFF1

	//script of tracking shells to prevent respawn attacks
	//see Func_Client_PlayerFired
		
	private ["_TrackTime","_DistanceToFlag"];	
	
	_TrackTime=time+60;	
	_distance=Config_RespawnSafeZone-Config_RespawnBuferZone;
	
	while{!Global_GameEnded&&alive _this&&_TrackTime>time}do
	{	
		_d1=(_this distance Local_FriendlyBaseFlag);		
		_d2=(_this distance Local_EnemyBaseFlag);
		
		_DistanceToFlag=_d1 min _d2;
		if (_DistanceToFlag < _distance)exitWith
		{
			/*
			if ((((velocity _this) select 2) <= 0) || (((getPosATL _this) select 2) < 150) || (_d2 > _d1)) then
			{
				deleteVehicle _this;			
				_TrackTime=0;
			};		
			*/
			deleteVehicle _this;			
			_TrackTime=0;
			
			if (_d2 < _d1) then
			{
				if ((time-Local_LastWarningTimeAttack)>4) then
				{
					[localize "STR_HINT_Warning",localize "STR_HINT_AttackRespawn","pic\no.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
					Local_LastWarningTimeAttack=time;
					
					if (({_this isKindOf _x} count ["MissileBase","RocketBase"]) > 0) then
					{
						player setVariable ["enemytrack",time+Config_EnemyTrackTime,true];
			
						Public_EnemyTracked=player;
						"Public_EnemyTracked" call Func_Common_PublicVariable;
					};
				};
			};			
		};
		sleep(_DistanceToFlag/2000);
	};

#endif
