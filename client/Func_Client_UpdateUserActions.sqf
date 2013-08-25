
//player addAction [localize "STR_ACT_Armory","client\Script_Client_Actions.sqf",[0],91,false,true,"", "(alive _target) && ((({((_target distance _x) <= Config_SupplyVehicleRange) && (alive _x)} count nearestobjects [_target,Local_FriendlySupplyVehicleTypes,Config_SupplyVehicleRange]) > 0) || ((_target distance Local_FriendlyBaseFlag)<Config_RespawnSize))"];
//player addAction [localize "STR_ACT_Vehicles","client\Script_Client_Actions.sqf",[4],90,false,true,"", "(alive _target) && ((_target distance Local_FriendlyBaseFlag)<Config_RespawnSize)"];
//player addAction [localize "STR_ACT_GPSOn","client\Script_Client_Actions.sqf",[1],0,false,true,"", "(alive _target) && (!Local_GUIActive)"];		
//player addAction [localize "STR_ACT_GPSOff","client\Script_Client_Actions.sqf",[2],0,false,true,"", "(alive _target) && (Local_GUIActive)"];		
player addAction ["<t color='#FFDD47'>"+(localize "STR_ACT_Menu")+"</t>","client\Script_Client_Actions.sqf",[4],90,false,true,"",""];
player addAction ["<t color='#FF4A3D'>"+(localize "STR_ACT_Cut")+"</t>","client\Script_Client_Actions.sqf",[0],100,false,true,"", "private ['_tp', '_td', '_man']; _tp = getposATL _target; _td = getDir _target; _man = nearestObject[[(_tp select 0)+1.5*sin(_td),(_tp select 1)+1.5*cos(_td), (_tp select 2)],'Man']; (_man != _target) && (alive _man) && ((side _man)==Local_EnemySide) && (alive _target) && ((vehicle _target)==_target) && ((vehicle player)==player) && !((netId _man) in Local_KnifedVictimNetId)"];
player addAction ["<t color='#FF4A3D'>"+(localize "STR_ACT_Grenade")+"</t>","client\Script_Client_Actions.sqf",[16],98,false,true,"", "({((_target distance _x) < 8) && ((side _x)==Local_EnemySide)} count nearestObjects [_target,['tank','Wheeled_APC_F'],8]>0) && (alive _target) && ((vehicle _target)==_target) && (({_x in magazines _target} count System_HandGrenadeAmmoTypes)>0)"];

player addAction ["<t color='#4C4FFF'>"+(localize "STR_ACT_Revive")+"</t>","client\Script_Client_Actions.sqf",[24],98,false,true,"", "private ['_p', '_d', '_man']; _p = getposATL _target; _d = getDir _target; _man = nearestObject[[(_p select 0)+1.5*sin(_d), (_p select 1)+1.5*cos(_d), (_p select 2)],'Man']; (_man != _target) && !(alive _man) && (alive _target) && ((vehicle _target)==_target) && ((animationState _target)!=""AinvPknlMstpSlayWrflDnon_medic"") && (({""Medikit"" in _x} count [items _target, items _man]) != 0)"];

_pa8 = 1;
if (ismultiplayer) then {_pa8 = (paramsArray select 8);};
if (_pa8 == 1) then
{
	player addAction ["<t color='#4C4FFF'>Halo</t>","client\Script_Client_Actions.sqf",[30],98,false,true,"","( ((_target distance Local_FriendlyBaseFlag) < 5) && (vehicle player == player) )"];
};
	
player addAction ["<t color='#FF4A3D'>Attach Explosives</t>","client\Script_Client_Actions.sqf",[32],98,false,true,"", "({((_target distance _x) < 8)} count nearestObjects [_target,['car','truck','tank','Wheeled_APC_F'],8]>0) && (alive _target) && ((vehicle _target)==_target) && (({!(_x in Local_PlayerAttachedMines)} count (position player nearObjects ['SatchelCharge_Remote_Ammo', 2])) > 0)"];

_pa10 = 1;
if (ismultiplayer) then {_pa10 = (paramsArray select 10);};
if (_pa10 == 1) then
{
	player addAction ["<t color='#4040FF'>"+(localize "STR_ACT_MHQ_Bicycle")+"</t>","client\Script_Client_Actions.sqf",[35],98,false,true,"", "((vehicle player)==player) && ((vehicle _target)==_target) && (({((_target distance _x) < 10) && ((_target distance Local_FriendlyBaseFlag)>Config_RespawnSafeZone) && (alive _x)} count (call Local_FriendlyMHQ)) > 0)"];
};
