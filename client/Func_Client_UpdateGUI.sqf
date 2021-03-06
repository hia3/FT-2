//player GUI script
//the most shitty and unoptimized script in whole mission
//hate working with GUI

disableSerialization;
_display=uiNamespace getVariable "GUI";

Local_GUIActive=true;
Local_GUIRestart=false;

_position=getPos Local_PlayerVehicle;

//START: GPS, SCORE, FUNDS, PLAYERS
_log_info  = _display displayCtrl 6002;
_log_info_down = true;

_lowertext = _display displayCtrl 6003;

	_gps_map                   = _display displayCtrl 6039;
	_gps_background            = _display displayCtrl 6040;
	_gps_background_title      = _display displayCtrl 6041;
	_gps_background_title_dark = _display displayCtrl 6042;
	_gps_grid                  = _display displayCtrl 6043;
	_gps_time                  = _display displayCtrl 6044;
	_gps_heading               = _display displayCtrl 6045;

	_gps_controls = [_gps_map, _gps_background, _gps_background_title, _gps_background_title_dark, _gps_grid, _gps_time, _gps_heading];

_crewlist=_display displayCtrl 6004;
_playerslist=_display displayCtrl 6030;
_scorelist=_display displayCtrl   6031;
_fundslist=_display displayCtrl   6032;
//END: GPS, SCORE, FUNDS, PLAYERS


//START: OPTION ICONS
_opt0=_display displayCtrl 6005;
_opt1=_display displayCtrl 6006;
_opt2=_display displayCtrl 6007;
_opt3=_display displayCtrl 6008;
_opt4=_display displayCtrl 6009;
_opt5=_display displayCtrl 6010;
_opt6=_display displayCtrl 6011;
_opt7=_display displayCtrl 6012;
//END: OPTION ICONS

//START: HUMAN DAMAGE INDICATOR
_man=_display displayCtrl 6033;
_head=_display displayCtrl 6034;
_body=_display displayCtrl 6035;
_arms=_display displayCtrl 6036;
_legs=_display displayCtrl 6037;
//END: HUMAN DAMAGE INDICATOR

_dx=SafeZoneW+safeZoneX-0.245;
_dy=SafeZoneH+safeZoneY-0.2575;

_fundslist ctrlSetPosition [_dx-0.135,_dy+0.15];

//setting position: crew list, funds, players, score
_lowertext ctrlSetPosition [_dx,_dy+0.19];
_crewlist ctrlSetPosition [safeZoneX+0.025,SafeZoneY+0.5];
_playerslist ctrlSetPosition [safeZoneX+0.025,_dy+0.11];
_scorelist ctrlSetPosition [safeZoneX+0.155,_dy+0.11];

_enable_damage_indicator = (Dialog_GUIType in [2,3]);

//setting position: damage indicator
if (_enable_damage_indicator) then
{
	_man ctrlSetPosition [safeZoneX+0.04,SafeZoneY+0.04];
	_head ctrlSetPosition [safeZoneX+0.051,SafeZoneY+0.038];
	_body ctrlSetPosition [safeZoneX+0.04,SafeZoneY+0.0725];
	_arms ctrlSetPosition [safeZoneX+0.04,SafeZoneY+0.0725];
	_legs ctrlSetPosition [safeZoneX+0.04,SafeZoneY+0.125];
}else{
	_man ctrlSetPosition [safeZoneX-2,SafeZoneY-2];
	_head ctrlSetPosition [safeZoneX-2,SafeZoneY-2];
	_body ctrlSetPosition [safeZoneX-2,SafeZoneY-2];
	_arms ctrlSetPosition [safeZoneX-2,SafeZoneY-2];
	_legs ctrlSetPosition [safeZoneX-2,SafeZoneY-2];
};

