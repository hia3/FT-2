//Action: Pick helicopter cargo
/**/
_removedropaction=
{
	private["_action","_veh"];
	_veh=_this;
	
	_action=_veh getVariable "FT2_WF_ACT_Drop";
	if !(isNil "_action") then
	{
		_veh removeAction _action;
	};
};

_veh=_this select 0;
_cargo=_this select 1;

if ((isNull _cargo) || ((_cargo distance _veh) > 20) ) exitWith {System_HeliCargoTransportState=0};

_name=gettext(configFile >> "CfgVehicles" >> (typeof _cargo) >> "displayName");

//compare chopper category with cargo category
_chopperCategory=System_CargoChopperCategories select (System_CargoChopperVehicles find (typeOf _veh));
_cargoCategory=-1;
{
	if (_cargo isKindOf (_x select 0)) exitWith 
	{
		_cargoCategory=_x select 1;
	};
} forEach System_CargoVehicleCatrgories;

if ((_cargoCategory==-1) || (_cargoCategory > _chopperCategory)) exitWith {[_name,localize "STR_HINT_Heavy","a3\ui_f\data\gui\Rsc\RscPendingInvitation\desynchigh_ca.paa",1.0] call Func_Client_ShowCustomMessage;};
//end compare

//start vehicle transportation
System_HeliCargoTransportState=1;

_action=_veh addAction [format[localize "STR_ACT_DropCargo",_name],"client\Script_Client_Actions.sqf",[14],99,false,true,"", ""];
_veh setVariable ["FT2_WF_ACT_Drop",_action];	
[_name,localize "STR_HINT_Picked","pic\cargopick_ca.paa",1.0] call Func_Client_ShowCustomMessage;

_loosecargo=false;
_checktime=0;

//setpos loop
//we could use AttachTo command, but i don`t like how attached vehicle behaves
while{(System_HeliCargoTransportState==1) && (alive _veh) && ((_veh emptyPositions "driver")==0) && !(_loosecargo)} do 
{
	sleep 0.01;
	_pos = getposATL _veh;
	_altitude = (_pos select 2);	
	_velocity = velocity _veh;

	if( _altitude > 15) then 
	{
		_cargo setdir getdir _veh;
		_cargo setposATL [(_pos select 0),(_pos select 1),(_pos select 2)-15];		
		_cargo setvelocity _velocity;
	}
 	else
 	{
		_cargo setdir getdir _veh;
		_cargo setposATL [(_pos select 0),(_pos select 1),0];		
		_cargo setvelocity [(_velocity select 0),(_velocity select 1),0];
	};
	//from time to time check if heli is flying too inaccurately
	if (time > _checktime) then
	{
		_checktime=time+0.6;
		_pitchbank=_veh call Func_System_GetPitchBank;
		if ((abs(_pitchbank select 0)>40) || (abs(_pitchbank select 1)>40)) then
		{
			if ((random 1) < 0.35) exitWith
			{
				_loosecargo=true;
				[_name,localize "STR_HINT_Lost","a3\ui_f\data\gui\Rsc\RscPendingInvitation\desynchigh_ca.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;				
			};
		};
	};
};

_veh call _removedropaction;
System_HeliCargoTransportState=0;

if (!(alive _veh) || ((_veh emptyPositions "driver")>0) || _loosecargo) then
{
	//cargo was lost
	_pos=getposATL _veh;
	_vel=velocity _veh;
	_cargo setvelocity _vel;
	if ((_pos select 2)>45) then
	{
		sleep 5.0;
		_cargo setDammage 1;	
	};
}
else
{	
	//cargo was dropped
	[_name,localize "STR_HINT_Dropped","a3\ui_f\data\gui\Rsc\RscPendingInvitation\desynclow_ca.paa",1.0] call Func_Client_ShowCustomMessage;
	if ((getPosATL _veh select 2)>15) then	
	{
		_pos=getPosATL _veh;
		_chute="NonSteerable_Parachute_F";
		_chute=_chute createVehicle [0,0,100];
		_chute setPosATL [_pos select 0,_pos select 1,(_pos select 2)-10];

		_cargo attachTo [_chute,[0,0,-4]];
		
		while {(alive _chute) && ((getPosATL _cargo select 2)>5)} do
		{
			sleep 1;
		};
		detach  _cargo;
		sleep 5;
		deleteVehicle _chute;
	};
};

