//script activates when player aproaches enemy respawn area

private["_Limit","_safeLimit","_fireLimit"];
	
_Limit=Config_RespawnRestrictedZone;
_safeLimit=Config_RespawnSafeZone-Config_RespawnBuferZone;
_fireLimit=Config_RespawnSafeZone;
	
if (Local_PlayerVehicle isKindOf "Air") then
{
	_Limit=_Limit+250;	
	_fireLimit=_fireLimit+100;
};
	
//safezone indication datas
_fpos=getPosASL Local_FriendlyBaseFlag;		
_pos=getPosASL Local_PlayerVehicle;	
if ((_pos distance _fpos) < _safeLimit) then
{
	Local_PlayerInSafeZone=2;			
}else{
	_pos set [2,0];
	_fpos set [2,0];
	if ((_pos distance _fpos) < _fireLimit) then
	{
		Local_PlayerInSafeZone=1;
	}else{
		Local_PlayerInSafeZone=0;
	};
};
	
//if player aproached enemy respawn
//then routine is launched every 4 seconds
if ( ((Local_PlayerVehicle distance Local_EnemyBaseFlag) < _Limit) && ((time-Local_LastWarningTimeAproach) >4 )) then
{		
	//show warning hint
	[localize "STR_HINT_Warning",localize "STR_HINT_RestrictedArea","pic\no.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
	//mark player on enemies`s maps
	player setVariable ["enemytrack",time+Config_EnemyTrackTime,true];
	//tell all the clients about new unti to track
	//see Func_Client_TrackEnemy & client`s precompile.sqf
	Public_EnemyTracked=player;
	"Public_EnemyTracked" call Func_Common_PublicVariable;
	//reduce view distance 
	Local_LastWarningTimeAproach=time;
	Local_EnteredEnemySafeZone=true;
	
	// this is utter bullshit. why would someone suddenly become blind because hes too close to enemy.. 
	// warning is more than enough.
	//setViewDistance 1000;
};	

if ((Local_EnteredEnemySafeZone) && ((Local_PlayerVehicle distance Local_EnemyBaseFlag)>_Limit)) then
{
	//player moved out of safe zone
	//normalize view distance
	Local_EnteredEnemySafeZone=false;
	//setViewDistance Local_ViewDistance;
};
	