_gps_common_x = profileNamespace getVariable ['IGUI_GRID_GPS_X', safezoneX + safezoneW - 10.5 * (((safezoneW / safezoneH) min 1.2) / 40)];
_gps_low_y    = (profileNamespace getVariable ['IGUI_GRID_GPS_Y', safezoneY + safezoneH - 15.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)]) + (((safezoneW / safezoneH) min 1.2) / 1.2) / 25;
_gps_common_w = profileNamespace getVariable ['IGUI_GRID_GPS_W', 10 * (((safezoneW / safezoneH) min 1.2) / 40)];
_gps_common_h = (profileNamespace getVariable ['IGUI_GRID_GPS_H', 10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)]) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
_gps_low_h    = 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
_gps_common_y = profileNamespace getVariable ['IGUI_GRID_GPS_Y', safezoneY + safezoneH - 15.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)];

_show_gps =
{
	private ["_is_visible", "_gps_x"];

	_should_visible = ((Dialog_GUIType in [1,3]) && ("ItemGPS" in assignedItems player));
	_is_visible = ctrlShown _gps_map;

	_gps_x = if (_should_visible) then { _gps_common_x } else { _gps_common_x + 10 };

	if ((_should_visible && !_is_visible) || (!_should_visible && _is_visible) || _this) then
	{
		_gps_map					ctrlSetPosition [_gps_x, _gps_low_y, _gps_common_w, _gps_common_h];
		_gps_background				ctrlSetPosition [_gps_x, _gps_low_y, _gps_common_w, _gps_common_h];
		_gps_background_title		ctrlSetPosition [_gps_x, _gps_common_y, _gps_common_w, _gps_low_h];
		_gps_background_title_dark	ctrlSetPosition [_gps_x, _gps_common_y, _gps_common_w, _gps_low_h];
		_gps_grid					ctrlSetPosition [_gps_x, _gps_common_y, _gps_common_w, _gps_low_h];
		_gps_time					ctrlSetPosition [_gps_x, _gps_common_y, _gps_common_w, _gps_low_h];
		_gps_heading				ctrlSetPosition [_gps_x, _gps_common_y, _gps_common_w, _gps_low_h];

		{
			_x ctrlCommit 0;
		} forEach _gps_controls;

		{
			_x ctrlShow _should_visible;
		} forEach _gps_controls;
	};
};

true call _show_gps;

switch (Dialog_GUIColor) do
{
	case 0: {Dialog_GUIColorActive = "#DDDDDD";}; // White
	case 1: {Dialog_GUIColorActive = "#ff0000";}; // Red
	case 2: {Dialog_GUIColorActive = "#00FF00";}; // Green
	case 3: {Dialog_GUIColorActive = "#0033cc";}; // Blue
	case 4: {Dialog_GUIColorActive = "#ffcc33";}; // Yellow
};

//applying changes
_lowertext ctrlCommit 0;
_crewlist ctrlCommit 0;
_scorelist ctrlCommit 0;
_playerslist ctrlCommit 0;
_fundslist ctrlCommit 0;
_man ctrlCommit 0;
_head ctrlCommit 0;
_body ctrlCommit 0;
_arms ctrlCommit 0;
_legs ctrlCommit 0;

	_gps_map_zoom_multiplier = getNumber(configfile >> "CfgWorlds" >> "Stratis" >> "mapSize") / getNumber(configfile >> "CfgWorlds" >> worldName >> "mapSize");
	_veh_real_speed = [0, 0, 0] distance (velocity Local_PlayerVehicle);
	_gps_map ctrlMapAnimAdd [0,(_veh_real_speed+8) / 200 * _gps_map_zoom_multiplier,_position];
	ctrlMapAnimCommit _gps_map;

//some auxiliary variables
_TimerG=0;
_TimerC=0;
_TimerO=0;
_TimerP=0;
_TimerD=0;
_TimerL=0;
_lastdam=0;
_playerInVehicle=false;
_updatedam=true;


//run screenMarkers
[Func_Client_UpdateOSD] call Func_Common_Spawn;

