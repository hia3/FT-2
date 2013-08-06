	//user action: reload vehicle ammo at base e.t.c.

	//todo: make turrets full rearm

	_veh=_this;

	_percent=0;

	_name=getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "DisplayName");



	[_name,localize "STR_HINT_ReammoStarted","pic\i_reammo_s.paa",1.0] call Func_Client_ShowCustomMessage;

	//_veh setVehicleAmmo 0.1;

	//disallow any technical services until process is active
	//see Func_Client_UpdateVehicleActions
	Local_TechnicalService=true;

	for [{_i=0},{(_i<20) && (alive _veh) && (_veh==Local_PlayerVehicle) && (abs(speed _veh) < 5) && (alive player)},{_i=_i+1}] do
	{
		sleep 1;
		_percent=_percent+5;
		[_name,format [localize "STR_HINT_ReammoProcess",_percent],"pic\i_reammo_s.paa",1.0] call Func_Client_ShowCustomMessage;
	};

	if (_percent<94) exitWith
	{
		[_name,localize "STR_HINT_ReammoCanceled","pic\i_reammo_f.paa",1.0] call Func_Client_ShowCustomMessage;
		Local_TechnicalService=false;
	};

	if ((count (magazines _veh))==0) then
	{
		_mag=GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Magazines");
		_mag=_mag+GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Turrets" >> "MainTurret" >> "Magazines");
		{_veh removeMagazine _x} ForEach Magazines _veh;
		{_veh addMagazine _x} ForEach _mag;
	};
	_veh setVehicleAmmo 1;

	if (player==(gunner _veh)) then
	{
		[_name,localize "STR_HINT_ReammoCompleteG","pic\i_reammo_s.paa",1.0] call Func_Client_ShowCustomMessage;
	}
	else
	{
		[_name,localize "STR_HINT_ReammoComplete","pic\i_reammo_s.paa",1.0] call Func_Client_ShowCustomMessage;
	};


	[_veh,true] call Func_System_ClearFlaresAndSmokes;


	titleText [localize "STR_HINT_RearmCompleteGunner", "PLAIN DOWN",0.3];

	//allow all the technical services
	//see Func_Client_UpdateVehicleActions
	Local_TechnicalService=false;
