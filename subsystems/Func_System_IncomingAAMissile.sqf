	/**/
	_air=_this select 0;
	_ammotype=_this select 1;
	_antiair=_this select 2;
	_aawarning=_this select 3;
	
	_ammo=nearestObject [_antiair,_ammotype];
	_activatedist=300;

	if (!((side _air) in [east,west])) exitWith {};
	
//	if (local _ammo) then
	if (true) then
	{		
		//--send _air crew a warning message
		Public_AircraftAttacked=_air; 
		publicVariable 'Public_AircraftAttacked';
		//--end

		if (!_aawarning) exitWith {};
		
		//--find missile class and some missile data
		_chance=1;
		_index=-1;
		_i=0;
		{
			if (_antiair isKindOf (_x select 0)) exitWith 
			{	
				_index=_i;
			};
			_i=_i+1;
		} forEach System_AntiAirVehicleTypes;

		_allowhit=System_AntiAirMissileChances select (System_AntiAirMissileTypes find _ammotype);
			
		if (_index >=0) then
		{
			_chance=(System_AntiAirVehicleTypes select _index) select 1;
		};
		//--end

		_dist=_ammo distance _air;
		_mindist=300;	
			
		waitUntil{((_ammo distance _air)<=_activatedist) || (isNull _ammo)};	
		if (isNull _ammo) exitWith {};
		
		_flares=_air getVariable "flaresleft";
		if (_flares > 0) then
		{
			_air setVariable ["flaresleft",_flares-1,true];
			
			if (_dist>_mindist) then
			{
				if (((random 1)>_chance) || (!_allowhit)) then
				{
					deleteVehicle _ammo;												
				};							
			};
		};			
	};
		
	if (!_aawarning) exitWith {};
	
	waitUntil{((_ammo distance _air)<=_activatedist) || (isNull _ammo)};
	if (isNull _ammo) exitWith {};

	// if the player has set the countermesure system on manual we dont want to drop flares now.. 
	// we run the code above this because it chenges ballistics..
	
	if (_air getVariable 'manualflare_off') exitwith {};
	
	_flares=(_air getVariable "flaresleft");	
	if (_flares > 0) then
	{
		_air call Func_System_DropFlares;
	};