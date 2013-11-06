#include "defines.sqf"

#ifndef FT2_DISABLE_STUFF1

	//create local sensors



//when player gets into vehicle, we should update useractions
_sensor=createTrigger["EmptyDetector",[0,0]];
_sensor setTriggerActivation ["ANY", "PRESENT", true];
_sensor setTriggerStatements["(alive player) && ((vehicle player)!=player)","[true] call Func_Client_UpdateVehicleActions","[false] call Func_Client_UpdateVehicleActions"];

_sensor_template_condition="private[""_nearest_obj""]; _nearest_obj=nearestObject[player,""%1""]; (local player) && (alive player) && (Local_PlayerVehicle==player) && ((player distance _nearest_obj)<10) && (alive _nearest_obj) && !(isNull _nearest_obj) && !(_nearest_obj in Local_UserVehicles)";
_sensor_template_code="[""%1""] call Func_Client_AddLockActions";

//check if player aproaches a veicle, handle it to add "Lock", "Unlock" etc. actions
//land vehicles
_sensor=createTrigger["EmptyDetector",[0,0]];
_sensor setTriggerActivation ["ANY", "PRESENT", true];
_sensor setTriggerStatements[format[_sensor_template_condition, "LandVehicle"],format [_sensor_template_code, "LandVehicle"],""];

//check if player aproaches a veicle, handle it to add "Lock", "Unlock" etc. actions
//air vehicles
_sensor=createTrigger["EmptyDetector",[0,0]];
_sensor setTriggerActivation ["ANY", "PRESENT", true];
_sensor setTriggerStatements[format[_sensor_template_condition, "Air"],format [_sensor_template_code, "Air"],""];

//check if player aproaches a veicle, handle it to add "Lock", "Unlock" etc. actions
//air vehicles
_sensor=createTrigger["EmptyDetector",[0,0]];
_sensor setTriggerActivation ["ANY", "PRESENT", true];
_sensor setTriggerStatements[format[_sensor_template_condition, "Ship"],format [_sensor_template_code, "Ship"],""];


//if player is inside a vehicle
//and owner decides to close it, player will see a message
//"vehicle is closed by its owner"
_sensor=createTrigger["EmptyDetector",[0,0]];
_sensor setTriggerActivation ["ANY", "PRESENT", true];
_sensor setTriggerStatements["(alive player) && (Local_PlayerVehicle!=player) && ((locked Local_PlayerVehicle)==2) && ((player getVariable 'playername')!=(Local_PlayerVehicle getVariable 'owner_name'))","[getText(configFile>>'CfgVehicles'>>typeOf Local_PlayerVehicle>>'displayname'),localize 'STR_HINT_LockedOwner','pic\lock_off_ca.paa',1.0] call Func_Client_ShowCustomMessage","call compile 'if ((alive player) && (Local_PlayerVehicle!=player)) then {[getText(configFile>>''CfgVehicles''>>typeOf Local_PlayerVehicle>>''displayname''),localize ''STR_HINT_UnlockedOwner'',''pic\lock_on_ca.paa'',1.0] call Func_Client_ShowCustomMessage}'"];


//if player selects a disposable RPG as the current weapon
//add him an ammo
//if he deselects - remove that ammo
_sensor=createTrigger["EmptyDetector",[0,0]];
_sensor setTriggerActivation ["ANY", "PRESENT", true];
_sensor setTriggerStatements["(alive player) && (Local_PlayerVehicle==player) && ((currentWeapon player) in System_DisposableRPGTypes)","_magazine=(getArray(configFile>>'cfgWeapons'>>secondaryWeapon player>>'magazines')) select 0; player addMagazine _magazine","_magazine=(getArray(configFile>>'cfgWeapons'>>secondaryWeapon player>>'magazines')) select 0; player removeMagazines _magazine"];


//if player gets negative rating
//restore rating or some systems will not work
_sensor=createTrigger["EmptyDetector",[0,0]];
_sensor setTriggerActivation ["ANY", "PRESENT", true];
_sensor setTriggerStatements["(alive player) && ((rating player) < 0)","player addRating -(rating player)",""];


//reset injury flag for healer awarding
_sensor=createTrigger["EmptyDetector",[0,0]];
_sensor setTriggerActivation ["ANY", "PRESENT", true];
_sensor setTriggerStatements["!(alive player) || (({(animationState player)==_x} count ['AmovPpneMstpSrasWrflDnon_healed','AinvPknlMstpSlayWrflDnon_healed','AinvPknlMstpSlayWrflDnon_healed2']) > 0)","Local_InjuredByEnemy=false",""];

#endif
