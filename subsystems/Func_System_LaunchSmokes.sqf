/**/
_v=_this select 0;
/*_key=_this select 1;*/
_isPlayer=_this select 2;
_launcher=_this select 3;

_period=_v getVariable "smokeslasttime";
if (time<_period) exitWith{};
_v setVariable ["smokeslasttime",time+9];

_smokes=_v getVariable "smokesleft";
if (_smokes <= 0) exitWith {_v vehicleChat localize "STR_MES_SmokesEmpty"; playSound "error_sound";};

_v vehicleChat format[localize "STR_MES_SmokesLaunched",_smokes-1];

playSound3D ["A3\Sounds_F\weapons\HMG\HMG_grenade.wss", _v];

_v setVariable ["smokesleft",_smokes-1,true];

// --------------------

_shells=[];

//Read values from config

_num=GetNumber (configFile >> "CfgVehicles" >> typeof _v >> "smokeLauncherGrenadeCount");
_vel=GetNumber (configFile >> "CfgVehicles" >> typeof _v >> "smokeLauncherVelocity");
_useTDir=GetNumber (configFile >> "CfgVehicles" >> typeof _v >> "smokeLauncherOnTurret");
_angle=GetNumber (configFile >> "CfgVehicles" >> typeof _v >> "smokeLauncherAngle");

if (_num>0) then
{
	_dir = direction _v;
	if ((_useTDir==1) && (count weapons _v > 0)) then
	{
		_dir = _v weaponDirection ((weapons _v) select 0);
		_dir = (((_dir select 0) atan2 (_dir select 1))+360)%360;
	};

	_deltaDir = _angle/_num;			//degrees between grenades.
	_arc = _deltaDir*(_num-1);		//total arc to cover, in degrees

	//distance from vehicle center where grenades are created; base it on vertical height
	_initDist = (((boundingBox _v) select 1) select 2)-(((boundingBox _v) select 0) select 2);

	//sleep 0.25;
	_posV = getpos _v;
	_Vdir = 30;	                     //angle of elevation. Temporary: launch all grenades at same angle
	//derive velocity
	_vH = _vel * cos _Vdir;          //horizontal component of velocity
	_vV = _vel * sin _Vdir;          //vertical component


	for "_i" from 0 to (_num - 1) do
	{
		//find starting parameters
		_Hdir = ((_i*_deltaDir)+_dir) - _arc/2; //relative direction around vehicle


		_Gvel = [_vH *sin(_Hdir), _vH*cos (_Hdir), _vV]; //initial grenade velocity

		//find starting position for grenades
		_pH = _initDist * cos _Vdir;     //initial distance horizontally away from vehicle center to create grenade
		_pV = _initDist * sin _Vdir;     //vertical distance

		//create / launch the grenade
		_smokeg="SmokeShellVehicle" createVehicle ([(_pH * sin _Hdir) + (_posV select 0), (_pH * cos _Hdir)+ (_posV select 1), _pV+ (_posV select 2)]);
		_smokeg setVelocity _Gvel;
		_smokeg setVectorDir _Gvel;
		_shells=_shells+[_smokeg];
	};

	{[_x] spawn Func_System_SpawnSmoke} forEach _shells;

	Public_VehicleSmokeShells=_shells;
	"Public_VehicleSmokeShells" call Func_Common_PublicVariable;
};
