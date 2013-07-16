//private["_dialog"];	
if ((Dialog_RespawnState=="idle") && (alive player) && !Global_GameEnded) then
{		
	titleText [localize "STR_DLG_Esc","plain"];
	sleep 1.0;
	createDialog "RscRespawnMenu";
};