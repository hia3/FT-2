#include "Func_Client_CosmeticMarkers.sqf";
#include "Func_Client_Halo.sqf";


//cosmetic rings around base..
// West base
[CreateHollowMarker, ['westbaserings','ColorBlack',4,(markerDir "marker_respawn_west"),(getmarkerpos "marker_respawn_west"),(markerSize "marker_respawn_west"),(markerShape "marker_respawn_west")]] call Func_Common_Spawn;
[CreateHollowMarker, ['westbaserings_inner','ColorBlack',1,(markerDir "respawn_west"),(getmarkerpos "respawn_west"),(markerSize "respawn_west"),(markerShape "marker_respawn_west")]] call Func_Common_Spawn;
// East Base
[CreateHollowMarker, ['eastbaserings','ColorBlack',4,(markerDir "marker_respawn_east"),(getmarkerpos "marker_respawn_east"),(markerSize "marker_respawn_east"),(markerShape "marker_respawn_east")]] call Func_Common_Spawn;
[CreateHollowMarker, ['eastbaserings_inner','ColorBlack',1,(markerDir "respawn_east"),(getmarkerpos "respawn_east"),(markerSize "respawn_east"),(markerShape "respawn_east")]] call Func_Common_Spawn;

// Task Zones
{
	_markername = _x select 3;
	_name = format["%1_Ring",_markername];
	[CreateHollowMarker, [_name,'ColorBlack',1,(markerDir _markername),(getmarkerpos _markername),(markerSize _markername),(markerShape _markername)]] call Func_Common_Spawn;

	// inner capture zones..
	_sones = _x select 4;
	for [{_i=0},{_i<= ((count _sones)-1)},{_i=_i+1}] do
	{
		_markername = _sones select _i;
		_name = format["%1_Ring",_markername];
		[CreateHollowMarker, [_name,'ColorBlack',0.3,(markerDir _markername),(getmarkerpos _markername),(markerSize _markername),(markerShape _markername)]] call Func_Common_Spawn;
	};
} foreach Config_TotalCheckPointData;

Local_Camera=objNull;
Local_GUIActive=true;
Local_GUIWorking=false;
Local_PlayerVehicle=player;
Local_UserVehicles=[];
Local_CurrentPlayers=[];
Local_CurrentPlayersTS=[];
Local_PlayerMines=[];
Local_PlayerAttachedMines=[];
Local_TaskSensors=[];
Local_TrackedShells=0;
Local_LastWarningTimeAproach=0;
Local_LastWarningTimeAttack=0;
Local_PlayerLastActivityTime=time;
Local_EnteredEnemySafeZone=false;
Local_TechnicalService=false;
Local_LastIncomeTime=0;
Local_PlayerGroupNumber=-1;
Local_PlayerGroupPassword="";
Local_MultiUseString=format ["<t align='center' shadow='true' size='1.5'  color='#dddddd'>%1</t>",localize "STR_NAME_BattleOver"];

waitUntil{!(isNil "Public_TeamSpeakInfo")};
if (Public_TeamSpeakInfo == "") then
{
	Local_TS_host="hia3.net";
	Local_TS_port="9987";

	Local_TS_period=600;
	Local_TS_duration=20;
	Local_TS_color="#FF0000";
	Local_TS_size="1.1";

	Local_TS_home="http://hia3.com";
	Local_TS_mail="contact@hia3.com";
}
else
{
	_ts_info=call compile Public_TeamSpeakInfo; // returns [host,port,period,duration,color,size,home,mail]

	Local_TS_host=_ts_info select 0;
	Local_TS_port=_ts_info select 1;

	Local_TS_period=_ts_info select 2;
	Local_TS_duration=_ts_info select 3;
	Local_TS_color=_ts_info select 4;
	Local_TS_size=_ts_info select 5;

	Local_TS_home=_ts_info select 6;
	Local_TS_mail=_ts_info select 7;
};

