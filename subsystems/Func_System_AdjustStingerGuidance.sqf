/**/


_target=_this select 0;
_ammo=_this select 1;
_antiAir=_this select 2;

#define __SCANTIME		0.01

#define __DIST 			3000
#define __VEL  			450
#define __MAXTURN 		18
#define __SIGHT 		30
#define __BACKSPHERE 	35

//*******************************************************************
_sm = "#particlesource" createVehicleLocal getpos _ammo;
_sm setParticleRandom [0.5, [0.3, 0.3, 0.3], [0.5, 0.5, 0.5], 0, 0.3, [0, 0, 0, 0], 0, 0,360];
/*_sm setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal", 16, 12, 8,0],
"", "Billboard", 1, 3, [0, 0, 0],
[0,0,0], 1, 1, 0.80, 0.5, [1.3,4],
[[0.9,0.9,0.9,0.6], [1,1,1,0.3], [1,1,1,0]],[1],0.1,0.1,"","",_ammo];*/
_sm setdropinterval 0.02;
_sp = "#particlesource" createVehicleLocal getpos _ammo;
_sp setParticleRandom [0.03, [0.3, 0.3, 0.3], [1, 1, 1], 0, 0.2, [0, 0, 0, 0], 0, 0,360];
/*_sp setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal", 16, 4, 2,0],
"", "Billboard", 1, 0.1, [0, 0, 0],
[0,0,0], 1, 1, 0.80, 0.5, [1.0,0],
[[1,1,1,-4], [1,1,1,-4], [1,1,1,-2],[1,1,1,0]],[1000],0.1,0.1,"","",_ammo,360];*/
_sp setdropinterval 0.001;

_li = "#lightpoint" createVehicleLocal getpos _ammo;
_li setLightBrightness 0.1;
_li setLightAmbient[0.8, 0.6, 0.2];
_li setLightColor[1, 0.5, 0.2];
_li lightAttachObject [_ammo, [0,0,0]];
//*******************************************************************


_targetPos=[0,0,0];

_lasttime=time-__SCANTIME;
while {(!isNull _ammo) && ((_ammo distance _antiAir) < __DIST)} do
{		
	_t=time;
	_maneurability=__MAXTURN*(_t-_lasttime)/__SCANTIME;
	_lasttime=_t;
	
	_targetPos=getPosASL _target;
	_targetPos set [2,(_targetPos select 2)+2];

	_targetVel=velocity _target;
	_ammoVel=velocity _ammo;
	
	_vx=(_targetVel select 0)-(_ammoVel select 0);
	_vz=(_targetVel select 1)-(_ammoVel select 1);
	_vy=(_targetVel select 2)-(_ammoVel select 2);
	
	_closingSpeed=[_vx,_vz,_vy] distance [0,0,0];		
	_targetSpeed=_targetVel distance [0,0,0];
	_ammoSpeed=_ammoVel distance [0,0,0];
	_hittime=0;
	
	if ((_targetSpeed > 0) && (_ammoSpeed > 0)) then
	{
		_angle=acos((_targetSpeed*_targetSpeed+_ammoSpeed*_ammoSpeed-_closingSpeed*_closingSpeed)/(2*_targetSpeed*_ammoSpeed));
		if (_angle < 0) then {_angle=_angle+180};		
		if (_angle > 35) then
		{
			_hittime=(_target distance _ammo)/_closingSpeed;
		};
	};
	
	_targetPos=[(_targetPos select 0)+(_targetVel select 0)*_hittime,(_targetPos select 1)+(_targetVel select 1)*_hittime,(_targetPos select 2)+(_targetVel select 2)*_hittime];
	
	_ammoPos=getPosASL _ammo;	
	
	_dx=(_targetPos select 0)-(_ammoPos select 0);
	_dz=(_targetPos select 1)-(_ammoPos select 1);
	_dy=(_targetPos select 2)-(_ammoPos select 2);
	_dv=[_dx,_dz,0] distance [0,0,0];
	
	_dir=getDir _ammo;
	_pitch=_ammo call Func_System_GetPitchBank;
	_pitch=_pitch select 0;
	
	_vangle=(_dy atan2 _dv)-_pitch;	
	_hangle=(_dx atan2 _dz)-_dir;
	if (_hangle < -89) then {_hangle=_hangle+360};
	
	/*hintSilent format["V-Angle: %1\nH-Angle: %2\nT-Pos: %3\nA-Pos: %4\nDx: %5\nDz: %6\nDy: %7\nDv: %8\nH-Vel: %9\nV-Vel: %10",_vangle,_hangle,_targetPos,_ammoPos,_dx,_dz,_dy,_dv,_hvel,_vvel];*/
	
	if ((abs(_vangle) < __SIGHT) && (abs(_hangle) < __SIGHT)) then
	{
		if (abs(_vangle) > _maneurability) then
		{
			if (_vangle > 0) then
			{
				_vangle=_maneurability;
			}
			else
			{
				_vangle=-_maneurability;
			};
		};
		if (abs(_hangle) > _maneurability) then
		{
			if (_hangle > 0) then
			{
				_hangle=_maneurability;
			}
			else
			{
				_hangle=-_maneurability;
			};
		};	
		
		_ammo setDir (_dir+_hangle);
		_pitch=_pitch+_vangle;
		[_ammo,_pitch,0] call Func_System_SetPitchBank;		
		
		_vvel=__VEL*sin(_pitch);
		_hvel=__VEL*cos(_pitch);
		
		_ammo setVelocity[_hvel*sin(_dir),_hvel*cos(_dir),_vvel];		
	};
	sleep __SCANTIME;
};


deleteVehicle _li;
deleteVehicle _sp;
deleteVehicle _sm;
