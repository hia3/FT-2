#include "defines.sqf"

#ifndef FT2_DISABLE_STUFF1
	
private["_player","_weapon","_ammotype", "_ammomag","_ammo"];
	
_player   = _this select 0;
_weapon   = _this select 1;
_ammotype = _this select 4;
_ammomag  = _this select 5;

_ammo = nearestObject[_player,_ammotype];

//if player fired at base - see Func_Client_AproachingRespawnArea
if (Local_PlayerInSafeZone>0) then
{
	deleteVehicle _ammo;
	
	if (Local_PlayerVehicle==player) then
	{
		if (_weapon in ["Put"]) then
		{
			_player addMagazine _ammomag;
		};
			
		//shots counter
		Local_ShotsDoneAtBase=Local_ShotsDoneAtBase+1;

		switch (Local_ShotsDoneAtBase) do
		{
			case 1:
			{
				[localize "STR_HINT_Warning",format[localize "STR_HINT_FireAtBase",Local_ShotsDoneAtBase,3],"pic\no.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
			};
			case 2:
			{
				[localize "STR_HINT_Warning",format[localize "STR_HINT_FireAtBase",Local_ShotsDoneAtBase,3],"pic\no.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
				{_player removeMagazines _x} forEach getArray(configFile>>"cfgWeapons">>_weapon>>"magazines");
			};
			case 3:
			{				
				_player setDamage 1;
			};
			default{};
		};
			//if player fired a disposable RPG
		if (_weapon==secondaryWeapon player) then
		{				
			if (_weapon in System_DisposableRPGTypes) then
			{
				[{ sleep 1.0; player removeWeapon _this}, _weapon] call Func_Common_Spawn;
			};
		};
	};
}else{	
	if (Local_PlayerVehicle==player) then
	{
		//make RPG`s some unaccurate
		//handle disposable RPG`s
		//handle backblast
		if (_weapon==secondaryWeapon player) then
		{
			if (_weapon in System_DisposableRPGTypes) then
			{
				[{ sleep 1.0; player removeWeapon _this}, _weapon] call Func_Common_Spawn ;
			};
			[player] call Func_System_BackBlast;
		};
	}else{			
		//handle laser-guidance of some missiles
		//which are bugged (fall to the ground after start)
		if ((_weapon in System_GuidedMissileTypes) && (player==(gunner Local_PlayerVehicle))) then
		{
			[Func_System_AdjustMissileGuidance, [_weapon,_ammo]] call Func_Common_Spawn;
		};			
	};
};
	
if (_weapon in ["Put"]) then
{
	if (({_player in list _x} count Local_TaskSensors) > 0) then
	{			
		[localize "STR_HINT_Warning",localize "STR_HINT_MineNearFlag","pic\no.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
		deleteVehicle _ammo;
		_player addMagazine _ammomag;
	}else{
		Local_PlayerMines=Local_PlayerMines+[_ammo];
	};
}else{
	//track shell flight not to allow enemy respawn attack
	if (!isNull _ammo) then
	{
		[Func_Client_TrackShell, _ammo] call Func_Common_Spawn;
	};
};

#endif
