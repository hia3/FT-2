	//user action: technical service of a vehicle



	_veh=_this;

	_name=getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "DisplayName");



	[_name,localize "STR_HINT_RepairStarted","pic\i_repair_s.paa",1.0] call Func_Client_ShowCustomMessage;

	sleep 1;

	//disallow any technical services until process is active
	//see Func_Client_UpdateVehicleActions
	Local_TechnicalService=true;

	for [{_i=0},{(_i<=20) && (damage _veh>0.04) && (alive _veh) && (_veh==Local_PlayerVehicle) && (abs(speed _veh) < 5) && (alive player)},{_i=_i+1}] do
	{	
		_dam=((damage _veh)-0.05) max 0;
		_veh setDamage _dam;	
		[_name,format [localize "STR_HINT_RepairProcess",round(100-_dam*100)],"pic\i_repair_s.paa",1.0] call Func_Client_ShowCustomMessage;
		sleep 1;
	};

	sleep 0.5;

	if (damage _veh<=0.04) then
	{
		_veh setVariable ["rpair_kits",Config_RepairKitsDefault,true];


		_veh setDamage 0;


		_str=localize "STR_HINT_RepairComplete";
		_param=0;
		//if ((typeOf _veh) in System_ArmoredVehicleTypes) then {_str=_str+localize "STR_HINT_RepairShells";_param=System_ArmoredVehicleCM select (System_ArmoredVehicleTypes find (typeOf _veh))};
		//if ((typeOf _veh) in System_AircraftVehicleTypes) then {_str=_str+localize "STR_HINT_RepairFlares";_param=System_AircraftVehicleCM select (System_AircraftVehicleTypes find (typeOf _veh))};
		[_name,format[_str,Config_RepairKitsDefault,_param],"pic\i_repair_s.paa",1.0] call Func_Client_ShowCustomMessage;
		
		//[_veh,true] call Func_System_ClearFlaresAndSmokes;
	}
	else
	{
		[_name,localize "STR_HINT_RepairCanceled","pic\i_repair_f.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
	};

	//allow all the technical services
	//see Func_Client_UpdateVehicleActions
	Local_TechnicalService=false;

