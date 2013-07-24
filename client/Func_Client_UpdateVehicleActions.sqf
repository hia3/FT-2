
private["_param"];
	
_param=_this select 0;
	
if ((vehicle player) in (call Local_EnemyMHQ)) exitWith
{
	[] spawn
	{
		_veh=vehicle player; 
		player action ["eject",_veh]; 
		
		_fuel=fuel _veh;
		_veh setFuel 0;
		_veh setVelocity [0,0,0];
		sleep 1;
		_veh setFuel _fuel;
	};
};
	
if (_param) then
{					
	Local_PlayerVehicle=vehicle player;		
	if (Local_PlayerVehicle isKindOf "ParachuteBase") exitWith {Local_PlayerVehicle=player};

if ((Local_PlayerVehicle in (call Config_EastMHQ)) || (Local_PlayerVehicle in (call Config_WestMHQ))) then
{
	// do nothing
}
else
{
	Local_PlayerVehicle setVariable ["ft2_wf_side", Local_PlayerSide, true];
};

_action=Local_PlayerVehicle addAction ["<t color='#4C4FFF'>"+(localize "STR_ACT_Repair")+"</t>","client\Script_Client_Actions.sqf",[8],96,false,true,"", "(alive player) && (local _target) && ((speed _target)<5) && (((getPosATL _target select 2) < 5) || (_target isKindOf 'StaticWeapon')) && (({((_target distance _x) < Config_ServiceVehicleRange) && (alive _x)} count nearestObjects [_target,Local_FriendlyRepairVehicleTypes,Config_ServiceVehicleRange]>0) || ((_target distance Local_FriendlyBaseFlag)<Config_RespawnSize)) && !(Local_TechnicalService)"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_Repair",_action];		

_action=Local_PlayerVehicle addAction ["<t color='#4C4FFF'>"+(localize "STR_ACT_Reammo")+"</t>","client\Script_Client_Actions.sqf",[9],95,false,true,"", "(alive player) && ((local _target) || (((assignedVehicleRole player) select 0)=='Turret')) && ((speed _target)<5) && (((getPosATL _target select 2) < 5) || (_target isKindOf 'StaticWeapon')) && (({((_target distance _x) < Config_ServiceVehicleRange) && (alive _x)} count nearestObjects [_target,Local_FriendlyReammoVehicleTypes,Config_ServiceVehicleRange]>0) || ((_target distance Local_FriendlyBaseFlag)<Config_RespawnSize)) && !(Local_TechnicalService)"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_Reammo",_action];

_action=Local_PlayerVehicle addAction ["<t color='#4C4FFF'>"+(localize "STR_ACT_Refuel")+"</t>","client\Script_Client_Actions.sqf",[10],94,false,true,"", "(alive player) && (local _target) && ((speed _target)<5) && (((getPosATL _target select 2) < 5) || (_target isKindOf 'StaticWeapon')) && (({((_target distance _x) < Config_ServiceVehicleRange) && (alive _x)} count nearestObjects [_target,Local_FriendlyRefuelVehicleTypes,Config_ServiceVehicleRange]>0) || ((_target distance Local_FriendlyBaseFlag)<Config_RespawnSize)) && !(Local_TechnicalService)"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_Refuel",_action];
	
_action=Local_PlayerVehicle addAction ["<t color='#FF4A3D'>"+(localize "STR_ACT_BailOut")+"</t>","client\Script_Client_Actions.sqf",[7],100,false,true,"", "(alive _target) && ((locked _target)==2) && !(_target isKindOf 'Air')"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_BailOut",_action];		

_action=Local_PlayerVehicle addAction ["<t color='#FFF37A'>"+(localize "STR_ACT_TakeOff")+"</t>","client\Script_Client_Actions.sqf",[11],99,false,true,"", "(alive player)&& ((speed _target)<10) && ((getPosATL _target select 2) < 5) && (player==(driver _target)) && (_target isKindOf 'Plane') && !(Local_TechnicalService) && (isEngineOn _target)"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_TakeOff",_action];

_action=Local_PlayerVehicle addAction ["<t color='#FFF37A'>"+(localize "STR_ACT_Landing")+"</t>","client\Script_Client_Actions.sqf",[12],99,false,true,"", "(alive player)&& ((speed _target)<300) && ((speed _target)>50) && ((getPos _target select 2) < 150) && ((getPos _target select 2) > 10) && (player==(driver _target)) && ((_target distance Local_FriendlyBaseFlag)<Config_RespawnSize*2) && (_target isKindOf 'Plane')"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_Landing",_action];	

//_action=Local_PlayerVehicle  addAction ["<t color='#FFDD47'>"+(localize "STR_ACT_Menu")+"</t>","client\Script_Client_Actions.sqf",[4],50,false,true,"",""];
//Local_PlayerVehicle setVariable ["FT2_WF_ACT_Menu",_action];		

_action=Local_PlayerVehicle  addAction ["<t color='#FFBD4C'>"+(localize "STR_ACT_IgnitionOff")+"</t>","client\Script_Client_Actions.sqf",[25],98,false,true,"","(player==driver _target) && !(_target getVariable 'ignition_off') && ((getNumber(configFile >> 'CfgVehicles' >> typeOf _target >> 'Turrets' >> 'MainTurret' >> 'StartEngine')>0) || (getNumber(configFile >> 'CfgVehicles' >> typeOf _target >> 'Turrets' >> 'ObsTurret' >> 'StartEngine')>0)) && !(_target isKindOf 'Air')"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_IgnitionOff",_action];

_action=Local_PlayerVehicle  addAction ["<t color='#FFBD4C'>"+(localize "STR_ACT_IgnitionOn")+"</t>","client\Script_Client_Actions.sqf",[26],98,false,true,"","(player==driver _target) && (_target getVariable 'ignition_off')"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_IgnitionOn",_action];

_action=Local_PlayerVehicle  addAction ["<t color='#FFBD4C'>"+(localize "STR_ACT_LowGearOff")+"</t>","client\Script_Client_Actions.sqf",[28],91,false,true,"","(player==driver _target) && (Local_HighClimbingModeOn) && (canMove _target)"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_LowGearOff",_action];

_action=Local_PlayerVehicle  addAction ["<t color='#FFBD4C'>"+(localize "STR_ACT_LowGearOn")+"</t>","client\Script_Client_Actions.sqf",[28],91,false,true,"","(player==driver _target) && (!Local_HighClimbingModeOn) && (({_target isKindOf _x} count System_TrackedVehicleTypes)>0)"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_LowGearOn",_action];		

_action=Local_PlayerVehicle  addAction ["<t color='#FFF37A'>"+(localize "STR_ACT_RadarGuidanceOff")+"</t>","client\Script_Client_Actions.sqf",[29],97,false,true,"","(player==gunner _target) && (Local_RadarGuidanceOn) && (canFire _target)"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_RadarGuidanceOff",_action];

_action=Local_PlayerVehicle  addAction ["<t color='#FFF37A'>"+(localize "STR_ACT_RadarGuidanceOn")+"</t>","client\Script_Client_Actions.sqf",[29],97,false,true,"","(player==gunner _target) && (!Local_RadarGuidanceOn) && (canFire _target) && (({_target isKindOf _x} count System_HaveAARadarVehicleTypes) > 0)"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_RadarGuidanceOn",_action];

_action=Local_PlayerVehicle  addAction ["<t color='#FFBD4C'>"+(localize "STR_ACT_ClosedPosS")+"</t>","client\Script_Client_Actions.sqf",[21],94,false,true,"","(alive player) && (player==gunner _target) && ((currentWeapon _target) in System_IndirectWeaponsTypes) && !Local_IndirectFireMode"];		
Local_PlayerVehicle setVariable ["FT2_WF_ACT_ClosedPosS",_action];		

_action=Local_PlayerVehicle  addAction ["<t color='#FFBD4C'>"+(localize "STR_ACT_ClosedPosC")+"</t>","client\Script_Client_Actions.sqf",[22],94,false,true,"","(alive player) && Local_IndirectFireMode"];
Local_PlayerVehicle setVariable ["FT2_WF_ACT_ClosedPosC",_action];


_action=Local_PlayerVehicle  addAction ["<t color='#FFBD4C'>"+(localize "STR_ACT_ManualFlareOn")+"</t>","client\Script_Client_Actions.sqf",[33],98,false,true,"","(player==driver _target) && !(_target getVariable 'manualflare') && (_target isKindOf 'Air') && ((typeof _target) in System_AircraftVehicleTypes)"];
Local_PlayerVehicle setVariable ["STR_ACT_ManualFlareOn",_action];

_action=Local_PlayerVehicle  addAction ["<t color='#FFBD4C'>"+(localize "STR_ACT_ManualFlareOff")+"</t>","client\Script_Client_Actions.sqf",[34],98,false,true,"","(player==driver _target) && (_target getVariable 'manualflare')"];
Local_PlayerVehicle setVariable ["STR_ACT_ManualFlareOff",_action];


Local_PlayerVehicle addEventHandler ["Fired","_this call Func_Client_PlayerFired"];		
		

		if ((typeOf Local_PlayerVehicle) in System_CargoChopperVehicles) then
		{
			[] spawn Func_System_HeliCargoManager;			
		};
	
	}
	else
	{		
		_actions=["FT2_WF_ACT_GpsOn","FT2_WF_ACT_GpsOff","FT2_WF_ACT_BailOut","FT2_WF_ACT_Repair","FT2_WF_ACT_Reammo","FT2_WF_ACT_Refuel","FT2_WF_ACT_TakeOff","FT2_WF_ACT_Landing","FT2_WF_ACT_ClosedPosS","FT2_WF_ACT_ClosedPosC","FT2_WF_ACT_IgnitionOff","FT2_WF_ACT_IgnitionOn","FT2_WF_ACT_LowGearOff","FT2_WF_ACT_LowGearOn","FT2_WF_ACT_RadarGuidanceOff","FT2_WF_ACT_RadarGuidanceOn","STR_ACT_ManualFlareOff","STR_ACT_ManualFlareOn"];
		
		{
			_action=Local_PlayerVehicle getVariable _x;
			if (format["%1",_action]!="<null>") then
			{
				Local_PlayerVehicle removeAction _action;
			};		
		} forEach _actions;
		
		if (Local_PlayerVehicle!=player) then
		{
			Local_PlayerVehicle removeAllEventHandlers "Fired";
		};
		
		Local_PlayerVehicle=vehicle player;
	};