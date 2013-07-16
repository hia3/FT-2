private["_player","_playerWasDead","_position","_MarkerBasePos"];

if ((time-Local_LastDeathTime) < 5) exitWith {};

Local_LastDeathTime=time;
	
_player=_this select 0;

Local_PlayerBody=_player;//variable for revive system - stores last player body which can be used for revive
_playerWasDead=false;

_killedByEnemy=false;
	
//variable duplicates in Func_Dialog_HandleRespawnDialog
//here we need it here for Func_Client_CreateRotatingCamera
Dialog_RespawnState="idle";

showCinemaBorder false;
if (isNull Local_Camera) then
{
	Local_Camera="camera" camCreate [0,0,0];
	Local_Camera cameraEffect ["internal","back"];
};

_teamspeak_timing=[0,0];
if (Dialog_RespawnDeathTime==0) then
{		
	//Dialog_RespawnDeathTime!=0 means player just entered the game and  
	//it is not necessary to delete his body or to launch spectating camera
	_playerWasDead=true;		
	_teamspeak_timing=player getVariable "ts_message_timing";
	Dialog_RespawnDeathTime=time;
	_this call Func_Common_DestroyUnitAward;
	[] call Func_Client_CreateRespawnCamera;
	
	//obtain data for possible reviver awarding
	if ((side (_this select 1))==Local_EnemySide) then
	{
		_killedByEnemy=true;
	};
		
	//mark player dead body
	Public_DeadUnit=[_player,true];
	publicVariable "Public_DeadUnit";		
};

//close all the dialogs
while {dialog} do
{
	closeDialog 0;
};
	
waitUntil{(alive player)};

if (Global_GameEnded) exitWith{};

//reset variables related to human damage indicator in gui
Dialog_LegsHit=false;
Dialog_HandsHit=false;
Dialog_BodyHit=false;
Dialog_HeadHit=false;

//setpos player to spawn position 
//and make him to salute
player setPosATL Local_SpawnPos; // TODO: why setPosASL?
player setDir Local_SpawnDir;

//player playMove "AmovPercMstpSnonWnonDnon_SaluteIn";

//sometimes we need to know player name on remote clients
//we could use function "name", but it shows errors in *.rpt file
//if it is applied to a dead unit
player setVariable ["playername",Local_PlayerName,true];
player setVariable ["kill_award",Config_AwardKillPlayerValue,true];//award for unit who kill player
player setVariable ["ft2_wf_side",Local_PlayerSide,true];//side player..
player setVariable ["enemytrack",-Config_EnemyTrackTime,true];//if player attacked safezone or aproached it.. we mark him on the map. this var is timer
player setVariable ["groupNumber",Local_PlayerGroupNumber,true];//number of player group
player setVariable ["groupPassword",Local_PlayerGroupPassword,true];//password of player group
player setVariable ["deafness",0];//deafness effect. e.g. after tank or rpg shot			
player setVariable ["joied_ts",true];//if player is in TS
player setVariable ["ts_message_timing",_teamspeak_timing];//timer to show TS message
Local_PlayerVehicle=player;

//add some useractions to player
[] call Func_Client_UpdateUserActions;
	
[[position player select 0,position player select 1,4],(getDir player)-30,2,16,8] spawn Func_Client_CreateRotatingCamera;		
	
//give player his default loadout and subtract its cost from player's funds

_defaultCost=Local_RscGear_SavedInventory call Func_Client_GetInventoryCost;

[player, Local_RscGear_SavedInventory] call Func_Client_EquipLoadout;
-(_defaultCost) call Func_Client_ChangePlayerFunds;

FT2_WF_Logic setVariable ["currentCost", _defaultCost];
	
//if player has too little money, less then Config_MinimumFunds
//we adjust money value to  Config_MinimumFunds
_funds=[] call Func_Client_GetPlayerFunds;
if ((_funds+_defaultCost) < Config_MinimumFunds) then
{
	(Config_MinimumFunds-_funds-_defaultCost) call Func_Client_ChangePlayerFunds;
};
	
