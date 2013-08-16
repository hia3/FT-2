	//main client thread

	while {!Global_GameEnded} do
	{
		_current_players = [];
		_current_players_ts = [];
		{
			if ((side _x) == Local_PlayerSide) then
			{
				_current_players set [count _current_players, _x];
				if (_x getVariable ["joied_ts", false]) then
				{
					_current_players_ts set [count _current_players_ts, _x];
				};
			};
		} forEach playableUnits;
		Local_CurrentPlayers    = _current_players;//update the list of current players
		Local_CurrentPlayersTS  = _current_players_ts;

		[] call Func_Client_MarkMHQ;//mark MHQ on the map
		[] call Func_Client_MarkFriendlyPlayers;//mark players on the map
		[] call Func_Client_MarkFriendlyVehicles;//mark friendly vehicles
		[] call Func_Client_AproachingRespawnArea;//check aproaching respawn area
		if (Local_GUIActive && !Local_GUIWorking && (isNull Local_Camera) && !(visibleMap)) then {Local_GUIWorking=true; 1365 cutRsc ["RscOverlay","PLAIN",0]};//if GUI is not working, but it should - restart it

		[] call Func_Client_AddIncome;//add periodic income
		[] call Func_Client_SetAllowDamage;//allowDamage false; for enemies inside respawn zone

		if ((Param_RoundDuration < time) && (serverCommandAvailable "#kick") && ((time - Local_PlayerLastActivityTime) < 10)) then {Global_GameEnded=true; "Global_GameEnded" call Func_Common_PublicVariable; };//if round time is passed - end the round
		sleep 0.5;
	};

	//run map outro
	[] call Func_Client_MapOutro;
