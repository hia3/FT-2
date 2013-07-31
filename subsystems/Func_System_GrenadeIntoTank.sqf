/**/
_unit=player;
_tank=nearestObjects[_unit,["tank","Wheeled_APC_F"],9] select 0;
if (isNull _tank) exitWith {};

_thrown=false;

_unit attachTo[_tank,[3,0,-2]];
_unit setDir 270;
_unit playMoveNow "amovpercmstpsnonwnondnon_acrgpknlmstpsnonwnondnon_getinmedium";

sleep 1.7;

if (!(alive _unit)) exitWith {detach _unit};
_unit attachTo[_tank,[0,-1,-0.3],"mainTurret"];
_unit playMoveNow "AmovPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_Putdown";

sleep 4;
if (!((locked _tank)==2)) then
{
	{if (_x in magazines _unit) exitWith{_unit removeMagazine _x; _thrown=true;}} forEach System_HandGrenadeAmmoTypes;

	["message_grenadeinside", [], crew _tank] call Func_Common_SendRemoteCommand;
}
else
{
	_name=getText(configFile>>"cfgVehicles">>(typeOf _tank)>>"displayName");
	[_name,localize "STR_MES_GrenadeLocked","pic\no.paa",1.0] call Func_Client_ShowCustomMessage;
};

if (!(alive _unit)) exitWith {detach _unit};
sleep 1;

if (!(alive _unit)) exitWith {detach _unit};
_unit attachTo[_tank,[3,0,-2]];
_unit setDir 90;
_unit switchMove "acrgpknlmstpsnonwnondnon_amovpercmstpsraswrfldnon_getoutmedium";

sleep 1.0;
detach _unit;

if (_thrown) then
{
	sleep 1.5;

	Public_TankExploded=_tank;
	"Public_TankExploded" call Func_Common_PublicVariable;
	_tank spawn Func_System_TankExploded;

	_crew=crew _tank;
	_cnt={alive _x} count _crew;

	["message_grenadeinexploded", Local_PlayerName, _crew] call Func_Common_SendRemoteCommand;

	{_x setDamage 1} forEach _crew;

	_award=Config_AwardKillPlayerValue*3;
	(_award*_cnt) call Func_Client_ChangePlayerFunds;

	for [{_i=0},{_i<_cnt},{_i=_i+1}] do
	{
		["message_kill_infantry", _award, _unit] call Func_Common_SendRemoteCommand;
	};

	if ((locked _tank)==2) then
	{
		if (local _tank) then
		{
			_tank lock false;
		}
		else
		{
			Public_VehicleLock=_tank;
			"Public_VehicleLock" call Func_Common_PublicVariable;
		};
	};
};