while{!Global_GameEnded&&!visibleMap&&Local_GUIActive&&(alive player)&&!Local_GUIRestart}do
{
	_timing=time;
	_position=getPos Local_PlayerVehicle;

	if(_TimerG<=_timing) then
	{
		_TimerG = _timing + 0.5;

		false call _show_gps;

		if ((Dialog_GUIType in [1,3]) && ("ItemGPS" in assignedItems player)) then
		{
			//GPS on
			_veh_real_speed = [0, 0, 0] distance (velocity Local_PlayerVehicle);
			_gps_map ctrlMapAnimAdd [0.5, (_veh_real_speed + 12) / 200 * _gps_map_zoom_multiplier, _position];

			ctrlMapAnimCommit _gps_map;

			_gps_grid ctrlSetText     (mapGridPosition Local_PlayerVehicle);
			_gps_heading ctrlSetText str (floor direction Local_PlayerVehicle);
			_gps_time ctrlSetText     ([daytime * 60 * 60, "HH:MM"] call BIS_fnc_secondsToString);

		};

		if (Param_RoundDuration >= _timing) then
		{
			_lowertext ctrlSetStructuredText
				parseText
					format
					[
						'<t align="left" color="%3" size="1.4" shadow="true">%1 %2</t>',
						localize "STR_DLG_GPSTime",
						[Param_RoundDuration - _timing, true] call Func_Client_ConvertToTime,
						Dialog_GUIColorActive
					];
		}
		else
		{
			_lowertext ctrlSetStructuredText parseText "";
		};
	};

	//---VEHICLE-CREW-START---
	if(_TimerC<=_timing)then
	{
		_TimerC=_timing+1;
		_ParsedText="";

		if((alive player) && (alive Local_PlayerVehicle) && (player!=Local_PlayerVehicle)) then
		{
			_crew=crew Local_PlayerVehicle;
			{
				if (!isNull _x) then
				{
					_is_commander = (_x == commander Local_PlayerVehicle);
					_is_driver    = (_x == driver Local_PlayerVehicle);
					_is_gunner    = (_x == gunner Local_PlayerVehicle);
					_is_cargo     = (!_is_commander && !_is_driver && !_is_gunner);

					_pic = "getincargo_ca.paa";
					_color = "#EEEEEE";
					if (_is_commander) then
					{
						_pic = "getincommander_ca.paa";
						_color = "#AAAAFF";
					};
					if (_is_driver) then
					{
						_pic = "getindriver_ca.paa";
						_color = "#88FF88";
					};
					if (_is_gunner) then
					{
						_pic = "getingunner_ca.paa";
						_color = "#FF8888";
					};

					_ParsedText=_ParsedText+format ["<t size='1.5'><img image='\A3\ui_f\data\igui\cfg\actions\%1'></t> <t size='1.35' shadow='true' color='%2'>%3</t><br/>",_pic, _color, _x getVariable "playername"];
				};
			}forEach _crew;
		};
		_crewlist ctrlSetStructuredText parseText _ParsedText;
	};
	//---VEHICLE-CREW-END---

	//---OPTIONS-START---
	if(_TimerO<=_timing)then
	{
		_TimerO=_timing+0.75;
		_t0="";
		_t1="";
		_t2="";
		_t3="";
		_t4="";
		_t5="";
		_t6="";
		_t7="";

		switch (Local_PlayerInSafeZone) do
		{
			case 2:
			{
				_t0="pic\icon_fire.paa";
			};
			case 1:
			{
				_t0="pic\icon_danger.paa";
			};
		};

		if (((({((Local_PlayerVehicle distance _x) <= Config_SupplyVehicleRange) && (alive _x)} count nearestobjects [Local_PlayerVehicle,Local_FriendlySupplyVehicleTypes,Config_SupplyVehicleRange]) > 0) || ((Local_PlayerVehicle distance Local_FriendlyBaseFlag)<Config_RespawnSize))) then
		{
			_t1="pic\icon_wf_building_gear_ca.paa";
		};
		if ((Local_PlayerVehicle distance Local_FriendlyBaseFlag)<Config_RespawnSize) then
		{
			_t2="pic\icon_wf_building_hvs_ca.paa";
		};
		if (((_timing-(player getVariable "enemytrack"))<Config_EnemyTrackTime)) then
		{
			_t6="pic\icon_warning.paa";
		};
		if (Local_PlayerVehicle!=player) then
		{
			if ((local Local_PlayerVehicle) && ((speed Local_PlayerVehicle)<5) && (((getPosATL Local_PlayerVehicle select 2) < 5) || (Local_PlayerVehicle isKindOf 'StaticWeapon')) && (({((Local_PlayerVehicle distance _x) < Config_ServiceVehicleRange) && (alive _x)} count nearestObjects [Local_PlayerVehicle,Local_FriendlyRepairVehicleTypes,Config_ServiceVehicleRange]>0) || ((Local_PlayerVehicle distance Local_FriendlyBaseFlag)<Config_RespawnSize))) then
			{
				_t3="pic\icon_wf_building_repair_ca.paa";
			};
			if (((local Local_PlayerVehicle) || (player==gunner Local_PlayerVehicle)) && ((speed Local_PlayerVehicle)<5) && (((getPosATL Local_PlayerVehicle select 2) < 5) || (Local_PlayerVehicle isKindOf 'StaticWeapon')) && (({((Local_PlayerVehicle distance _x) < Config_ServiceVehicleRange) && (alive _x)} count nearestObjects [Local_PlayerVehicle,Local_FriendlyReammoVehicleTypes,Config_ServiceVehicleRange]>0) || ((Local_PlayerVehicle distance Local_FriendlyBaseFlag)<Config_RespawnSize))) then
			{
				_t4="pic\icon_rearm.paa";
			};
			if ((local Local_PlayerVehicle) && ((speed Local_PlayerVehicle)<5) && (((getPosATL Local_PlayerVehicle select 2) < 5) || (Local_PlayerVehicle isKindOf 'StaticWeapon')) && (({((Local_PlayerVehicle distance _x) < Config_ServiceVehicleRange) && (alive _x)} count nearestObjects [Local_PlayerVehicle,Local_FriendlyRefuelVehicleTypes,Config_ServiceVehicleRange]>0) || ((Local_PlayerVehicle distance Local_FriendlyBaseFlag)<Config_RespawnSize))) then
			{
				_t5="pic\icon_fuel.paa";
			};
		};
		if !(player getVariable ["joied_ts", true]) then
		{
			_t7 = "pic\ts_not_connected.paa";
		};
		_opt0 ctrlSetText _t0;
		_opt1 ctrlSetText _t1;
		_opt2 ctrlSetText _t2;
		_opt3 ctrlSetText _t3;
		_opt4 ctrlSetText _t4;
		_opt5 ctrlSetText _t5;
		_opt6 ctrlSetText _t6;
		_opt7 ctrlSetText _t7;
	};
	//---OPTIONS-END---

	//---PLAYERS/SCORE/FUNDS-START---
	if(_TimerP<=_timing)then
	{
		_TimerP=_timing+1;
		if (((count units player)>1) && (player==leader player)) then
		{
			_ParsedText="";
			_playerslist ctrlSetStructuredText parseText _ParsedText;
			_scorelist ctrlSetStructuredText parseText _ParsedText;
		}else{
			_ParsedText=format ["<t size='1.75' align='left' shadow='true' color='%6'>%1:</t><br/><t size='1.5'><img image='%2'></t><t size='1.75' align='left' shadow='true' color='%6'> %3</t><br/><t size='1.5'><img image='%4'></t><t size='1.75' align='left' shadow='true' color='%6'> %5</t>",localize "STR_NAME_Players",Config_EastSign,playersNumber east,Config_WestSign,playersNumber west,Dialog_GUIColorActive];
			_playerslist ctrlSetStructuredText parseText _ParsedText;
			_ParsedText=format ["<t size='1.75' align='left' shadow='true' color='%6'>%1:</t><br/><t size='1.5'><img image='%2'></t><t size='1.75' align='left' shadow='true' color='%6'> %3</t><br/><t size='1.5'><img image='%4'></t><t size='1.75' align='left' shadow='true' color='%6'> %5</t>",localize "STR_NAME_Score",Config_EastSign,Config_EastBaseFlag getVariable "score",Config_WestSign,Config_WestBaseFlag getVariable "score",Dialog_GUIColorActive];
			_scorelist ctrlSetStructuredText parseText _ParsedText;
		};
		_ParsedText=format ["<t size='1.5'><img image='pic\icon_plus.paa'></t><t size='1.95' align='left' shadow='true' color='%4'>%1/%2</t><br/><t size='1.5'><img image='pic\icon_funds.paa'></t><t size='1.95' align='left' shadow='true' color='%4'>%3</t>",Config_PeriodicIncome,localize "STR_DLG_Min",[] call Func_Client_GetPlayerFunds,Dialog_GUIColorActive];
		_fundslist ctrlSetStructuredText parseText _ParsedText;
	};
	//---PLAYERS/SCORE/FUNDS-END---


	//---DAMAGE-INDICATOR-START---
	_dam=damage player;
	if (((((damage player)!=_lastdam) && (_TimerD<=_timing) && !_playerInVehicle) || _updatedam) && (Dialog_GUIType in [2,3])) then
	{
		_lastdam=_dam;
		_updatedam=false;
		_TimerD=_timing+0.3;

		_man ctrlSetText "pic\man.paa";

		if (_dam<0.05) then
		{
			Dialog_LegsHit=false;
			Dialog_ArmsHit=false;
			Dialog_BodyHit=false;
			Dialog_HeadHit=false;
		};
		if ((!Dialog_LegsHit) && (!Dialog_ArmsHit) && (!Dialog_BodyHit) && (!Dialog_HeadHit) && (_dam>0.2)) then
		{
			Dialog_BodyHit=true;
		};

		if (Dialog_HeadHit) then
		{
			_head ctrlSetText "pic\head.paa";
		}else{
			_head ctrlSetText "";
		};
		if (Dialog_BodyHit) then
		{
			_body ctrlSetText "pic\body.paa";
		}else{
			_body ctrlSetText "";
		};
		if ((handsHit player==1) || Dialog_ArmsHit) then
		{
			_arms ctrlSetText "pic\arms.paa";
		}else{
			_arms ctrlSetText "";
		};
		if (canstand player) then
		{
			if (Dialog_LegsHit) then
			{
				_legs ctrlSetText "pic\legs_y.paa";
			}else{
				_legs ctrlSetText "";
			};
		}else{
			_legs ctrlSetText "pic\legs_r.paa";
		};
	};

	if ((Local_PlayerVehicle!=player) && !_playerInVehicle) then
	{
		_playerInVehicle=true;
		_man ctrlSetText "";
		_body ctrlSetText "";
		_head ctrlSetText "";
		_legs ctrlSetText "";
		_arms ctrlSetText "";
	};

	if ((Local_PlayerVehicle==player) && _playerInVehicle) then
	{
		_playerInVehicle=false;
		_updatedam=true;
	};
	//---DAMAGE-INDICATOR-END---

	if (((count Local_LogInfoStrings) == 0) && !_log_info_down) then
	{
		_log_info ctrlSetPosition [0.2, SafeZoneY + SafeZoneH];
		_log_info_down = true;
		_log_info ctrlCommit 0;
	}
	else
	{
		if (((count Local_LogInfoStrings) != 0) && _log_info_down) then
		{
			_log_info ctrlSetPosition [0.2, SafeZoneY + SafeZoneH - 0.15];
			_log_info_down = false;
			_log_info ctrlCommit 3;
		};
	};

	if(_TimerL<=_timing) then
	{
		_TimerL = _TimerL + 5;

		if ((ctrlCommitted _log_info) && (!_log_info_down)) then
		{
			_log_info ctrlSetPosition [0.2, SafeZoneY + SafeZoneH - 0.15 + (ctrlTextHeight _log_info) / (count Local_LogInfoStrings) - 0.01];
			_log_info ctrlCommit 0;
			_log_info ctrlSetPosition [0.2, SafeZoneY + SafeZoneH - 0.15];
			_log_info ctrlCommit 1;

			[Local_LogInfoStrings] call BIS_fnc_arrayShift;
		};
	};

	_log_info ctrlSetStructuredText composeText Local_LogInfoStrings;
	Local_LogInfoStringsTimeShift = time;

	sleep 0.35;
};

1365 cutRsc ["MyDefault","plain"];
Local_GUIWorking=false;
