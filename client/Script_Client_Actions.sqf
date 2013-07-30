switch((_this select 3)select 0)do
{
	case 0://cut with knife
	{
		_target=_this select 0;
		_pos=getposATL _target;
		_victim=nearestObject [[(_pos select 0)+1.5*sin(getDir _target),(_pos select 1)+1.5*cos(getDir _target), _pos select 2],"Man"];
		if ((_victim !=_target) && ((side _victim)==Local_EnemySide)) then
		{
			playSound3D ["A3\sounds_f\characters\human-sfx\Person0\P0_hit_01.wss", _victim];
			_victim setDamage 1;			
			
			_award=(Config_AwardKillPlayerValue*3);
			_target addScore 3;
			
			_award call Func_Client_ChangePlayerFunds;
			
			_target setVariable ["message_kill_infantry",_award];
			
			_victim setVariable ["message_knife",_target,true];
		};
	};
	case 1://switch on GPS
	{
		Local_GUIWorking=true;
		cutRsc ["RscOverlay","PLAIN",0];
	};
	case 2://switch off GPS
	{
		Local_GUIActive=false;
	};
	case 4://call main menu
	{
		createDialog "RscMenu";
	};
	case 5://lock-unlock a vehicle
	{
		(_this select 0) call Func_Client_LockUnlock;
	};
	case 6://field repair a vehicle
	{
		(_this select 0) call Func_Client_FieldRepairs;
	};
	case 7://bail out from a locked vehicle
	{
		player action ["eject",Local_PlayerVehicle];
	};
	case 8://repair a vehicle near repair truck
	{
		(_this select 0) spawn Func_Client_RepairVehicle;
	};
	case 9://remmo a vehicle near reammo truck
	{
		(_this select 0) spawn Func_Client_ReammoVehicle;
	};
	case 10://refuel a vehicle near refuel truck
	{
		(_this select 0) spawn Func_Client_RefuelVehicle;
	};
	case 11://take off an aircraft
	{
		[(_this select 0),true] spawn Func_Client_TakeOff;
	};
	case 12://land an aircraft
	{
		[(_this select 0),false] spawn Func_Client_TakeOff;
	};
	case 13://pick up a vehicle
	{		
		[_this select 0,(_this select 3) select 1] spawn Func_System_HeliCargoPick;
	};
	case 14://drop up a vehicle
	{
		System_HeliCargoTransportState=0;
	};
	case 15://push crew from private vehicle
	{
		(_this select 0) call Func_Client_PushCrew;
	};
	case 16://throw grenade into a tank
	{
		[] spawn Func_System_GrenadeIntoTank;
	};
	case 17://turn static weapon left
	{
		_veh=_this select 0;
		_dir=getDir _veh;
		_veh setDir (_dir-45);
		_veh setVelocity [0,0,10];
	};
	case 18://turn static weapon right
	{
		_veh=_this select 0;
		_dir=getDir _veh;
		_veh setDir (_dir+45);
		_veh setVelocity [0,0,10];
	};
	case 19://move static weapon
	{
		(_this select 0) spawn Func_Client_MoveStatic;
	};
	case 20://reload static weapon
	{
		_weapon=_this select 0;
		_name=getText (configFile >> "CfgVehicles" >> (typeOf _weapon) >> "DisplayName");
		
		_index=-1;
		{
			if (_weapon isKindOf _x) exitWith 
			{
				_index=_index+1;
			};
			_index=_index+1;
		} forEach System_LoadableStaticsTypes;
		
		if (_index >= 0) then
		{			
			_magazine="";
			_magazines=magazines player;
			{
				if (_x in _magazines) exitWith
				{
					_magazine=_x;
				};
			} forEach (System_LoadableStaticsDatas select _index);			
			
			if (_magazine=="") then
			{
				_str=localize "STR_HINT_MGReloadF";				
				{
					_str=_str+format["<br/><t color='#FFBD4C'>%1</t>",getText(configFile >> "CfgMagazines" >> _x >> "DisplayName")];
				} forEach (System_LoadableStaticsDatas select _index);
				
				[_name,_str,"pic\i_reammo_f.paa",1.0] call Func_Client_ShowCustomMessage;
			}
			else
			{
				player removeMagazine _magazine;
				
				_str=format[localize "STR_HINT_MGReloadS","<t color='#FFBD4C'>"+getText(configFile >> "CfgMagazines" >> _magazine >> "DisplayName")+"</t>"];
				[_name,_str,"pic\i_reammo_s.paa",1.0] call Func_Client_ShowCustomMessage;
				
				_magazine=getArray(configFile >> "CfgWeapons" >> ((weapons _weapon) select 0) >> "Magazines") select 0;
				_weapon addMagazine _magazine;
				
				player playMove "amovpercmstpsraswrfldnon_gear";
			};
		};		
	};
	case 21://start indirect fire mode
	{
		[] spawn Func_Client_ShowWeaponDirection;
	};
	case 22://stop indirect fire mode
	{
		Local_IndirectFireMode=false;
	};
	case 24://revive a player via backpack
	{
		player spawn Func_Client_ReviveRequest;
	};
	case 25://ignition off
	{
		Local_PlayerVehicle setVariable ["ignition_off",true,true];		
		Local_PlayerVehicle setVariable ["ignite_fuel",fuel Local_PlayerVehicle,true];
		Local_PlayerVehicle setFuel 0;		
	};
	case 26://ignition on
	{
		Local_PlayerVehicle setVariable ["ignition_off",false,true];		
		Local_PlayerVehicle setFuel (Local_PlayerVehicle getVariable "ignite_fuel");
	};
	case 28://high-climbing mode for tanks
	{
		Local_HighClimbingModeOn = !Local_HighClimbingModeOn;

		if (Local_HighClimbingModeOn) then
		{
			[] spawn Func_Client_LowGear;
		};
	};
	case 29://radar guidance switch for aa systems
	{
		Local_RadarGuidanceOn = !Local_RadarGuidanceOn;

		if (Local_RadarGuidanceOn) then
		{
			[] spawn Func_System_RadarAiming;
		};
	};
	case 30://Halo system from base
	{
		// we need to make a check on player to see if he has secondary weapons.
		createdialog "RscHaloMenu";
	};
	case 32://attach explosives to vehicle
	{
		[] spawn Func_System_AttachExplosives;
	};
	case 33:
	{
		Local_PlayerVehicle setVariable ["manualflare",true,true];
	};
	case 34:
	{
		Local_PlayerVehicle setVariable ["manualflare",false,true];
	};		
	case 35:
	{
		private ["_currentItem", "_currentCost", "_currentItem", "_vehiclecost", "_currentTime", "_currentName", "_currentPicture", "_vehicle"];

		_currentItem = if (Local_PlayerSide==west) then { "B_Quadbike_01_F" } else { "O_Quadbike_01_F" };

		_currentCost = 70;

		if (_currentCost <= (call Func_Client_GetPlayerFunds)) then
		{
			_currentName    = getText (configFile >> "CfgVehicles" >> _currentItem >> "DisplayName");
			_currentPicture = getText (configFile >> "CfgVehicles" >> _currentItem >> "picture");

			_currentTime = 30;

			_vehiclecost = _currentCost;
			
			_vehicle = [_currentItem, _vehiclecost, _currentTime, -2] call Func_Client_CreateCustomVehicle;
			_vehicle lock false;
			player moveInDriver _vehicle;
		
			-_currentCost call Func_Client_ChangePlayerFunds;

			[_currentName,localize "STR_HINT_VehicleBought", _currentPicture, 1.35] call Func_Client_ShowCustomMessage;
		}
		else
		{
			[localize "STR_HINT_Vehicles",localize "STR_HINT_LowFunds","pic\icon_funds.paa",1.35,"error_sound"] call Func_Client_ShowCustomMessage;
		};
	};			
};
