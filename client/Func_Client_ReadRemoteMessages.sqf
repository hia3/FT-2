
_msg = _this select 0;
_arg = _this select 1;

switch (_msg) do
{
	case "message_kill_infantry":
	{
		if (_arg != 0) then
		{
			if (_arg > 0) then
			{
				player groupChat format[localize "STR_MES_KIlledManE", _arg];
			}
			else
			{
				player groupChat format[localize "STR_MES_KIlledManF", _arg];
				playSound "error_sound";
			};
		};
	};

	case "message_destroy_vehicle":
	{
		if (_arg != 0) then
		{
			if (_arg > 0) then
			{
				player groupChat format[localize "STR_MES_DestroyedVehE", _arg];
			}
			else
			{
				player groupChat format[localize "STR_MES_DestroyedVehF", _arg];
				playSound "error_sound";
			};
		};
	};
	
	case "message_transfer_funds":
	{
		private ["_sponsor", "_money"];
		_sponsor = _arg select 0;
		_money   = _arg select 1;
		
		player groupChat format[localize "STR_MES_FundsTransfered", _sponsor, _money];
		playSound "hint_sound";
	};
	
	case "message_group":
	{
		private ["_is_joined", "_member"];
		_is_joined = _arg select 0;
		_member    = _arg select 1;
		
		if (_is_joined) then
		{
			player groupChat format[localize "STR_MES_JoinedGroup", _member];
		}
		else
		{
			player groupChat format[localize "STR_MES_LeftGroup", _member];
		};
	};
	
	case "message_knife":
	{
		player commandChat format[localize "STR_MES_KIlledKnife", _arg];
	};
	
	case "message_blast":
	{
		player commandChat format[localize "STR_MES_BackBlast", _arg];
		
		[] spawn
		{
			"DynamicBlur" ppEffectEnable true;
			"DynamicBlur" ppEffectAdjust [5];
			"DynamicBlur" ppEffectCommit 0.5;
			sleep 3;
			"DynamicBlur" ppEffectAdjust [0];
			"DynamicBlur" ppEffectCommit 4;
			sleep 4;
			"DynamicBlur" ppEffectEnable false;
		};
	};
	
	case "message_pushcrew":
	{
		player commandChat format[localize "STR_MES_Push", _arg];
		
		[] spawn
		{
			private ["_pos","_ang","_dir"];

			titleCut["","black out",1];

			sleep 1;

			player action ["eject", Local_PlayerVehicle];
			sleep 0.5;

			_pos=getPos Local_PlayerVehicle;
			_ang=random 360;
			_dir=3;
			player setPos [(_pos select 0)+_dir*(sin _ang),(_pos select 1)+_dir*(cos _ang),0];
			player setVelocity [0,0,0];

			titleCut["","black in",1];
			//switch GUI off
			Local_GUIActive=false;
			sleep 1;
			//switch GUI on
			Local_GUIActive=true;
		};
	};
	
	case "message_grenadeinside":
	{
		Local_PlayerVehicle vehicleRadio "grenade_in_tank";
	};
	
	case "message_grenadeinexploded":
	{
		player commandChat format[localize "STR_MES_GrenadeInside", _arg];
	};
	
	case "message_healedteammate":
	{
		player groupChat format[localize "STR_MES_HealedTeammate", _arg];
	};
	
	case "message_revivedteammate":
	{
		player groupChat format[localize "STR_MES_RevivedTeammate", _arg];
	};
	
	case "message_incoming_missile":
	{
		switch (_arg) do
		{
			case "tank":
			{
				[localize "STR_HINT_Warning",localize "STR_HINT_IncomingATGM","pic\ui_notfreeze_ca.01.paa",1.0] call Func_Client_ShowCustomMessage;
				Local_PlayerVehicle vehicleRadio "tank_alarm";
			};
			case "air":
			{
				[localize "STR_HINT_Warning",localize "STR_HINT_IncomingMissile","pic\ui_notfreeze_ca.01.paa",1.0] call Func_Client_ShowCustomMessage;
				Local_PlayerVehicle vehicleRadio "air_alarm";
			};
		};
	};
};
