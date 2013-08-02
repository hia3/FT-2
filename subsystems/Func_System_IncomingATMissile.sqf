	/**/
	_tank=_this select 0;
	_ammotype=_this select 1;
	_antitank=_this select 2;
	_isArmor=_this select 3;

	_ammo=nearestObject [_antitank,_ammotype];
	_activatedist=100;

	if (!((side _tank) in [east,west])) exitWith {};
	if ((_tank distance _antitank) < 120) exitWith {};

	//--if it is AT missile
	_allowhit=System_AntiTankMissileChances select (System_AntiTankMissileTypes find _ammotype);
	//--end

		//don't allow AA missiles to hit
		if (!_allowhit) exitWith
		{
			waitUntil{((_ammo distance _tank)<=_activatedist) || (isNull _ammo)};
			if (!isNull _ammo) then
			{
				_pos=getPos _ammo;
				_ammo setPos [_pos select 0,_pos select 1,0];
				_vel=velocity _ammo;
				_ammo setVelocity[_vel select 0,_vel select 1,-100];
			};
		};
		//--end

		//exit if the target has no AT defense
		if (!_isArmor) exitWith {};

		//--send _tank crew a warning message
		["message_incoming_missile", "tank", crew _tank] call Func_Common_SendRemoteCommand;
		//--end

		//get missile hit chance
		_index=-1;
		_i=0;
		{
			if (_antitank isKindOf (_x select 0)) exitWith
			{
				_index=_i;
			};
			_i=_i+1;
		} forEach System_AntiTankVehicleTypes;
		//--end

		waitUntil{((_tank distance _ammo < 500) || (isNull _ammo))};
		if (isNull _ammo) exitWith {};
		[_tank,0,false,_antitank] call Func_System_LaunchSmokes;

		if (_index >=0) then
		{
			_chance=(System_AntiTankVehicleTypes select _index) select 1;

			waitUntil{((_ammo distance _tank)<=_activatedist) || (isNull _ammo)};
			if (isNull _ammo) exitWith {};

			if (((random 1)>_chance) || (!_allowhit)) then
			{
				_shells=(getPos _tank) nearObjects["SmokeShellVehicle",50];

				if ((count _shells) > 0) then
				{
					if (({(_ammo distance _x) < (_ammo distance _tank)} count _shells)>0) then
					{
						_pos=getPos _ammo;
						_ammo setPos [_pos select 0,_pos select 1,0];
						_vel=velocity _ammo;
						_ammo setVelocity[_vel select 0,_vel select 1,-100];
					};
				};
			};
		};