Local_MapInfoStrings=
[
	"<t align='center' shadow='true' size='2.1' color='#ffffff'>F i g h t   F o r   T h e   T e r r i t o r y   -   L i g h t   L e v e l   M a p</t>",
	" ",
	format ["<t align='center' shadow='true' size='1.5'>Mission engine version: %1</t>",Config_MissionVersion],
	"<t align='center' shadow='true' size='1.5'>Made by WINSE and Roman.Val</t>",
	format ["<t align='center' shadow='true' size='1.5'>Teamspeak3: %1</t>",Local_TS_host],
	format ["<t align='center' shadow='true' size='1.5'>Website: %1</t>",Local_TS_home],
	format ["<t align='center' shadow='true' size='1.5'>Report bugs and other suggestions to: %1</t>",Local_TS_mail],
	"<t align='center' shadow='true' size='1.5'>[Copyright ArmaRUS and Hi,A3 Project, 2013]</t>"
];

Local_RegisteredObjects=[];
Local_MovingStatic=false;
Local_IndirectFireMode=false;
Local_InjuredByEnemy=false;
Local_ReviverUnit=objNull;
Local_PlayerBody=objNull;
Local_HighClimbingModeOn=false;
Local_RadarGuidanceOn=false;
Local_LastDeathTime=0;
Local_PlayerInSafeZone=2;//0-out of safe zone; 1-in bufer zone; 2-in safezone
Local_PlayerIsMedic=false;

Local_TankDrivePos=[];
Local_TankFirePos=[];
Func_Client_AssignDrivePos = { Local_TankDrivePos = _this };
Func_Client_AssignFirePos  = { Local_TankFirePos  = _this };
Local_LaserSpots=[];

Local_KeyPressedForward = false;

Local_LogInfoStrings = [];

