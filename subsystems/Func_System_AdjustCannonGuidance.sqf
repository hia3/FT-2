private["_ammo","_target","_targetVel","_targetPos","_dx","_dz","_dy","_dv","_dt","_vangle","_hangle","_ammoVel"];

//_unit=_this select 0;
_ammo=_this select 1;

_target=System_RadarTrackedAircraft;

#define __AMMOSPEED		970
#define __DISPERSION	0.1299

_targetVel=velocity _target;
_targetPos=getPosASL _target;
_targetPos set [2,(_targetPos select 2)+2];
_ammoPos=getPosASL _ammo;

_dx=(_targetPos select 0)-(_ammoPos select 0);
_dz=(_targetPos select 1)-(_ammoPos select 1);
_dy=(_targetPos select 2)-(_ammoPos select 2);
_dv=[_dx,_dz,0] distance [0,0,0];

//calculate fire deviation - step #1 - calculate basic
_dt=(_dv/__AMMOSPEED);

_dx=(_targetPos select 0)+(_targetVel select 0)*_dt-(_ammoPos select 0);
_dz=(_targetPos select 1)+(_targetVel select 1)*_dt-(_ammoPos select 1);
_dy=(_targetPos select 2)+(_targetVel select 2)*_dt-(_ammoPos select 2);
_dv=[_dx,_dz,0] distance [0,0,0];

//calculate fire deviation	 - step #2 - correct calculation
_dt=(_dv/__AMMOSPEED)*1.1299;	
		
_dx=(_targetPos select 0)+(_targetVel select 0)*_dt-(_ammoPos select 0);
_dz=(_targetPos select 1)+(_targetVel select 1)*_dt-(_ammoPos select 1);
_dy=(_targetPos select 2)+(_targetVel select 2)*_dt-(_ammoPos select 2);
_dv=[_dx,_dz,0] distance [0,0,0];

_vangle=(_dy atan2 _dv)+random (__DISPERSION*2)-random __DISPERSION;	
_hangle=(_dx atan2 _dz)+random (__DISPERSION*2)-random __DISPERSION;

_vvel=__AMMOSPEED*sin(_vangle);
_hvel=__AMMOSPEED*cos(_vangle);

_ammoVel=[_hvel*sin(_hangle),_hvel*cos(_hangle),_vvel];

_ammo setDir _hangle;
[_ammo,_vangle,0] call Func_System_SetPitchBank;

_ammo setVelocity _ammoVel;

[
{
	while {!isNull (_this select 0)} do
	{
		(_this select 0) setVelocity [0,0,0];
		(_this select 0) setVelocity (_this select 1);
		sleep 0.1;
	};
}, 
[_ammo,_ammoVel]] call Func_Common_Spawn;
