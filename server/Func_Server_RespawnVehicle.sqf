	/**/

	_setinit=
	{
		private["_veh","_award","_aawarning","_atwarning","_side","_startpos","_startdir","_init","_handler"];
		_veh=_this select 0;
		_award=_this select 1;
		_aawarning=_this select 2;
		_atwarning=_this select 3;
		_side=_this select 4;
		_startpos=_this select 5;
		_startdir=_this select 6;

		clearWeaponCargoGlobal _veh;
		clearMagazineCargoGlobal _veh;
		clearItemCargoGlobal _veh;
		clearBackpackCargoGlobal _veh;

		_veh call Func_Common_AddHandlers;

		_handler="";

		//AA
		if (_veh isKindOf "Air") then
		{
			_veh setVariable ["manualflare",false,true];

			_handler=_handler+format ["if ((_this select 1) in System_AntiAirMissileTypes) then {[Func_System_IncomingAAMissile, [_this select 0,_this select 1,_this select 2,%1]] call Func_Common_Spawn};",_aawarning];
		}
		else
		{
			//AT
			if (_veh isKindOf "LandVehicle") then
			{
				_handler=_handler+format["if ((_this select 1) in System_AntiTankMissileTypes) then {[Func_System_IncomingATMissile, [_this select 0,_this select 1,_this select 2,%1]] call Func_Common_Spawn};",_atwarning];
			};
		};
		_veh addEventHandler ['incomingmissile',_handler];

		//disable TI sensors
		//_veh disableTIEquipment true;

		_veh setVariable ["ft2_wf_side",_side,true];
		_veh setVariable ["owner_name","",true];
		_veh setVariable ["kill_award",_award,true];
		_veh setVariable ["ignition_off",false,true];

		_veh setVariable ["start_pos",_startpos];
		_veh setVariable ["start_dir",_startdir];
		_veh setVariable ["last_used",0];
		_veh setVariable ["timeofdeath",-1];

		[_veh,true] call Func_System_ClearFlaresAndSmokes;

	};

	_respawncheck=
	{
		private["_veh","_respawndelay","_award","_aawarning","_atwarning","_isMHQ","_side","_startpos","_startdir","_lastUsedTime","_respawndelay","_deathtime","_typ","_varname","_nearest_man"];
		_veh=_this select 0;
		_respawndelay=_this select 1;
		_award=_this select 2;
		_aawarning=_this select 3;
		_atwarning=_this select 4;
		_isMHQ=_this select 5;
		_side=_this select 6;

		_startpos=_veh getVariable "start_pos";
		_lastUsedTime=_veh getVariable "last_used";
		_deathtime=_veh getVariable "timeofdeath";

		_nearest_man = nearestObject [_veh, "CAManBase"];
		_nearest_man = if (alive _nearest_man) then { _nearest_man } else { objNull };

		if (((canMove _veh) && (_isMHQ) && !(surfaceIsWater position _veh)) || (({alive _x} count crew _veh)>0) || ((_veh distance _startpos) < 50) || !(isNull _nearest_man)) then
		{
			_lastUsedTime=time;
			_veh setVariable ["last_used",_lastUsedTime];
		};

		if ((((damage _veh) > 0.98) || ((time-_lastUsedTime) > _respawndelay)) && ((_veh getVariable "timeofdeath")<0)) then
		{
			_veh setFuel 0;
			_veh setVehicleAmmo 0;
			_veh setDamage 1;

			_deathtime=time+_respawndelay;
			_veh setVariable ["timeofdeath",_deathtime];
		};

		if (!(alive _veh) && (_deathtime < time)) then
		{
			_typ=typeOf _veh;
			_startdir=_veh getVariable "start_dir";
			_varname=vehicleVarName _veh;

			deleteVehicle _veh;

			_veh=createVehicle [_typ,_startpos,[],0,"NONE"];
			if ((_veh isKindOf "StaticWeapon") || (surfaceIsWater _startpos)) then
			{
				_veh setPosATL _startpos;
			};
			_veh setDir _startdir;
			_veh setVelocity [0,0,-10];

			_veh setVehicleVarName _varname;
			_veh call compile format ["%1=_veh; '%1' call Func_Common_PublicVariable;", _varname];

			[_veh,_award,_aawarning,_atwarning,_side,_startpos,_startdir] call _setinit;
		};
	};

	{[_x,Config_MHQDestroyAward,false,false,east,getPosATL _x,getDir _x] call _setinit} forEach ([] call Config_EastMHQ);
	{[_x,Config_MHQDestroyAward,false,false,west,getPosATL _x,getDir _x] call _setinit} forEach ([] call Config_WestMHQ);
	{[_x select 0,_x select 2,_x select 3,_x select 4,_x select 6,getPos (_x select 0),getDir (_x select 0)] call _setinit} forEach ([] call Config_RespawningVehicles);

	while {!(Global_GameEnded)} do
	{
		{[_x,Config_MHQRespawnDelay,Config_MHQDestroyAward,false,false,true,east] call _respawncheck} forEach ([] call Config_EastMHQ);
		{[_x,Config_MHQRespawnDelay,Config_MHQDestroyAward,false,false,true,west] call _respawncheck} forEach ([] call Config_WestMHQ);
		{_x call _respawncheck} forEach ([] call Config_RespawningVehicles);
		sleep 15;
	};
