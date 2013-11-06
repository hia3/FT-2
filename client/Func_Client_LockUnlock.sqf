#include "defines.sqf"

#ifndef FT2_DISABLE_STUFF1

	//user action: "lock", "unlock"
	//see Func_Client_AddLockActions

	_name=getText(configFile>>"cfgVehicles">>(typeOf _this)>>"displayName");

	if ((locked _this)==2) then
	{
		//show message
		[_name,localize "STR_HINT_UnlockedVeh","pic\lock_on_ca.paa",1.0] call Func_Client_ShowCustomMessage;
	}
	else
	{
		//show message
		[_name,localize "STR_HINT_LockedVeh","pic\lock_off_ca.paa",1.0] call Func_Client_ShowCustomMessage;
	};

	if (local _this) then
	{
		//if vehicle is local, then just lock/unlock
		_this lock !((locked _this)==2);
	}
	else
	{
		//if vehicle is not local
		//see client`s and server`s precompile.sqf
		Public_VehicleLock=_this;
		"Public_VehicleLock" call Func_Common_PublicVariable;
	};

#endif