sleep 1.5;

"dynamicBlur" ppEffectEnable true; 
"dynamicBlur" ppEffectAdjust [1.4]; 
"dynamicBlur" ppEffectCommit 0.3;

createDialog "RscRespawnMenu";

//player pressed "respawn" button
waitUntil{(Dialog_RespawnState=="readytospawn") || (Dialog_RespawnState=="revived") || !(alive player)};

1 setFog Local_OriginalFog;
"dynamicBlur" ppEffectAdjust [0]; 
"dynamicBlur" ppEffectCommit 0.3;

//reset death flag
Dialog_RespawnDeathTime=0;

//player was not killed during respawn dialog
if (alive player) then
{	
	//close all the dialogs
	while {dialog} do
	{
		closeDialog 0;
	};	

	titleCut["","black out",1.0];

	if (Dialog_RespawnState=="readytospawn") then
	{
		//player pressed "respawn" button
		if (Dialog_RespawnCurrentPoint>0) then
		{
			//player decided to spawn not at base
			//so we have to calculate position in some range
			//of spawn point and place player there
			_MarkerBasePos=getMarkerPos ((Local_FriendlySpawnPoints select Dialog_RespawnCurrentPoint) select 0);
			_position=[_MarkerBasePos select 0,_MarkerBasePos select 1,(Local_FriendlySpawnPoints select Dialog_RespawnCurrentPoint) select 2] call Func_Client_CalculateSpawnPos;
			player setPos _position;
			player setDir (random 360);
		};
//		player playMove "aidlpercmstpsraswrfldnon_idlesteady01n";
	}else{
		//player was revived
		player setPosATL getPosATL _player;
		player setDir getDir _player;
		
		/*_defaultCost call Func_Client_ChangePlayerFunds;

		_dead_body_inventory = _player getVariable 'current_weapons';
		if !(isNil '_dead_body_inventory') then
		{
			[player, _dead_body_inventory] call Func_Client_EquipLoadout;
		};*/

		//award reviver, if player was killed by enemy
		if (_killedByEnemy) then
		{				
			_fundsname=format["FT2_WF_Funds_%1",Local_ReviverUnit getVariable "playername"];
			_funds = FT2_WF_Logic getVariable _fundsname;
			_award=Config_AwardKillPlayerValue*3;
			FT2_WF_Logic setVariable [_fundsname,_funds+_award,true];
			Local_ReviverUnit setVariable ["message_revivedteammate",_award,true];
		};
		player playMove "amovppnemstpsraswrfldnon";
	};
	player selectWeapon (primaryWeapon player);
};
		
sleep 1.0;

//player was not killed during respawn dialog
if (alive player) then
{	
	//reset count of shots, done at base
	Local_ShotsDoneAtBase=0;
		
	player cameraEffect ["terminate","back"];
	camDestroy Local_Camera;
		
	titleCut["","black in",1.0];
};

if (_playerWasDead) then
{
	//we don`t want old player`s body to stay for a long time, or there will be a lot of dead bodies
	//if there are 10 players on map, it is ok.. but if there are 120? how many bodies shall we have on map?
	//so delete dead immediately
	removeAllWeapons _player;
	removeAllItems _player;
	removeBackPack _player;
	
	hideBody _player;
	deleteVehicle _player;
		
	//don`t want to allow players to mine all the map, so delete all their placed mines after death
	// better yet, delete only attached mines so there will be explosion
	{
		private ["_mine", "_is_attached"];
		
		_mine = _x;

		_is_attached = _mine in Local_PlayerAttachedMines;
		
		if (_is_attached) then
		{
			deleteVehicle _x;
		};
	} forEach Local_PlayerMines;
		
	//remove player body marker
	Public_DeadUnit=[player,false];
	publicVariable "Public_DeadUnit";
};

2 fadeMusic 0;
"colorCorrections" ppEffectEnable false;
"dynamicBlur" ppEffectEnable false; 
enableEnvironment true;
