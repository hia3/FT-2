#include "defines.sqf"

//creates vehicles, players buy
//vehicles are created on local machines


//vehicle type, cost, idle time
//see Func_Dialog_HandleVehiclesDialog
_type     = _this select 0;
_cost     = _this select 1;
_idletime = _this select 2;
_distance = _this select 3;


//if vehicle has AA warning system and flares
//or AT warning system and smokes
//see Config_SubSystems
_aawarning=(_type in System_AircraftVehicleTypes);
_atwarning=(_type in System_ArmoredVehicleTypes);
	
//calculate vehicle position
//and direction
_pos=position player;
_px=_pos select 0;
_py=_pos select 1;
_dir=getDir player;

//creating the vehicle
_veh=createVehicle [_type,[_px+_distance*sin _dir,_py+_distance*cos _dir,0],[],0,"None"];
_veh setDir _dir+180;

//setting ammount of repairkits inside
_veh setVariable ["rpair_kits",Config_RepairKitsDefault,true];

#ifndef FT2_DISABLE_STUFF1
_veh lock true;
#endif

_veh setVariable ["owner_name",Local_PlayerName,true];//name of player who bought the vehicle
_veh setVariable ["kill_award",round(_cost*Config_AwardKillVehicleCoef),true];//award for a person who would kill the vehicle, if would; see Func_Common_DestroyUnitAward
_veh setVariable ["ft2_wf_side",Local_PlayerSide,true];//side of the vehicle to check teamkills; see Func_Common_DestroyUnitAward
_veh setVariable ["fieldrepair",0,true];//vehicle is not being under field repair; see Func_Client_FieldRepairs	
_veh setVariable ["ignition_off",false,true];//for tanks: wether ignition is on or off	
_veh setVariable ["idle_time",_idletime,true];//the time vehicle will stay empty before it will be deleted
	
//register a new vehicle on the server and other clients
[_veh] call Func_Client_RegisterCustomVehicle;
	
//remove default smoke and flare launchers
[_veh,true] call Func_System_ClearFlaresAndSmokes;

//prepare vehicle init
//by default it has only award system


clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

#ifndef FT2_DISABLE_STUFF1

_veh call Func_Common_AddHandlers;

if (_veh isKindOf "Air") then
{
	_veh setVariable ["manualflare",false,true];
	_handler=format ["if ((_this select 1) in System_AntiAirMissileTypes) then {[Func_System_IncomingAAMissile, [_this select 0,_this select 1,_this select 2,%1]] call Func_Common_Spawn};",_aawarning];
	_veh addEventHandler ['incomingmissile',_handler];
}
else
{
	if (_veh isKindOf "LandVehicle") then
	{
		_handler=format["if ((_this select 1) in System_AntiTankMissileTypes) then {[Func_System_IncomingATMissile, [_this select 0,_this select 1,_this select 2,%1]] call Func_Common_Spawn};",_atwarning];
		_veh addEventHandler ['incomingmissile',_handler];
	};
};

_veh disableTIEquipment (Local_Param_ThermalImaging == 0);

#endif

_veh
