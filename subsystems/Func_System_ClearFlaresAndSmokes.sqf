/**/
_veh=_this select 0;
_rearm=_this select 1;

if (_veh isKindOf "air") then
{
	{_veh removeMagazinesTurret[_x,[-1]]} forEach System_FlareLauncherMagazines;	
	if (_rearm) then
	{
		_index=System_AircraftVehicleTypes find (typeOf _veh);
		_cnt=0;
		if (_index >=0) then {_cnt=System_AircraftVehicleCM select _index};
		
		_veh setVariable ["flaresleft",_cnt,true];
		_veh setVariable ["flareslasttime",0,true];	
	};
};

if ((typeOf _veh) in System_ArmoredVehicleTypes) then
{
	{_veh removeMagazinesTurret[_x,[0,0]]} forEach System_SmokeLauncherMagazines;	
	{_veh removeMagazinesTurret[_x,[0]]} forEach System_SmokeLauncherMagazines;
	{_veh removeMagazinesTurret[_x,[-1]]} forEach System_SmokeLauncherMagazines;
	
	if (_rearm) then
	{
		_index=System_ArmoredVehicleTypes find (typeOf _veh);
		_cnt=0;
		if (_index >=0) then {_cnt=System_ArmoredVehicleCM select _index};
		
		_veh setVariable ["smokesleft",_cnt,true];
		_veh setVariable ["smokeslasttime",0,true];	
	};	
};