Func_Client_AddIncome=compile preprocessFile ("client\Func_Client_AddIncome.sqf");
Func_Client_AddLockActions=compile preprocessFile ("client\Func_Client_AddLockActions.sqf");
Func_Client_AproachingRespawnArea=compile preprocessFile ("client\Func_Client_AproachingRespawnArea.sqf");
Func_Client_CalculateSpawnPos=compile preprocessFile ("client\Func_Client_CalculateSpawnPos.sqf");
Func_Client_ChangePlayerFunds=compile preprocessFile ("client\Func_Client_ChangePlayerFunds.sqf");
Func_Client_CheckPointCaptured=compile preprocessFile ("client\Func_Client_CheckPointCaptured.sqf");
Func_Client_CommanderSendPosition=compile preprocessFile ("client\Func_Client_CommanderSendPosition.sqf");
Func_Client_CompileScoreStatistics=compile preprocessFile ("client\Func_Client_CompileScoreStatistics.sqf");
Func_Client_ConvertToArray=compile preprocessFile ("client\Func_Client_ConvertToArray.sqf");
Func_Client_ConvertToDirection=compile preprocessFile ("client\Func_Client_ConvertToDirection.sqf");
Func_Client_ConvertToTime=compile preprocessFile ("client\Func_Client_ConvertToTime.sqf");
Func_Client_CopyrightsAndLinks=compile preprocessFile ("client\Func_Client_CopyrightsAndLinks.sqf");
Func_Client_CreateCustomVehicle=compile preprocessFile ("client\Func_Client_CreateCustomVehicle.sqf");
Func_Client_CreateRespawnCamera=compile preprocessFile ("client\Func_Client_CreateRespawnCamera.sqf");
Func_Client_CreateRotatingCamera=compile preprocessFile ("client\Func_Client_CreateRotatingCamera.sqf");
Func_Client_CreateSensors=compile preprocessFile ("client\Func_Client_CreateSensors.sqf");
Func_Client_EquipLoadout=compile preprocessFile ("client\Func_Client_EquipLoadout.sqf");
Func_Client_FieldRepairs=compile preprocessFile ("client\Func_Client_FieldRepairs.sqf");
Func_Client_GetContainerMaximumLoad=compile preprocessFile ("client\Func_Client_GetContainerMaximumLoad.sqf");
Func_Client_GetInventoryCost=compile preprocessFile ("client\Func_Client_GetInventoryCost.sqf");
Func_Client_GetItemCost=compile preprocessFile ("client\Config\Config_GetItemCost.sqf");
Func_Client_GetItemsMass=compile preprocessFile ("client\Func_Client_GetItemsMass.sqf");
Func_Client_GetPlayerFunds=compile preprocessFile ("client\Func_Client_GetPlayerFunds.sqf");
Func_Client_GetPlayerInventory=compile preprocessFile ("client\Func_Client_GetPlayerInventory.sqf");
Func_Client_GetPosition=compile preprocessFile ("client\Func_Client_GetPosition.sqf");
Func_Client_InventoryToArray=compile preprocessFile ("client\Func_Client_InventoryToArray.sqf");
Func_Client_IsBackpack=compile preprocessFile ("client\Func_Client_IsBackpack.sqf");
Func_Client_LimitExternalView=compile preprocessFile ("client\Func_Client_LimitExternalView.sqf");
Func_Client_LockUnlock=compile preprocessFile ("client\Func_Client_LockUnlock.sqf");
Func_Client_LowGear=compile preprocessFile ("client\Func_Client_LowGear.sqf");
Func_Client_MainThread=compile preprocessFile ("client\Func_Client_MainThread.sqf");
Func_Client_MapIntro=compile preprocessFile ("client\Func_Client_MapIntro.sqf");
Func_Client_MapOutro=compile preprocessFile ("client\Func_Client_MapOutro.sqf");
Func_Client_MarkFriendlyPlayers=compile preprocessFile ("client\Func_Client_MarkFriendlyPlayers.sqf");
Func_Client_MarkFriendlyVehicles=compile preprocessFile ("client\Func_Client_MarkFriendlyVehicles.sqf");
Func_Client_MarkMHQ=compile preprocessFile ("client\Func_Client_MarkMHQ.sqf");
Func_Client_MoveStatic=compile preprocessFile ("client\Func_Client_MoveStatic.sqf");
Func_Client_PlayerFired=compile preprocessFile ("client\Func_Client_PlayerFired.sqf");
Func_Client_PlayerRespawn=compile preprocessFile ("client\Func_Client_PlayerRespawn.sqf");
Func_Client_PushCrew=compile preprocessFile ("client\Func_Client_PushCrew.sqf");
Func_Client_ReadRemoteMessages=compile preprocessFile ("client\Func_Client_ReadRemoteMessages.sqf");
Func_Client_ReammoVehicle=compile preprocessFile ("client\Func_Client_ReammoVehicle.sqf");
Func_Client_RefuelVehicle=compile preprocessFile ("client\Func_Client_RefuelVehicle.sqf");
Func_Client_RegisterCustomVehicle=compile preprocessFile ("client\Func_Client_RegisterCustomVehicle.sqf");
Func_Client_RepairVehicle=compile preprocessFile ("client\Func_Client_RepairVehicle.sqf");
Func_Client_ReviveRequest=compile preprocessFile ("client\Func_Client_ReviveRequest.sqf");
Func_Client_SetAllowDamage=compile preprocessFile ("client\Func_Client_SetAllowDamage.sqf");
Func_Client_ShowCustomMessage=compile preprocessFile ("client\Func_Client_ShowCustomMessage.sqf");
Func_Client_ShowWeaponDirection=compile preprocessFile ("client\Func_Client_ShowWeaponDirection.sqf");
Func_Client_SomeUnitHealed=compile preprocessFile ("client\Func_Client_SomeUnitHealed.sqf");
Func_Client_TakeOff=compile preprocessFile ("client\Func_Client_TakeOff.sqf");
Func_Client_TrackEnemy=compile preprocessFile ("client\Func_Client_TrackEnemy.sqf");
Func_Client_TrackShell=compile preprocessFile ("client\Func_Client_TrackShell.sqf");
Func_Client_UpdateGUI=compile preprocessFile ("client\Func_Client_UpdateGUI.sqf");
Func_Client_UpdateOSD=compile preprocessFile ("client\Func_Client_UpdateOSD.sqf");
Func_Client_UpdateUserActions=compile preprocessFile ("client\Func_Client_UpdateUserActions.sqf");
Func_Client_UpdateVehicleActions=compile preprocessFile ("client\Func_Client_UpdateVehicleActions.sqf");

