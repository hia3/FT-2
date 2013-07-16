	deleteVehicle _this;
	
	_unit = player;
	
	_unit setVehicleInit "this switchMove 'HaloFreeFall_non'";
	processInitCommands;
	
	_unit setDir (getDir _unit);
		
	_times=["5","4","3","2","1"];
	for [{_i=0}, {_i<5}, {_i=_i+1}] do
	{
		hintSilent composeText [parseText format ["<t align='left' size='%4'><img image='%3'></t>"+"<t align='center' size='1.25' shadow='true'>%1</t><t align='right' size='%4'><img image='%3'></t>" +"<br/>" +"<t align='center' size='1.5' shadow='true'>%2</t>",localize "STR_HINT_ParaOpen",_times select _i,"\ca\air\data\ico\Para_CA.paa",1.0]];
		sleep 0.2;
	};
	
	hintSilent "";
	
	_unit setVehicleInit "this switchMove ''";
	processInitCommands;
	
	if (!alive _unit) exitWith{};

	_para = "ParachuteC" createVehicle position _unit;	
	_para setpos position _unit;
	_para setdir direction _unit;
	_vel = velocity _unit;
	_unit moveindriver _para;

	_para lock false;

	bis_fnc_halo_para_dirAbs = direction _para;

	if (_unit == player) then 
	{
		_para setvelocity [(_vel select 0),(_vel select 1),(_vel select 2)*1];

		bis_fnc_halo_para_vel = 0;
		bis_fnc_halo_para_velLimit = 0.5;
		bis_fnc_halo_para_velAdd = 0.01;
		bis_fnc_halo_para_dir = 0;
		bis_fnc_halo_para_dirLimit = 1.5;
		bis_fnc_halo_para_dirAdd = 0.03;

		bis_fnc_halo_para_keydown = 
		{
			_key = _this select 1;

			if (_key in (actionkeys 'MoveForward')) then {
				if (bis_fnc_halo_para_vel < +bis_fnc_halo_para_velLimit) then {bis_fnc_halo_para_vel = bis_fnc_halo_para_vel + bis_fnc_halo_para_velAdd};
			};

			if (_key in (actionkeys 'MoveBack')) then {
				if (bis_fnc_halo_para_vel > 0) then {bis_fnc_halo_para_vel = bis_fnc_halo_para_vel - bis_fnc_halo_para_velAdd};
			};
		
			if (_key in (actionkeys 'TurnLeft')) then {
				if (bis_fnc_halo_para_dir > -bis_fnc_halo_para_dirLimit) then {bis_fnc_halo_para_dir = bis_fnc_halo_para_dir - bis_fnc_halo_para_dirAdd};
			};

			if (_key in (actionkeys 'TurnRight')) then {
				if (bis_fnc_halo_para_dir < +bis_fnc_halo_para_dirLimit) then {bis_fnc_halo_para_dir = bis_fnc_halo_para_dir + bis_fnc_halo_para_dirAdd};
			};
		};
		bis_fnc_halo_para_loop_time = time - 0.1;
		bis_fnc_halo_para_velZ = velocity _para select 2;
		bis_fnc_halo_para_loop = 
		{
				if (time == bis_fnc_halo_para_loop_time) exitwith {};

				_para = vehicle player;

				_fpsCoef = ((time - bis_fnc_halo_para_loop_time) * 20) / acctime;
				bis_fnc_halo_para_loop_time = time;

				bis_fnc_halo_para_velLimit = 0.3 * _fpsCoef;
				bis_fnc_halo_para_velAdd = 0.002 * _fpsCoef;
				bis_fnc_halo_para_dirLimit = 1.5 * _fpsCoef;
				bis_fnc_halo_para_dirAdd = 0.03 * _fpsCoef;

				bis_fnc_halo_para_dir = bis_fnc_halo_para_dir * 0.98;
				bis_fnc_halo_para_dirAbs = bis_fnc_halo_para_dirAbs + bis_fnc_halo_para_dir;
				_para setdir bis_fnc_halo_para_dirAbs;
				_dir = direction _para;

				_velZ = velocity _para select 2;
				if ((_velZ - bis_fnc_halo_para_velZ) > 7 && (getposatl _para select 2) < 100) then {player setdamage 1;debuglog ["Log::::::::::::::",(_velZ - bis_fnc_halo_para_velZ)];};
				bis_fnc_halo_para_velZ = _velZ;

				_para setposasl [
					(getposasl _para select 0) + (sin _dir * (0.1 + bis_fnc_halo_para_vel)),
					(getposasl _para select 1) + (cos _dir * (0.1 + bis_fnc_halo_para_vel)),
					(getposasl _para select 2) - 0.01 - 0.1 * abs bis_fnc_halo_para_vel
				];

				[
					_para,
					(-bis_fnc_halo_para_vel * 75) + 0.5*(sin (time * 180)),
					(+bis_fnc_halo_para_dir * 25) + 0.5*(cos (time * 180))
				] call Func_System_SetPitchBank;
		};

		bis_fnc_halo_para_mousemoving_eh = (finddisplay 46) displayaddeventhandler ["mousemoving","_this call bis_fnc_halo_para_loop;"];
		bis_fnc_halo_para_mouseholding_eh = (finddisplay 46) displayaddeventhandler ["mouseholding","_this call bis_fnc_halo_para_loop;"];

		sleep 4;
		
		bis_fnc_halo_para_keydown_eh = (finddisplay 46) displayaddeventhandler ["keydown","_this call bis_fnc_halo_para_keydown;"];
		
		waitUntil{((position vehicle _unit select 2) < 3) || !(alive _unit)};		
		waitUntil{((vehicle _unit)==_unit) || !(alive _unit)};
			
		if (alive _unit) then
		{
			_unit playMove "amovppnemstpsraswrfldnon";
		};
		
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