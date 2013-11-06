#include "defines.sqf"

#ifndef FT2_DISABLE_STUFF1
	
//adds actions "Lock", "Unlock", "Field repair", "Push crew" to vehicle
//see Func_Client_CreateSensors
_param=_this select 0;

//script is called by the sensor, which activates when player approaches any vehicle
_veh=nearestObject[player,_param];

//check, if vehicle exsists and if it is not already handled

if (!(isNull _veh) && !(_veh in Local_UserVehicles)) then
{
	//remove all dead vehicles not to take place in variable
	{if (!(alive _x) || (isNull _x)) then {Local_UserVehicles=Local_UserVehicles-[_x]} } ForEach Local_UserVehicles;

	//get vehicle name to participate in useractions
	_name=getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "DisplayName");
	
	//add useractions
	if (_veh isKindOf "StaticWeapon") then
	{

		if (({_veh isKindOf _x} count System_LoadableStaticsTypes)>0) then
		{
			_veh addAction ["<t color='#FFBD4C'>"+format[localize "STR_ACT_MGLoadMagazine",_name]+"</t>","client\Script_Client_Actions.sqf",[20],89,false,true,"", "(alive _target) && ((player distance _target) < 4)"];
		};
			
		if (({_veh isKindOf _x} count System_MovableStaticsTypes)>0) then
		{
			if (isNull (_veh getVariable["StaticMover",objNull])) then 
			{
				_veh setVariable ["StaticMover",objNull,true];
			};
			
			_veh addAction ["<t color='#FFBD4C'>"+format[localize "STR_ACT_MGTurnLeft",_name]+"</t>","client\Script_Client_Actions.sqf",[17],89,false,true,"", "(alive _target) && (({alive _x} count crew _target)==0) && ((player distance _target) < 3) && !(Local_MovingStatic) && ((_target distance (_target getVariable 'StaticMover'))>5)"];
			_veh addAction ["<t color='#FFBD4C'>"+format[localize "STR_ACT_MGTurnRight",_name]+"</t>","client\Script_Client_Actions.sqf",[18],88,false,true,"", "(alive _target) && (({alive _x} count crew _target)==0) && ((player distance _target) < 3) && !(Local_MovingStatic) && ((_target distance (_target getVariable 'StaticMover'))>5)"];
			_veh addAction ["<t color='#FFBD4C'>"+format[localize "STR_ACT_MGMove",_name]+"</t>","client\Script_Client_Actions.sqf",[19],87,false,true,"", "(alive _target) && (({alive _x} count crew _target)==0) && ((player distance _target) < 3) && !(Local_MovingStatic) && ((_target distance (_target getVariable 'StaticMover'))>5)"];
		};
	}else{
		_veh addAction [format[localize "STR_ACT_LockVeh",_name],"client\Script_Client_Actions.sqf",[5],99,false,true,"", "(alive _target) && !((locked _target)==2) && ((player getVariable 'playername')==(_target getVariable 'owner_name')) && ((side _target)!=Local_EnemySide)"];
		_veh addAction [format[localize "STR_ACT_UnlockVeh",_name],"client\Script_Client_Actions.sqf",[5],99,false,true,"", "(alive _target) && ((locked _target)==2) && (((player getVariable 'playername')==(_target getVariable 'owner_name')) || (({(_x getVariable 'playername')==(_target getVariable 'owner_name')} count Local_CurrentPlayers)==0)) && ((side _target)!=Local_EnemySide)"];
		_veh addAction ["<t color='#4C4FFF'>"+(format[localize "STR_ACT_FieldRepair",_name])+"</t>","client\Script_Client_Actions.sqf",[6],100,false,true,"", "(Local_PlayerVehicle==player) && (alive _target) && ((side _target)!=Local_EnemySide) && (!(canMove _target) || ((getDammage _target)>0.002) || (((fuel _target)==0) && !(_target getVariable 'ignition_off'))) && !Local_TechnicalService"];
		_veh addAction [format[localize "STR_ACT_PushCrew",_name],"client\Script_Client_Actions.sqf",[15],89,false,true,"", "(alive _target) && (({alive _x} count crew _target)>0) && ((speed _target)<30) && (((getposATL _target) select 2)<10) && ((player getVariable 'playername')==(_target getVariable 'owner_name')) && ((side _target)==Local_PlayerSide)"];
	};		
		
	//register the vehicle not to handle it again
	Local_UserVehicles=Local_UserVehicles+[_veh];		
};

#endif
