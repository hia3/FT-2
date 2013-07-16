/**/
_direction=
{
	private["_vel","_veh","_vdir","_dir"];
	
	_vel=_this select 0;
	_veh=_this select 1;
	
	_vdir=(_vel select 0) atan2 (_vel select 1);
	if (_vdir < 0) then {_vdir=_vdir+360};
	_dir=getDir _veh;
	if (_dir < 0) then {_dir=_dir+360};
	
	_vdir=_vdir-_dir;
	
	if (abs(_vdir) < 15) then {true} else {false};
};

_min=30;
_max=40;

if (Local_PlayerVehicle isKindOf "Tank") then
{
	_min=25;
	_max=35;
};

while {(player==(driver Local_PlayerVehicle)) && (Local_HighClimbingModeOn) && (canMove Local_PlayerVehicle)} do
{
	_speed=speed Local_PlayerVehicle;
	_vel=velocity Local_PlayerVehicle;	
	if (_speed < _min) then
	{
		if (Local_KeyPressedForward) then
		{
			if (_speed > 0) then
			{			
				if ([_vel,Local_PlayerVehicle] call _direction) then
				{
					_vel=[(_vel select 0)*1.1,(_vel select 1)*1.1,(_vel select 2)*1.1];
					Local_PlayerVehicle setVelocity _vel;
				};
			};		
		};		
	}
	else
	{	
		if (_speed > _max) then
		{		
			if ([_vel,Local_PlayerVehicle] call _direction) then
			{
				_vel=[(_vel select 0)*0.9,(_vel select 1)*0.9,(_vel select 2)*0.9];
				Local_PlayerVehicle setVelocity _vel;
			};
		};
	};
	sleep 0.1;
};

Local_HighClimbingModeOn=false;