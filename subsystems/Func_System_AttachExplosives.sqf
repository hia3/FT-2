// this script attaches your explosive to a vehicle.
sleep 1;
_unit = player;
_tank = (nearestObjects[_unit,["car","truck","tank","Wheeled_APC_F"],15]) select 0;
sleep 0.2;
_bomb = nearestObject [_unit, 'SatchelCharge_Remote_Ammo'];
sleep 0.2;
if (isNull _tank) exitWith {};
if (isNull _bomb) exitWith {};
_thrown=true;

_bb = boundingBoxReal _tank;
_bb1 = _bb select 0;

Local_PlayerAttachedMines = Local_PlayerAttachedMines + [_bomb];

_bomb attachTo[_tank, [0, (_bb1 select 1) / 2, (_bb1 select 2) / 2]];
_pic = getText(configFile >> 'CfgMagazines' >> 'SatchelCharge_Remote_Mag' >> 'picture');
["Bomb","Attached..",_pic,1.0] call Func_Client_ShowCustomMessage;

_tank_last_pos = getPos _tank;

waitUntil { _tank_last_pos = getPos _tank; sleep 0.1; (isNull _bomb) || (isNull _tank)};

sleep 0.1;

if !(isNull _bomb) then
{
	deleteVehicle _bomb;
};

_effect0 = 'HelicopterExploBig' createVehicle _tank_last_pos;
_effect1 = 'HelicopterExploSmall' createVehicle _tank_last_pos;
_effect2 = 'HelicopterExploBig' createVehicle _tank_last_pos;
