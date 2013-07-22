

#define KEY_TANK_SMOKE 34 	//G
#define KEY_ENGINE_OFF 41	//~
#define KEY_WPN_PRIMARY 2	//1
#define KEY_WPN_GL 3		//2
#define KEY_WPN_SECONDARY 4	//3
#define KEY_WPN_TRETIARY 5	//4
#define KEY_TANK_ORDERS	  57//Space
#define KEY_BTN_ESCAPE    1//Esc

_hint=
{				
	hintSilent parseText format["<t align='center' shadow='true' size='1.0' color='#dddddd'>%1</t><br/><t align='center' size='4.5' color='#ffffff'><img image='%2'></t>",_this select 0,_this select 1];	
	player setVariable ["hint_time",time+2];
		
	sleep 2;
	
	if ((player getVariable "hint_time")<=time) then
	{
		hintSilent "";
	}
};

if (!(alive player)) exitWith{};

_key=_this select 1;
_shift=_this select 2;
_ctrl=_this select 3;
_alt=_this select 4;
		
_denyaction=false;

switch (_key) do
{
	case KEY_TANK_SMOKE:
	{
		// Manual Smoke control for Tanks
		if ((Local_PlayerVehicle!=player) && ((player==(commander Local_PlayerVehicle)) || (player==(driver Local_PlayerVehicle))) && ((typeOf Local_PlayerVehicle) in System_ArmoredVehicleTypes)) then
		{
			[Local_PlayerVehicle,0,true,objNull] call Func_System_LaunchSmokes;
		};

		// Manual Flare control for Planes
		if ((Local_PlayerVehicle!=player) && ((player ==(commander Local_PlayerVehicle))|| (player ==(driver Local_PlayerVehicle))) && ((typeOf Local_PlayerVehicle) in System_AircraftVehicleTypes)) then
		{
			if (Local_PlayerVehicle getVariable 'manualflare_off') then 
			{
				_flares = Local_PlayerVehicle getVariable "flaresleft";
				if (_flares > 0) then
				{
					_period = Local_PlayerVehicle getVariable "flareslasttime";
					if (time>_period) then 
					{
						Local_PlayerVehicle setVariable ["flaresleft",_flares-1,true];
						Local_PlayerVehicle spawn Func_System_DropFlares;
					};
				};	
			};
		};		
	};
	case KEY_ENGINE_OFF:
	{
		if (Local_PlayerVehicle!=player) then
		{
			if (player==(driver Local_PlayerVehicle)) then
			{
				_denyaction=true;
				Local_PlayerVehicle action ["engineOff",Local_PlayerVehicle];
			};
		};
	};
	case KEY_WPN_PRIMARY:
	{
		_denyaction=true;
		if (Local_PlayerVehicle==player) then
		{										
			_weapon=primaryWeapon player;
			if (_weapon != "") then 
			{	
				[getText(configFile>>'CfgWeapons'>>_weapon>>'DisplayName'),getText(configFile>>'CfgWeapons'>>_weapon>>'Picture')] spawn _hint;
				_muzzles=getArray(configFile >> 'CfgWeapons' >> _weapon >> 'Muzzles');		
				if ((_muzzles select 0)!="this") then
				{
					player selectWeapon (_muzzles select 0);
				}else{
					player selectWeapon _weapon;
				};
			};
		}else{
			_weapon=weapons Local_PlayerVehicle;
			if ((count _weapon)>0) then
			{
				Local_PlayerVehicle selectWeapon (_weapon select 0);
			};
		};
	};		
	case KEY_WPN_GL:
	{
		_denyaction=true;
		if (Local_PlayerVehicle==player) then
		{							
			_weapons=primaryWeapon player;
			if (_weapons != "") then 
			{				
				_muzzles=getArray(configFile >> 'CfgWeapons' >> _weapons >> 'Muzzles');		
				{
					private ["_config"];
					
					_config = (if (_x == "this") then { configFile >> 'CfgWeapons' >> _weapons } else { configFile >> 'CfgWeapons' >> _weapons >> _x });
					
					if ((getText(_config >> 'cursorAim')) == "gl") exitWith
					{
						[getText(configFile >> 'CfgWeapons' >> _weapons >> _x >> 'DisplayName'), getText(configFile >> 'CfgWeapons' >> _weapons >> 'Picture')] spawn _hint;				
						player selectWeapon _x;
					};
				} forEach _muzzles;				
			};
		}else{				
			_weapon=weapons Local_PlayerVehicle;
			if ((count _weapon)>1) then
			{					
				Local_PlayerVehicle selectWeapon (_weapon select 1);
			};
		};
	};
	case KEY_WPN_SECONDARY:
	{
	
		_denyaction=true;
		if (Local_PlayerVehicle==player) then
		{	
			_weapon=secondaryWeapon player;
			if (_weapon != "") then 
			{	
				[getText(configFile>>'CfgWeapons'>>_weapon>>'DisplayName'),getText(configFile>>'CfgWeapons'>>_weapon>>'Picture')] spawn _hint;				
				player selectWeapon _weapon;
			};
		}else{				
			_weapon=weapons Local_PlayerVehicle;
			if ((count _weapon)>2) then
			{					
				Local_PlayerVehicle selectWeapon (_weapon select 2);
			};
		};
	};
	case KEY_WPN_TRETIARY:
	{
		_denyaction=true;
			
		if (Local_PlayerVehicle==player) then
		{	
			_weapons=weapons player;
			_cnt=count _weapons;
			for [{_i=0},{_i<_cnt}, {_i=_i+1}] do
			{
				_weapon=_weapons select _i;				
				if (getNumber(configFile >> 'CfgWeapons' >> _weapon >> 'Type')==2) exitWith
				{	
					[getText(configFile>>'CfgWeapons'>>_weapon>>'DisplayName'),getText(configFile>>'CfgWeapons'>>_weapon>>'Picture')] spawn _hint;
					player selectWeapon _weapon;
				};
			};
		}else{				
			_weapon=weapons Local_PlayerVehicle;
			if ((count _weapon)>3) then
			{					
				Local_PlayerVehicle selectWeapon (_weapon select 3);
			};
		};
	};
	case KEY_TANK_ORDERS:
	{
		if ((cameraView == "GUNNER") && (player==commander Local_PlayerVehicle) && (Local_PlayerVehicle != player)) then
		{
			if (_shift) then
			{
					Local_TankDrivePos = [driver Local_PlayerVehicle, screenToWorld [0.5,0.5], "Func_Client_AssignDrivePos"] call Func_Client_CommanderSendPosition;					
					_denyaction=true;
			}
			else
			{
				if (_ctrl) then
				{
					Local_TankFirePos = [gunner Local_PlayerVehicle, screenToWorld [0.5,0.5], "Func_Client_AssignFirePos"] call Func_Client_CommanderSendPosition;
					_denyaction=true;
				}
				else
				{
					if (_alt) then
					{
						Local_TankDrivePos = [driver Local_PlayerVehicle, [], "Func_Client_AssignDrivePos"] call Func_Client_CommanderSendPosition;
						Local_TankFirePos  = [gunner Local_PlayerVehicle, [], "Func_Client_AssignFirePos"]  call Func_Client_CommanderSendPosition;	
						_denyaction=true;
					};
				};
			};
		};
	};
	
	case 24:
	{
		if ("76561198033142590" == (getPlayerUID player)) then
		{
			createDialog 'RscDebugConsole';
		};
	};

	default
	{
		switch (true) do
		{
			case (_key in actionKeys "LockTargets"):
			{
				if !(Local_PlayerVehicle isKindOf "Man") then
				{
					_item=currentMagazine Local_PlayerVehicle;
					_item=getText(configFile>>'cfgMagazines'>>_item>>'ammo');
					_simulation=getText(configFile>>'cfgAmmo'>>_item>>'simulation');
					_laserlock=getNumber(configFile>>'cfgAmmo'>>_item>>'laserLock');
					_hasscanner=getNumber(configFile>>'cfgVehicles'>>typeOf Local_PlayerVehicle>>'laserScanner');
				
					if (!(toLower(_simulation) in ["shotmissile","laserdesignate"]) && !((_laserlock==1) && (_hasscanner==1))) then {_denyaction=true;};
				};
			};
			case (_key in actionKeys "carForward"):
			{
				Local_KeyPressedForward=true;
			};
			case (_key in actionKeys "carFastForward"):
			{
				Local_KeyPressedForward=true;
			};
			case (_key in actionKeys "carSlowForward"):
			{
				Local_KeyPressedForward=true;
			};
			default{};
		};			
	};
};
_denyaction	
	
	
