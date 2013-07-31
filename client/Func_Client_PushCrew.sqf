//user action: push crew out of private vehicles

//lock the vehicle
if (!((locked _this)==2)) then
{
	if (local _this) then
	{
		_this lock true;
	}
	else
	{
		Public_VehicleLock=_this;
		"Public_VehicleLock" call Func_Common_PublicVariable;
	};
};

_name=gettext(configFile >> "CfgVehicles" >> (typeof _this) >> "displayName");
[_name,localize "STR_HINT_CrewPush","pic\lock_off_ca.paa",1.0] call Func_Client_ShowCustomMessage;

_crew=(crew _this)-[player];

["message_pushcrew", Local_PlayerName, _crew] call Func_Common_SendRemoteCommand;
