	//user action: Field Repair
	//see Func_Client_UpdateUserActions

	private["_veh","_name"];

	_veh=_this;
	//get number of repair kits remaining
	_pack=_veh getVariable "rpair_kits";

	//duration of one field-repair operation
	_fieldrepairtime=20;

	//if vehicle is not handled by any script before, consider it is new
	//and set a full amount of repair packs inside
	if (isNil "_pack") then
	{
		_pack=Config_RepairKitsDefault;
		_veh setVariable ["rpair_kits",_pack,true];
	};

	//check, if vehicle is not being
	//field repaired at the moment
	_time=_veh getVariable ["fieldrepair", 0];
	_name=getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "DisplayName");



	//if vehicle has repair packs
	//perform repair process
	if (_pack>0) then
	{
		//if there are crew inside - cancel repair
		//just because i want so :)
		//if vehicle is already being field repaired - cancel repair
		//because some persons at one time can spend all of the repair kits
		//though it will give poor result anyway
		if (({alive _x} count crew _veh) > 0) exitWith {[_name,localize "STR_HINT_FieldCrew","pic\i_repair_f.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;_veh setVariable ["fieldrepair",0,true];};
		if ((time-_time)<_fieldrepairtime) exitWith {[_name,localize "STR_HINT_FieldAllready","pic\i_repair_f.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage};

		if (!(isNull _veh)) then
		{
			//show start hint
			[_name,localize "STR_HINT_FieldStarted","pic\i_repair_s.paa",1.0] call Func_Client_ShowCustomMessage;
			//mark the vehicle is under field repair
			_veh setVariable ["fieldrepair",time,true];
			//mark player is engaged in technical service
			//see Func_Client_UpdateVehicleActions
			Local_TechnicalService=true;
			_i=0;
			while {(alive player) && (alive _veh) && (({alive _x} count crew _veh)==0) && (_i<_fieldrepairtime)} do
			{
				//make player play animation
				player playMove "AinvPknlMstpSlayWrflDnon_medic";
				sleep 1;
				if ((alive player) && (alive _veh) && (({alive _x} count crew _veh)==0)) then
				{
					_i=_i+1;
				};
			};

			if (_i<_fieldrepairtime) exitWith
			{
				//if i<_fieldrepairtime that means player is dead / _veh is dead / some crew got into veh
				[_name,localize "STR_HINT_FieldFailed","pic\i_repair_f.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
				Local_TechnicalService=false;
				_veh setVariable ["fieldrepair",0,true];
			};
			//reduce number of repair packs remaining
			_pack=_veh getVariable "rpair_kits";
			_pack=_pack-1;
			//show finish message
			[_name,format[localize "STR_HINT_FieldComplete",_pack],"pic\i_repair_s.paa",1.0] call Func_Client_ShowCustomMessage;
			_veh setVariable ["rpair_kits",_pack,true];
			//repair the vehicle
			_dam=(getDammage _veh)-0.15;


			_veh setDammage 0;

			//helicopters often loose fuel
			//restore it, or why did we cary out repairs?
			if ((_veh isKindOf "Air") && (_dam>0.20)) then
			{
				_dam=0.20;
				_veh setFuel (fuel _veh)+0.4;
			};
			_veh setDammage _dam;

			//mark player is not engaged in technical service
			//see Func_Client_UpdateVehicleActions
			Local_TechnicalService=false;
		};
	}
	else
	{
		//show cancel hint
		[_name,localize "STR_HINT_FieldDenided","pic\i_repair_f.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
	};
