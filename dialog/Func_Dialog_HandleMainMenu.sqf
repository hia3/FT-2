/**/
Dialog_MenuAction = -1;
_exited = false;

while {alive player && dialog} do
{
	//--- Build Units.
	_enable = false;
	if (((({((player distance _x) <= Config_SupplyVehicleRange) && (alive _x)} count nearestobjects [player,Local_FriendlySupplyVehicleTypes,Config_SupplyVehicleRange]) > 0) || ((player distance Local_FriendlyBaseFlag)<Config_RespawnSize)) && (Local_PlayerVehicle==player)) then
	{
		ctrlEnable [11001,true];
	}else{
		ctrlEnable [11001,false];
	};
	if (((player distance Local_FriendlyBaseFlag)<Config_RespawnSize) && (Local_PlayerVehicle==player)) then
	{
		ctrlEnable [11002,true];
	}else{
		ctrlEnable [11002,false];
	};

	ctrlEnable [11008, player getVariable ["joied_ts", true]];

	sleep 0.5;

	if (!dialog || _exited) exitWith {};


	switch(Dialog_MenuAction) do {

		//--- Gear Menu.
		case 1 :
		{
			Dialog_MenuAction = -1;
			closeDialog 0;
			createDialog "RscGear";
			_exited = true;
		};

		//--- Vehicles Menu.
		case 2 :
		{
			Dialog_MenuAction = -1;
			closeDialog 0;
			createDialog "RscVehicles";
			_exited = true;
		};

		//--- Groups Menu.
		case 3 :
		{
			Dialog_MenuAction = -1;
			closeDialog 0;
			createDialog "RscGroups";
			_exited = true;
		};

		//--- Options Menu.
		case 4 :
		{
			Dialog_MenuAction = -1;
			closeDialog 0;
			createDialog "RscOptions";
			_exited = true;
		};

		//--- Help Menu.
		case 5:
		{
			Dialog_MenuAction = -1;
			closeDialog 0;
			createDialog "RscHelp";
			_exited = true;
		};

		//--- Game parameters.
		case 6:
		{
			Dialog_MenuAction = -1;
			closeDialog 0;
			createDialog "RscParameters";
			_exited = true;
		};

		//--- Change map.
		case 7:
		{
			Dialog_MenuAction = -1;
			closeDialog 0;
			player setVariable ["change_map", true, true];
			Local_ChangeMap = true;
			player globalChat "Voted for map change";
			_exited = true;
		};
	};
};