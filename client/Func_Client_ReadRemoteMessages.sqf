
	_message=player getVariable "message_kill_safezone";
	if (_message!=0) then
	{
		if (_message > 0) then
		{
			player commandChat format[localize "STR_MES_KIlledSafe",_message];
			playSound "error_sound";
		};		
		player setVariable ["message_kill_safezone",0];
	};
	
	_message=player getVariable "message_kill_infantry";
	if (_message!=0) then
	{
		if (_message > 0) then
		{
			player groupChat format[localize "STR_MES_KIlledManE",_message];
		}
		else
		{
			player groupChat format[localize "STR_MES_KIlledManF",_message];
			playSound "error_sound";
		};
		player setVariable ["message_kill_infantry",0];
	};

	_message=player getVariable "message_destroy_vehicle";
	if (_message!=0) then
	{
		if (_message > 0) then
		{
			player groupChat format[localize "STR_MES_DestroyedVehE",_message];
		}
		else
		{
			player groupChat format[localize "STR_MES_DestroyedVehF",_message];
		};
		player setVariable ["message_destroy_vehicle",0];
	};

	
	_message=player getVariable "message_transfer_funds";
	if ((typeName _message)=="ARRAY") then
	{	
		player groupChat format[localize "STR_MES_FundsTransfered",_message select 0,_message select 1];
		playSound "hint_sound";
		
		player setVariable ["message_transfer_funds",0];
	};

	_message=player getVariable "message_group";
	if ((typeName _message)=="ARRAY") then
	{	
		if (_message select 0)then
		{
			player groupChat format[localize "STR_MES_JoinedGroup",_message select 1];
		}
		else
		{
			player groupChat format[localize "STR_MES_LeftGroup",_message select 1];
		};
		
		player setVariable ["message_group",0];
	};

	_message=player getVariable "message_knife";

	if ((typeName _message)=="OBJECT") then
	{	
		player commandChat format[localize "STR_MES_KIlledKnife",_message getVariable "playername"];
		player setVariable ["message_knife",0];
	};

	_message=player getVariable "message_blast";
	if ((typeName _message)=="OBJECT") then
	{	
		player commandChat format[localize "STR_MES_BackBlast",_message getVariable "playername"];	
		player setVariable ["message_blast",0];
		
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

	_message=player getVariable "message_pushcrew";
	if ((typeName _message)=="OBJECT") then
	{	
		player commandChat format[localize "STR_MES_Push",_message getVariable "playername"];	
		player setVariable ["message_pushcrew",0];
		[] spawn 
		{
			private ["_pos","_ang","_dir"];
			
			titleCut["","black out",1];				
			
			sleep 1;
				
			player action ["eject",Local_PlayerVehicle];
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

	_message=player getVariable "message_grenadeinside";
	if ((typeName _message)=="OBJECT") then
	{			
		player setVariable ["message_grenadeinside",0];
		Local_PlayerVehicle vehicleRadio "grenade_in_tank";
	};
	
	_message=player getVariable "message_grenadeinexploded";
	if ((typeName _message)=="OBJECT") then
	{	
		player setVariable ["message_grenadeinexploded",0];
		player commandChat format[localize "STR_MES_GrenadeInside",_message getVariable "playername"];		
	};
	
	_message=player getVariable "message_healedteammate";
	if (_message!=0) then
	{	
		player groupChat format[localize "STR_MES_HealedTeammate",_message];
		player setVariable ["message_healedteammate",0];		
	};
	
	_message=player getVariable "message_revivedteammate";
	if (_message!=0) then
	{	
		player groupChat format[localize "STR_MES_RevivedTeammate",_message];
		player setVariable ["message_revivedteammate",0];		
	};