// load the correct loadouts and vehicle according to which map we are on.
_worldname = worldName;
/*switch(_worldname) do
{
	case "Stratis" :
	{
*/
		#include "Config\Config_LoadoutsStratis.sqf";
		#include "Config\Config_VehiclesStratis.sqf";
/*	};
};
*/

onEachFrame
{
	if (Dialog_ScreenMarkersType != 0) then
	{

		{
			if ((side _x == side player) && (_x != player)) then
			{
				private ["_pos", "_distance", "_color", "_picture"];

				_pos = _x modelToWorld (_x selectionposition "head");
				_pos = [_pos select 0, _pos select 1, 0.5 + (_pos select 2)];

				_distance = round (player distance _x);

				_color   = if (group _x == group player) then { [damage _x,0.2,0.9,1] } else { [damage _x,0.9,0.2,1] };
				_picture = if (_x in Local_CurrentPlayersTS) then { "\A3\Ui_f\data\GUI\Cfg\Ranks\general_gs.paa" } else { "a3\ui_f\data\map\VehicleIcons\iconexplosiveat_ca.paa" };

				drawIcon3D [_picture, _color, _pos, 0.5, 0.5, 0, (str _distance) + "m", 1, 0.02, "TahomaB"];
			};
		} forEach (if (Dialog_ScreenMarkersType == 1) then { units player } else { playableUnits });

		if (Local_PlayerIsMedic) then
		{
			{
				private ["_pos", "_distance"];

				_distance = round (player distance _x);

				if ((_distance < 75) && ((typeOf _x) in Local_FriendlySoldierTypes)) then
				{
					_pos = _x modelToWorld (_x selectionposition "head");
					_pos = [_pos select 0, _pos select 1, 0.5 + (_pos select 2)];

					drawIcon3D ["\A3\ui_f\data\map\vehicleicons\pictureHeal_ca.paa", [1,0,0,1], _pos, (1 + (0.2 * sin((400*diag_tickTime) mod 360))), (1 + (0.2 * cos((400*diag_tickTime) mod 360))), 0, (str _distance) + "m", 1, 0.04, "TahomaB"];
				};
			} forEach allDeadMen;
		};

		if ((count Local_TankDrivePos) != 0) then
		{
			private ["_distance"];

			_distance = round (player distance Local_TankDrivePos);

			drawIcon3D ["a3\ui_f\data\map\Markers\Military\marker_ca.paa", [0,1,0,1], Local_TankDrivePos, 0.7, 0.7, 0, (str _distance) + "m", 1, 0.02, "TahomaB"];
		};

		if ((count Local_TankFirePos) != 0) then
		{
			private ["_distance"];

			_distance = round (player distance Local_TankFirePos);

			drawIcon3D ["a3\ui_f\data\map\GroupIcons\selector_selectedmission_ca.paa", [1,0,0,1], Local_TankFirePos, 0.7, 0.7, 0, (str _distance) + "m", 1, 0.02, "TahomaB"];
		};

		{
			private ["_laser_spot"];

			_laser_spot = _x;
			if !(isNull _laser_spot) then
			{
				drawIcon3D ["a3\ui_f\data\map\GroupIcons\selector_selectedmission_ca.paa", [1,0,0,1], _laser_spot, 0.7, 0.7, 0, "", 1, 0.02, "TahomaB"];
			};
		} forEach Local_LaserSpots;

		{
			private ["_target"];

			_target = _x;
			if !(isNull _target) then
			{
				drawIcon3D ["a3\ui_f\data\map\Markers\NATO\o_unknown.paa", [0.7, 0.7, 0.7, 1], _target, 0.7, 0.7, 0, "", 1, 0.02, "TahomaB"];
			};
		} forEach Local_CommanderDetectedVehicles;

		if !(isNull System_RadarTrackedAircraft) then
		{
			drawIcon3D ["a3\ui_f\data\gui\cfg\cursors\track_gs.paa", [1, 0, 0, 1], System_RadarTrackedAircraft, 2, 2, 0, "", 1, 0.02, "TahomaB"];
		};
	};
};


