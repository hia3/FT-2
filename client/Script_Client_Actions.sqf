switch((_this select 3)select 0)do
{
	case 0://cut with knife
	{
		_killer = _this select 0;
		_pos=getposATL _killer;
		_victim=nearestObject [[(_pos select 0)+1.5*sin(getDir _killer),(_pos select 1)+1.5*cos(getDir _killer), _pos select 2],"Man"];

		if ((_victim != _killer) && ((side _victim) == Local_EnemySide)) then
		{
			Local_KnifedVictimNetId set [count Local_KnifedVictimNetId, netId _victim];

			playSound3D ["A3\sounds_f\characters\human-sfx\Person0\P0_hit_01.wss", _victim];
			_victim setDamage 1;

			_award = (Config_AwardKillPlayerValue*3);
			_killer addScore 3;

			_award call Func_Client_ChangePlayerFunds;

			["message_kill_infantry", _award,                           _killer] call Func_Common_SendRemoteCommand;
			["message_knife",         _killer getVariable "playername", _victim] call Func_Common_SendRemoteCommand;
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
		if (Local_PlayerVehicle isKindOf "Air") then
		{
			private ["_pos", "_vel", "_dir", "_d"];

			_pos = getPos Local_PlayerVehicle;
			_vel = velocity Local_PlayerVehicle;

			_dir = getDir Local_PlayerVehicle;

			_d = 1;

			player action ["eject",Local_PlayerVehicle];
			player setPos [(_pos select 0) - _d * (_vel select 0), (_pos select 1) - _d * (_vel select 1), (_pos select 2) - _d * (_vel select 2)];
			player setDir _dir;
		}
		else
		{
			player action ["eject",Local_PlayerVehicle];
		};
	};
	case 8://repair a vehicle near repair truck
	{
		[Func_Client_RepairVehicle, (_this select 0)] call Func_Common_Spawn;
	};
	case 9://remmo a vehicle near reammo truck
	{
		[Func_Client_ReammoVehicle, (_this select 0)] call Func_Common_Spawn;
	};
	case 10://refuel a vehicle near refuel truck
	{
		[Func_Client_RefuelVehicle, (_this select 0)] call Func_Common_Spawn;
	};
	case 11://take off an aircraft
	{
		[Func_Client_TakeOff, [(_this select 0),true]] call Func_Common_Spawn;
	};
	case 12://land an aircraft
	{
		[Func_Client_TakeOff, [(_this select 0),false]] call Func_Common_Spawn;
	};
	case 13://pick up a vehicle
	{
		[Func_System_HeliCargoPick, [_this select 0,(_this select 3) select 1]] call Func_Common_Spawn;
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
		[Func_System_GrenadeIntoTank, []] call Func_Common_Spawn;
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
		[Func_Client_MoveStatic, (_this select 0)] call Func_Common_Spawn;
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
		[Func_Client_ShowWeaponDirection, []] call Func_Common_Spawn;
	};
	case 22://stop indirect fire mode
	{
		Local_IndirectFireMode=false;
	};
	case 24://revive a player via backpack
	{
		[Func_Client_ReviveRequest, player] call Func_Common_Spawn;
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
			[Func_Client_LowGear, []] call Func_Common_Spawn;
		};
	};
	case 29://radar guidance switch for aa systems
	{
		Local_RadarGuidanceOn = !Local_RadarGuidanceOn;

		if (Local_RadarGuidanceOn) then
		{
			[Func_System_RadarAiming, []] call Func_Common_Spawn;
		};
	};
	case 30://Halo system from base
	{
		// we need to make a check on player to see if he has secondary weapons.
		createdialog "RscHaloMenu";
	};
	case 32://attach explosives to vehicle
	{
		[Func_System_AttachExplosives, []] call Func_Common_Spawn;
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
