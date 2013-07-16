/**/
_weapon=_this select 0;
_ammo=_this select 1;

_scantime=0.01;

_index=System_GuidedMissileTypes find _weapon;

if (_index < 0) exitWith {};

_vel=(System_GuidedMissileDatas select _index) select 0;
_maxturn=((System_GuidedMissileDatas select _index) select 1)*_scantime;
_sight=(System_GuidedMissileDatas select _index) select 2;

_sensor="emptydetector" createVehicleLocal [0,0,0];
//*******************************************************************
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

_lasttime=time-_scantime;
while {(alive player) && (!isNull _ammo) && (player==(gunner Local_PlayerVehicle))} do
{		
	_t=time;
	_maneurability=_maxturn*(_t-_lasttime)/_scantime;
	_lasttime=_t;
	
	if (isNull cursorTarget) then
	{
		_sensor setPosATL screenToWorld[0.5,0.5];
		_targetPos=getPosASL _sensor;
	}
	else
	{
		_target=cursorTarget;
		_targetPos=getPosASL _target;
		_targetPos set [2,(_targetPos select 2)+2];

		_targetVel=velocity _target;
		_ammoVel=velocity _ammo;
		
		_vx=(_targetVel select 0)-(_ammoVel select 0);
		_vz=(_targetVel select 1)-(_ammoVel select 1);
		_vy=(_targetVel select 2)-(_ammoVel select 2);
		
		_closingSpeed=[_vx,_vz,_vy] distance [0,0,0];		
		_hittime=(_target distance _ammo)/_closingSpeed;
		_targetPos=[(_targetPos select 0)+(_targetVel select 0)*_hittime,(_targetPos select 1)+(_targetVel select 1)*_hittime,(_targetPos select 2)+(_targetVel select 2)*_hittime];
	};	
	
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
	
	if ((abs(_vangle) < _sight) && (abs(_hangle) < _sight)) then
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
		
		_vvel=_vel*sin(_pitch);
		_hvel=_vel*cos(_pitch);
		
		_ammo setVelocity[_hvel*sin(_dir),_hvel*cos(_dir),_vvel];		
	};
	sleep _scantime;
};
deleteVehicle _sensor;
deleteVehicle _li;
deleteVehicle _sp;