{
	private ["_cp_flags"];

	_cp_flags = _x select 8;

	{
		private ["_flag", "_position"];
		_flag = _x;
		_position = position _flag;
		if (surfaceIsWater _position) then
		{
			hideObject _flag;
		};
	} forEach _cp_flags;
} forEach Config_TotalCheckPointData;


[
{
	private["_Item","_NameString","_task","_i","_count"];
	_pa3 = if (ismultiplayer) then {paramsArray select 3;} else {3000;};
	_pa9 = paramsArray select 9;
	Local_ViewDistance= _pa3;
	Local_Grass=_pa9;
	Local_PlayerSide=side player;
	Local_PlayerName=name player;
	Local_SpawnPos=getPosATL player;
	Local_SpawnDir=getDir player;

	switch(Local_PlayerSide)do
	{
		case east:
		{
			Local_FriendlyColor=Config_EastColor;
			Local_FriendlyMHQ=Config_EastMHQ;
			Local_FriendlySpawnPoints=Config_EastSpawnPoints;
			Local_FriendlySupplyVehicleTypes=Config_EastSupplyVehicleTypes;
			Local_FriendlyReammoVehicleTypes=Config_EastReammoVehicleTypes;
			Local_FriendlyRepairVehicleTypes=Config_EastRepairVehicleTypes;
			Local_FriendlyRefuelVehicleTypes=Config_EastRefuelVehicleTypes;
			Local_FriendlySoldierTypes=Config_EastSoldierTypes;
			Local_FriendlyBaseFlag=Config_EastBaseFlag;
			Local_FriendlyMarkerDirection=Config_EastMarkerDirecton;
			Local_EnemyColor=Config_WestColor;
			Local_EnemyBaseFlag=Config_WestBaseFlag;
			Local_EnemySide=west;
			Local_EnemyMHQ=Config_WestMHQ;
		};
		case west:
		{
			Local_FriendlyColor=Config_WestColor;
			Local_FriendlyMHQ=Config_WestMHQ;
			Local_FriendlySpawnPoints=Config_WestSpawnPoints;
			Local_FriendlySupplyVehicleTypes=Config_WestSupplyVehicleTypes;
			Local_FriendlyReammoVehicleTypes=Config_WestReammoVehicleTypes;
			Local_FriendlyRepairVehicleTypes=Config_WestRepairVehicleTypes;
			Local_FriendlyRefuelVehicleTypes=Config_WestRefuelVehicleTypes;
			Local_FriendlySoldierTypes=Config_WestSoldierTypes;
			Local_FriendlyBaseFlag=Config_WestBaseFlag;
			Local_FriendlyMarkerDirection=Config_WestMarkerDirecton;
			Local_EnemyColor=Config_EastColor;
			Local_EnemyBaseFlag=Config_EastBaseFlag;
			Local_EnemySide=east;
			Local_EnemyMHQ=Config_EastMHQ;
		};
		default{hint "error";};
	};

	showCinemaBorder false;
	setViewDistance Local_ViewDistance;
	if (Local_Grass==0) then
	{
		setTerrainGrid 50;
	};

	player addEventHandler ['killed', "[Func_Client_PlayerRespawn, _this] call Func_Common_Spawn"];

	player call Func_Common_AddHandlers;

	player addEventHandler ['fired', Func_Client_PlayerFired];

	player addEventHandler ['hit',       "if (side(_this select 1)==Local_EnemySide) then {Local_InjuredByEnemy=true}"];
	player addEventHandler ['Dammaged',  "switch (_this select 1) do {case 'nohy': {Dialog_LegsHit=true;};case 'ruce': {Dialog_HandsHit=true;};case 'telo': {Dialog_BodyHit=true;};case 'hlava': {Dialog_HeadHit=true;};default{} };"];
	player addEventHandler ['firednear', "_this call Func_System_FiredNear"];

	waitUntil {!(isNull (findDisplay 46))};
	(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call Func_System_KeyPressed"];
	(findDisplay 46) displayAddEventHandler ["KeyUp","Local_KeyPressedForward=false;"];

	{((_x select 8) select 0) setVariable ["owner_color",Config_IndepColor,false]} forEach Config_TotalCheckPointData;

	"Public_VehicleLock" addPublicVariableEventHandler {if (local (_this select 1)) then {(_this select 1) lock !((locked (_this select 1))==2)}};
	"Public_EnemyTracked" addPublicVariableEventHandler {[Func_Client_TrackEnemy, (_this select 1)] call Func_Common_Spawn};
	"Public_UnitRegistered" addPublicVariableEventHandler {if (((_this select 1) getVariable "ft2_wf_side")==Local_PlayerSide) then {Local_RegisteredObjects=Local_RegisteredObjects+[_this select 1];};};
	"Public_TankExploded" addPublicVariableEventHandler {[Func_System_TankExploded, (_this select 1)] call Func_Common_Spawn};
	"Public_DeadUnit" addPublicVariableEventHandler {if (((_this select 1) select 0) getVariable "ft2_wf_side"==Local_PlayerSide) then {private["_name"];_name=format["body%1",((_this select 1) select 0) getVariable "playername"]; if ((_this select 1) select 1) then {createMarkerLocal[_name,position ((_this select 1) select 0)];_name setMarkerColorLocal Local_FriendlyColor;_name setMarkerTypeLocal "waypoint";_name setMarkerSizeLocal [1.3,1.3]} else {deleteMarkerLocal _name}}};
	"Public_UnitHealed" addPublicVariableEventHandler {[Func_Client_SomeUnitHealed, (_this select 1)] call Func_Common_Spawn};
	"Public_ReviveRequest" addPublicVariableEventHandler {if (((_this select 1) select 1)==Local_PlayerBody) then {[Func_Client_ReviveRequest, ((_this select 1) select 0)] call Func_Common_Spawn}};
	"Public_VehicleSmokeShells" addPublicVariableEventHandler {{[Func_System_SpawnSmoke, [_x]] call Func_Common_Spawn } forEach (_this select 1)};



	//---start funds---
	_varname=format["FT2_WF_Funds_%1",Local_PlayerName];
	if (isNil {FT2_WF_Logic getVariable _varname}) then
	{
		_count=paramsArray select 7;
		FT2_WF_Logic setVariable [_varname,_count,true];
	};
	//---

	//---weather system---
	if !(Config_DisableWeatherChange) then
	{
		_pa2 = 0;
		if (ismultiplayer) then {_pa2 = (paramsArray select 2);};
		if (_pa2 == -1) then
		{
			if (!isServer) then
			{
				"Public_WeatherCode" addPublicVariableEventHandler { 10 setOvercast((_this select 1) select 2); 10 setRain((_this select 1) select 3); };
			};
		}else{
			10 setOvercast _pa2;
			10 setRain _pa2;
		};
	};
	//---

	//Create capture&hold tasks in diary
	_count=count Config_TotalCheckPointData-1;
	for[{_i=_count},{_i>=0},{_i=_i-1}] do
	{
		_Item=Config_TotalCheckPointData select _i;
		_NameString=localize (_Item select 1);
		(_Item select 5) setMarkerTextLocal localize (_Item select 2);
		call compile format ["task%1=player createSimpleTask [""obj%1""];_task=task%1;", _i];
		_task setSimpleTaskDescription [format [localize "STR_CP_TaskDescFull",_NameString],format [localize "STR_CP_TaskDescMedium",_NameString],format [localize "STR_CP_TaskDescShort",_NameString]];
		_task setSimpleTaskDestination getMarkerPos(_Item select 3);
		_Item set [0,_task];
		Local_TaskSensors=Local_TaskSensors+(_item select 7);
	};

	//Create markers for friendly MHQ
	_i=1;
	{
		_NameString=format ["mhqMarker%1",_i];
		createMarkerLocal [_NameString,[15000,15000]];
		_NameString setMarkerColorLocal Local_FriendlyColor;
		_NameString setMarkerSizeLocal [0.5,0.5];
		_NameString setMarkerTypeLocal "mil_marker";
		_i=_i+1;
		_x setVariable ["Local_MhqHintOldEvent","STR_HINT_MHQ_Deployed"];
	} forEach ([] call Local_FriendlyMHQ);

	Local_NumberOfMarkersCreated = 0;
	Local_NumberOfMarkersUsed    = 0;

	//checking for friendly vehicles to mark them on map
	{
		if (((_x getVariable "ft2_wf_side")==Local_PlayerSide) && ((_x getVariable "owner_name")!="")) then
		{
			Local_RegisteredObjects=Local_RegisteredObjects+[_x];
		};
	} forEach vehicles;

	//create ammo crates markers
	_i=1;
	{
		_NameString=format ["ammoMarker%1",_i];
		createMarkerLocal [_NameString,position _x];
		_NameString setMarkerColorLocal "ColorYellow";
		_NameString setMarkerSizeLocal [0.4,0.4];
		_NameString setMarkerTypeLocal "mil_box";
		_NameString setMarkerTextLocal localize "STR_BASE_Ammo";
		_i=_i+1;
	} forEach ([] call Config_AmmoCrates);


	//create hospitals markers
	_i=1;
	{
		_NameString=format ["hospMarker%1",_i];
		createMarkerLocal [_NameString,position _x];
		_NameString setMarkerColorLocal "ColorGreen";
		_NameString setMarkerSizeLocal [0.4,0.4];
		_NameString setMarkerTypeLocal "mil_box";
		_NameString setMarkerTextLocal localize "STR_BASE_Hosp";
		_i=_i+1;
	} forEach ([] call Config_Hospitals);


	_position=getMarkerPos Local_FriendlyMarkerDirection;
	_MarkerDirection=markerDir Local_FriendlyMarkerDirection;
	Local_CameraTargets=[[_position,_MarkerDirection,600] call Func_Client_GetPosition,
						 [_position,_MarkerDirection,3000] call Func_Client_GetPosition,
						 [_position,_MarkerDirection,1200] call Func_Client_GetPosition];


	//[] spawn Func_Client_PlayerRespawn;
	[Func_Client_MapIntro, []] call Func_Common_Spawn;
	[] call Func_Client_CreateSensors;

	Dialog_RespawnDeathTime=-(Config_SpawnDelay-Config_GameStartDelay)+time;//game starts in Config_GameStartDelay after player join it
	Dialog_RespawnCurrentPoint=0;//0 - index of element in Local_FriendlySpawnPoints

	if (Localshowintro) then {sleep 36.1} else {sleep 7.0;};

	//Run client main thread
	[Func_Client_MainThread, []] call Func_Common_Spawn;
	[Func_Client_LimitExternalView, []] call Func_Common_Spawn;
	[Func_Client_CheckPointCaptured, []] call Func_Common_Spawn;

	//Send command to the server to renew marker colors
	Public_PlayerConnected=player;
	"Public_PlayerConnected" call Func_Common_PublicVariable;

	if (Localshowintro) then {sleep 5.0} else {sleep 0.0;};
	//Show Credits
	titleRsc ["trailer","plain"];
}
] call Func_Common_Spawn;
