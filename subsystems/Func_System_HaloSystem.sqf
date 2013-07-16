Halo_Marker_LZ =
{

	_Markername = format["%1_Halo",name player];
	_marker = createMarkerLocal[_Markername,[-10000,-10000]];
	_marker setMarkerShapeLocal "ICON";
	_Markername setMarkerTypeLocal "DOT";
    onMapSingleClick {format['%1_Halo',name player] setMarkerPosLocal _pos; true;};
};
Halo_Remove_Marker_LZ  =
{
    onMapSingleClick {};
	_Markername = format["%1_Halo",name player];
	//deleteMarkerLocal _Markername;
	deleteMarker _Markername;
};
Halo_FreeFall =
{
	deleteVehicle vehicle player;
	_unit = player;
	_unit switchMove "HaloFreeFall_non";
	
	_mags = magazines _unit;
	explosives = ["Mine","PipeBomb"];
	hasmines = [];
	
	{	
		if ((_x == "Mine") or (_x == "PipeBomb")) then
		{
			hasmines = hasmines + [_x];
		};
	} foreach _mags;
	sleep 0.1;
	if ((count hasmines) > 0) then 
	{
		{_unit removeMagazine _x;} foreach hasmines; 
	};
	
	
	
	
	//--- Key controls
	if (_unit == player) then 
	{
		bis_fnc_halo_soundLoop = time;
		playsound "BIS_HALO_Flapping";
		bis_fnc_halo_action = player addAction ["<t color='#4C4FFF'>Open</t>","client\Script_Client_Actions.sqf",[31],98,false,true,"",""];
		bis_fnc_halo_keydown = 
		{
            private "_key";
            _key = _this select 1;

			//--- Forward
			//if (_key in (actionkeys 'HeliForward')) then {
			if (_key in (actionkeys 'MoveForward')) then {
				if (bis_fnc_halo_vel < +bis_fnc_halo_velLimit) then {bis_fnc_halo_vel = bis_fnc_halo_vel + bis_fnc_halo_velAdd};

			};

			//--- Backward
			//if (_key in (actionkeys 'HeliBack')) then {
			if (_key in (actionkeys 'MoveBack')) then {
				if (bis_fnc_halo_vel > -bis_fnc_halo_velLimit) then {bis_fnc_halo_vel = bis_fnc_halo_vel - bis_fnc_halo_velAdd};
			};

			//--- Left
			//if (_key in (actionkeys 'HeliCyclicLeft')) then {
			if (_key in (actionkeys 'TurnLeft')) then {
				if (bis_fnc_halo_dir > -bis_fnc_halo_dirLimit) then {bis_fnc_halo_dir = bis_fnc_halo_dir - bis_fnc_halo_dirAdd};
			};

			//--- Right
			//if (_key in (actionkeys 'HeliCyclicRight')) then {
			if (_key in (actionkeys 'TurnRight')) then {
				if (bis_fnc_halo_dir < +bis_fnc_halo_dirLimit) then {bis_fnc_halo_dir = bis_fnc_halo_dir + bis_fnc_halo_dirAdd};
			};
		};
		bis_fnc_halo_keydown_eh = (finddisplay 46) displayaddeventhandler ["keydown","_this call bis_fnc_halo_keydown"];

		//--- Loop
		bis_fnc_halo_vel = 0;
		bis_fnc_halo_velLimit = 0.2;
		bis_fnc_halo_velAdd = 0.03;
		bis_fnc_halo_dir = 0;
		bis_fnc_halo_dirLimit = 1;
		bis_fnc_halo_dirAdd = 0.06;

		_unit switchMove "HaloFreeFall_non";
		[] spawn 
		{
            private ["_vAnim","_hAnim","_anim","_fpsCoef","_time","_dir","_vel","_v","_h","_vLimit","_hLimit"];
            _time = time - 0.1;
			while { alive player && vehicle player == player} do 
			{
				//--- FPS counter
				_fpsCoef = ((time - _time) * 30) / 1; //Script is optimized for 60 FPS... not anymore...
				_time = time;

				bis_fnc_halo_velLimit = 0.2 * _fpsCoef;
				bis_fnc_halo_velAdd = 0.03 * _fpsCoef;
				bis_fnc_halo_dirLimit = 1 * _fpsCoef;
				bis_fnc_halo_dirAdd = 0.06 * _fpsCoef;

				//--- Dir
				bis_fnc_halo_dir = bis_fnc_halo_dir * 0.98;
				_dir = direction player + bis_fnc_halo_dir;
				player setdir _dir;

				//--- Velocity
				_vel = velocity player;
				bis_fnc_halo_vel = bis_fnc_halo_vel * 0.96;
				player setvelocity [
                    (_vel select 0) + ((sin _dir) * bis_fnc_halo_vel),
                    (_vel select 1) + ((cos _dir) * bis_fnc_halo_vel),
					(_vel select 2)
				];

				//--- Animation system
				//_anim = "HaloFreeFall_non";
				_anim = "";
				_v = bis_fnc_halo_vel;
				_h = bis_fnc_halo_dir;

				_vLimit = 0.1;
				_hLimit = 0.3;
				if ((abs _v) > _vLimit || (abs _h) > _hLimit) then 
				{
					_vAnim = "";
					if (_v > +_vLimit) then {_vAnim = "F"};
					if (_v < -_vLimit) then {_vAnim = "B"};
					_hAnim = "";
					if (_h > +_hLimit) then {_hAnim = "R"};
					if (_h < -_hLimit) then {_hAnim = "L"};
					_anim = "HaloFreeFall_" + _vAnim + _hAnim;
				};

				//hintsilent str(_anim);
				//CYBP_animHalo = [player, _anim, "playMoveNow"];
				vehicle player playmovenow _anim;

				//--- Sound
				if ((time - bis_fnc_halo_soundLoop) > 4.5) then {
					playsound "BIS_HALO_Flapping";
					bis_fnc_halo_soundLoop = time;
				};

				
				// auto open on 120M
				if ((getpos player select 2) < 127) exitwith 
				{
				
					//if ((count hasmines) > 0) then {{player addmagazine _x;} foreach hasmines;};
					//player removeaction bis_fnc_halo_action;
					//(finddisplay 46) displayremoveeventhandler ["keydown",bis_fnc_halo_keydown_eh];
					[] spawn Halo_Parachute;
				};
				
				//--- Effects
				//bis_fnc_halo_ppRadialBlur ppEffectAdjust [0.02,0.02,0.3 - (bis_fnc_halo_vel/7)/_fpsCoef,0.3 - (bis_fnc_halo_vel/7)/_fpsCoef];
				//bis_fnc_halo_ppRadialBlur ppEffectCommit 0.01;
			
				hintSilent format ["Height: %1", round (position player select 2)];
				sleep 0.01;
			};
			//--- End
			hintSilent "";
			
			if ((count hasmines) > 0) then {{player addmagazine _x;} foreach hasmines;};
			player removeaction bis_fnc_halo_action;
			(finddisplay 46) displayremoveeventhandler ["keydown",bis_fnc_halo_keydown_eh];
			
			

			
			//ppeffectdestroy bis_fnc_halo_ppRadialBlur;
			//deletevehicle bis_fnc_halo_clouds;

			//bis_fnc_halo_clouds = nil;
			bis_fnc_halo_vel = nil;
			bis_fnc_halo_velLimit = nil;
			bis_fnc_halo_velAdd = nil;
			bis_fnc_halo_dir = nil;
			bis_fnc_halo_dirLimit = nil;
			bis_fnc_halo_dirAdd = nil;
			bis_fnc_halo_action = nil;
			bis_fnc_halo_keydown = nil;
			bis_fnc_halo_keydown_eh = nil;

		};
	};
};
Halo_Parachute =
{
	_unit = player;
	_para = "ParachuteC" createVehicle position _unit;
	//_para = "BIS_Steerable_Parachute" createVehicle position _unit;
	_para setpos position _unit;
	_para setdir direction _unit;
	_vel = velocity _unit;
	_unit moveindriver _para;
	//_unit moveingunner _para;
	_para lock false;

	bis_fnc_halo_para_dirAbs = direction _para;

	//--- Key controls
	if (_unit == player) then 
	{
		_para setvelocity [(_vel select 0),(_vel select 1),(_vel select 2)*1];

		bis_fnc_halo_DynamicBlur = ppeffectcreate ["DynamicBlur",464];
		bis_fnc_halo_DynamicBlur ppEffectEnable true;
		bis_fnc_halo_DynamicBlur ppEffectAdjust [8.0];
		bis_fnc_halo_DynamicBlur ppEffectCommit 0;
		bis_fnc_halo_DynamicBlur ppEffectAdjust [0.0];
		bis_fnc_halo_DynamicBlur ppEffectCommit 1;

		bis_fnc_halo_para_vel = 0;
		bis_fnc_halo_para_velLimit = 0.5;
		bis_fnc_halo_para_velAdd = 0.01;
		bis_fnc_halo_para_dir = 0;
		bis_fnc_halo_para_dirLimit = 1.5;
		bis_fnc_halo_para_dirAdd = 0.03;

		bis_fnc_halo_para_keydown = {
			_key = _this select 1;

			//--- Forward
			if (_key in (actionkeys 'MoveForward')) then {
				if (bis_fnc_halo_para_vel < +bis_fnc_halo_para_velLimit) then {bis_fnc_halo_para_vel = bis_fnc_halo_para_vel + bis_fnc_halo_para_velAdd};
			};

			//--- Backward
			if (_key in (actionkeys 'MoveBack')) then {
				if (bis_fnc_halo_para_vel > -bis_fnc_halo_para_velLimit*0) then {bis_fnc_halo_para_vel = bis_fnc_halo_para_vel - bis_fnc_halo_para_velAdd};
			};

			//--- Left
			if (_key in (actionkeys 'TurnLeft')) then {
				if (bis_fnc_halo_para_dir > -bis_fnc_halo_para_dirLimit) then {bis_fnc_halo_para_dir = bis_fnc_halo_para_dir - bis_fnc_halo_para_dirAdd};
			};

			//--- Right
			if (_key in (actionkeys 'TurnRight')) then {
				if (bis_fnc_halo_para_dir < +bis_fnc_halo_para_dirLimit) then {bis_fnc_halo_para_dir = bis_fnc_halo_para_dir + bis_fnc_halo_para_dirAdd};
			};
		};

		
		bis_fnc_halo_para_loop_time = time - 0.1;
		bis_fnc_halo_para_velZ = velocity _para select 2;
		
		
		bis_fnc_halo_para_loop = 
		{
			if (!isnil {player getvariable "bis_fnc_halo_terminate"}) exitwith {};
			if (time == bis_fnc_halo_para_loop_time) exitwith {}; //--- FPS too high

			_para = vehicle player;

			//--- FPS counter
			_fpsCoef = ((time - bis_fnc_halo_para_loop_time) * 20) / acctime; //Script is optimized for 20 FPS
			bis_fnc_halo_para_loop_time = time;

			//_fpsCoef = _fpsCoef / 3;
			bis_fnc_halo_para_velLimit = 0.3 * _fpsCoef;
			bis_fnc_halo_para_velAdd = 0.002 * _fpsCoef;
			bis_fnc_halo_para_dirLimit = 1.5 * _fpsCoef;
			bis_fnc_halo_para_dirAdd = 0.03 * _fpsCoef;

			//--- Dir
			bis_fnc_halo_para_dir = bis_fnc_halo_para_dir * 0.98;
			bis_fnc_halo_para_dirAbs = bis_fnc_halo_para_dirAbs + bis_fnc_halo_para_dir;
			_para setdir bis_fnc_halo_para_dirAbs;
			_dir = direction _para;

			//--- Crash
			_velZ = velocity _para select 2;
			if ((_velZ - bis_fnc_halo_para_velZ) > 7 && (getposatl _para select 2) < 100) then {player setdamage 1;debuglog ["Log::::::::::::::",(_velZ - bis_fnc_halo_para_velZ)];};
			bis_fnc_halo_para_velZ = _velZ;

			//--- Pos
			_para setposasl [
				(getposasl _para select 0) + (sin _dir * (0.1 + bis_fnc_halo_para_vel)),
				(getposasl _para select 1) + (cos _dir * (0.1 + bis_fnc_halo_para_vel)),
				(getposasl _para select 2) - 0.01 - 0.1 * abs bis_fnc_halo_para_vel
				];
			// --- Vector
			[
				_para,
				(-bis_fnc_halo_para_vel * 75) + 0.5*(sin (time * 180)),
				(+bis_fnc_halo_para_dir * 25) + 0.5*(cos (time * 180))
			] call bis_fnc_setpitchbank;
		};

		// this is used as a workaround to a while loop. the displayevent handler can fire faster than the lowest loop time in a  while loop.
		bis_fnc_halo_para_mousemoving_eh = (finddisplay 46) displayaddeventhandler ["mousemoving","_this call bis_fnc_halo_para_loop;"];
		bis_fnc_halo_para_mouseholding_eh = (finddisplay 46) displayaddeventhandler ["mouseholding","_this call bis_fnc_halo_para_loop;"];

		sleep 4;
		ppeffectdestroy bis_fnc_halo_DynamicBlur;
		bis_fnc_halo_para_keydown_eh = (finddisplay 46) displayaddeventhandler ["keydown","_this call bis_fnc_halo_para_keydown;"];

		//--- End
		//waituntil {vehicle player == player};
		player setvariable ["bis_fnc_halo_terminate",nil];
		waituntil {(position vehicle player select 2) < 0.4 || !isnil {player getvariable "bis_fnc_halo_terminate"}};
		
		// Play a animation on landing. random,
		player action["eject", vehicle player];
		if (!(surfaceIsWater  (getpos player))) then 
		{
			switch (round(random 1)) do 
			{
				case 0: {player playmovenow "ActsPercMrunSlowWrflDf_TumbleOver";};
				case 1: {player playmovenow "ActsPercMrunSlowWrflDf_FlipFlopPara";};
			};
		};

		// Remove the display event handlers.
		(finddisplay 46) displayremoveeventhandler ["keydown",bis_fnc_halo_para_keydown_eh];
		(finddisplay 46) displayremoveeventhandler ["mousemoving",bis_fnc_halo_para_mousemoving_eh];
		(finddisplay 46) displayremoveeventhandler ["mouseholding",bis_fnc_halo_para_mouseholding_eh];

		bis_fnc_halo_para_vel = nil;
		bis_fnc_halo_para_velLimit = nil;
		bis_fnc_halo_para_velAdd = nil;
		bis_fnc_halo_para_dir = nil;
		bis_fnc_halo_para_dirLimit = nil;
		bis_fnc_halo_para_dirAdd = nil;
		bis_fnc_halo_para_keydown = nil;
		bis_fnc_halo_para_loop = nil;
		bis_fnc_halo_para_keydown_eh = nil;
		bis_fnc_halo_para_mousemoving_eh = nil;
		bis_fnc_halo_para_mouseholding_eh = nil;
	};
};
Halo_Jump =
{

	[] spawn Halo_Remove_Marker_LZ;
	
	if ((secondaryWeapon player) != "") exitwith {hint format ["You have to much gear\nRemove %1",secondaryWeapon player];	closedialog 0;};
	
	_cash = [] call Func_Client_GetPlayerFunds;
	_halocost = 400;

	_pos = getMarkerpos format["%1_Halo",name player];
	if ((((_pos select 0) == -10000) and ((_pos select 1) == -10000))  or (((_pos select 0) == 0) and ((_pos select 1) == 0)))then
	{
		hint "Select a LZ on the map";
	}else{
	
		if (_cash < _halocost) then
		{
			hint format["You can not afford to Halo\nMissing %1",_halocost - _cash];
			
		}else{
			
			closedialog 0; // this will also remove the marker..
			-400 call Func_Client_ChangePlayerFunds; // change the funds. halo is not free
			
			titleText ["Get Ready", "BLACK OUT",2];
			sleep 2.2;
			player setpos [_pos select 0,_pos select 1, 2000];
			titleText ["Fly", "BLACK IN",3];

			player spawn Halo_FreeFall;
			//[player, 2000] exec "ca\air2\halo\data\Scripts\HALO_init.sqs";
		};
	};

};

