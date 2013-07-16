	//shows copyrights when mission starts
	//see client`s precompile.sqf

	disableSerialization;
	
	_Control=(_this select 0)displayCtrl 1641;
	_Control ctrlSetPosition [safeZoneX,SafeZoneH+SafeZoneY-.044];
	
	_cnt=(count Local_MapInfoStrings)-1;
	for [{_i=0},{_i<=_cnt},{_i=_i+1}] do
	{
		_Control ctrlSetStructuredText parseText(Local_MapInfoStrings select _i);	
		_Control ctrlCommit 0;
		sleep 5;
	};
	
	