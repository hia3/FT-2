
/***************************************************************************
FT2
****************************************************************************/
enableEngineArtillery false;

call compile preprocessfile "config.sqf";

call compile preprocessfile "common\precompile.sqf";

if(isServer)then
{
	call compile preprocessfile "subsystems\precompile.sqf";
	call compile preprocessfile "server\precompile.sqf";	
};

if(!isServer || local player)then
{	
	cutRsc ["BackBlack","plain"];
	
	sleep 0.1;
	
	waitUntil{player==player};
	waitUntil{alive player};
	waitUntil{local player};
	
	call compile preprocessfile "dialog\precompile.sqf";	
	call compile preprocessfile "client\precompile.sqf"; 	
	call compile preprocessfile "subsystems\precompile.sqf";
};

//used only for retexturing system
//see Func_Client_CreateCustomVehicle && Func_Server_RespawnVehicle
WorkAround_InitScriptDone=1;
/***************************************************************************
END
****************************************************************************/


/***************************************************************************
INIT SCRIPTS: SERVER
****************************************************************************/
if ((isServer)) then {

	waitUntil {time > 0};	
};
/***************************************************************************
END
****************************************************************************/



/***************************************************************************
INIT: CLIENT
****************************************************************************/	
if ((!isDedicated)) then {

	waitUntil {(!(isNull player))};

	enableSaving [false, false];
	enableSentences true;
	player enableAttack false;	
};
/***************************************************************************
END
****************************************************************************/