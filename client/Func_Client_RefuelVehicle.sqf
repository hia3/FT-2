	//user action: refuel of a vehicle

	

	_veh=_this;

	_name=getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "DisplayName");



	[_name,localize "STR_HINT_RefuelStarted","pic\i_refuel_s.paa",1.0] call Func_Client_ShowCustomMessage;

	sleep 1;

	//check if vehicle has its ignition off and switch it back
	if (_veh getVariable "ignition_off") then
	{
		_veh setVariable ["ignition_off",false,true];
		_veh setFuel (Local_PlayerVehicle getVariable "ignite_fuel");
	};

	//disallow any technical services until process is active
	//see Func_Client_UpdateVehicleActions
	Local_TechnicalService=true;

	for [{_i=0},{(_i<=20) && (fuel _veh<0.96) && (alive _veh) && (_veh==Local_PlayerVehicle) && (abs(speed _veh) < 5) && (alive player)},{_i=_i+1}] do
	{	
		_fuel=((fuel _veh)+0.05) min 1;
		_veh setFuel _fuel;	
		[_name,format [localize "STR_HINT_RefuelProcess",round(_fuel*100)],"pic\i_refuel_s.paa",1.0] call Func_Client_ShowCustomMessage;
		sleep 1;
	};

	sleep 0.5;

	if (fuel _veh>=0.96) then
	{
		_veh setFuel 1;		

		[_name,localize "STR_HINT_RefuelComplete","pic\i_refuel_s.paa",1.0] call Func_Client_ShowCustomMessage;
	}
	else
	{
		[_name,localize "STR_HINT_RefuelCanceled","pic\i_refuel_f.paa",1.0] call Func_Client_ShowCustomMessage;
	};

	//allow all the technical services
	//see Func_Client_UpdateVehicleActions
	Local_TechnicalService=false;
