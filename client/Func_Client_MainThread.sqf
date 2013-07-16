	//main client thread

	while {!Global_GameEnded} do
	{
		Local_CurrentPlayers=[] call Local_FriendlyPlayers;//update the list of current players
		
		[] call Func_Client_MarkMHQ;//mark MHQ on the map
		[] call Func_Client_MarkFriendlyPlayers;//mark players on the map
		[] call Func_Client_MarkFriendlyVehicles;//mark friendly vehicles
		[] call Func_Client_AproachingRespawnArea;//check aproaching respawn area
		if (Local_GUIActive && !Local_GUIWorking && (isNull Local_Camera) && !(visibleMap)) then {Local_GUIWorking=true; 1365 cutRsc ["RscOverlay","PLAIN",0]};//if GUI is not working, but it should - restart it

		[] call Func_Client_ReadRemoteMessages;//read remote messages
		[] call Func_Client_AddIncome;//add periodic income
		[] call Func_Client_SetAllowDamage;//allowDamage false; for enemies inside respawn zone	
		
		
		if (Param_RoundDuration < time) then {Global_GameEnded=true; publicVariable "Global_GameEnded"};//if round time is passed - end the round		
		sleep 0.5;
	};
	
	//run map outro
	[] call Func_Client_MapOutro;
	