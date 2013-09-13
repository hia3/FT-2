/*_display = _this select 0;*/



Dialog_MenuAction = -1;

_lastAmmount=0;
_lastViewDistance=Local_ViewDistance;
_lastMarkersDistance=Dialog_ScreenMarkersDistance;
_lastSMT=Dialog_ScreenMarkersType;
_lastMMP=Dialog_MapMarkersPType;
_lastMMV=Dialog_MapMarkersVType;
_lastMMS=Dialog_MapMarkersSType;
_lastGS=Dialog_GUIType;
_lastGC=Dialog_GUIColor;
_lastAS=Dialog_AutosaveGearType;
_lastFunds=call Func_Client_GetPlayerFunds;

SliderSetRange[13003,1,paramsArray select 3];
SliderSetRange[13005,1,paramsArray select 3];
SliderSetRange[13015,0,_lastFunds];

SliderSetPosition[13003,Local_ViewDistance];
SliderSetPosition[13005,Dialog_ScreenMarkersDistance];

_i = 1;
{
	_name=_x getVariable "playername";
	if (((typeName _x)=="OBJECT") && !(isNil "_name")) then
	{
		_index=lbAdd[13016,Format ["[%1] %2",_i,_name]];
		lbSetData[13016,_index,_name];
		lbSetValue[13016,_index,_i-1];
	};
	_i = _i + 1;
} forEach Local_CurrentPlayers;
lbSetCurSel[13016,0];

for [{_i=0},{_i<=(paramsArray select 5)},{_i=_i+1}] do
{
	_str=localize format["STR_WF_SMType0%1",_i];
	_j=lbAdd[13007,_str];
	lbSetValue[13007,_j,_i];
};
lbSetCurSel[13007,_lastSMT];

for [{_i=0},{_i<2},{_i=_i+1}] do
{
	_str=localize format["STR_WF_MMPlayers0%1",_i];
	lbAdd[13009,_str];
};
lbSetCurSel[13009,_lastMMP];

for [{_i=0},{_i<4},{_i=_i+1}] do
{
	_str=localize format["STR_WF_MMVehicles0%1",_i];
	lbAdd[13011,_str];
};
lbSetCurSel[13011,_lastMMV];

for [{_i=0},{_i<2},{_i=_i+1}] do
{
	_str=localize format["STR_WF_MMObjects0%1",_i];
	lbAdd[13013,_str];
};
lbSetCurSel[13013,_lastMMS];


// populate Gui style combo box
for [{_i=0},{_i<4},{_i=_i+1}] do
{
	_str=localize format["STR_WF_GUIStyle0%1",_i];
	lbAdd[13006,_str];
};
lbSetCurSel[13006,_lastGS];

// populate Gui color combo box
for [{_i=0},{_i<5},{_i=_i+1}] do
{
	_str=localize format["STR_WF_GUIColor_C%1",_i];
	lbAdd[13017,_str];
};
lbSetCurSel[13017,_lastGC];




for [{_i=0},{_i<3},{_i=_i+1}] do
{
	_str=localize format["STR_WF_Autosave0%1",_i];
	lbAdd[13008,_str];
};
lbSetCurSel[13008,_lastAS];

ctrlSetText [13002, format [localize "STR_WF_ViewDistanceP",Local_ViewDistance]];
ctrlSetText [13004, format [localize "STR_WF_SMDistance",Dialog_ScreenMarkersDistance]];
ctrlSetText [13014, format [localize "STR_WF_Transfer",0]];

while {alive player && dialog} do
{
	if (!dialog) exitWith {};

	//_curSel = lbCurSel 13008;
	_currentVD = Floor (SliderPosition 13003);
	_currentMD = Floor (SliderPosition 13005);
	_transferAmount = Floor (SliderPosition 13015);
	_currentSMT=lbValue [13007,lbCurSel 13007];
	_currentMMP=lbCurSel 13009;
	_currentMMV=lbCurSel 13011;
	_currentMMS=lbCurSel 13013;

	_currentGS=lbCurSel 13006;
	_currentGC=lbCurSel 13017;

	_currentAS=lbCurSel 13008;
	_currentFunds=call Func_Client_GetPlayerFunds;

	if (_currentVD!=_lastViewDistance) then
	{
		ctrlSetText [13002, format [localize "STR_WF_ViewDistanceP",_currentVD]];
		Local_ViewDistance=_currentVD;
		_lastViewDistance=_currentVD;

		setViewDistance Local_ViewDistance;
	};

	if (_currentMD!=_lastMarkersDistance) then
	{
		ctrlSetText [13004, format [localize "STR_WF_SMDistance",_currentMD]];
		Dialog_ScreenMarkersDistance=_currentMD;
		_lastMarkersDistance=_currentMD;
	};

	if (_transferAmount!=_lastAmmount) then
	{
		ctrlSetText [13014, format [localize "STR_WF_Transfer",_transferAmount]];
		_lastAmmount=_transferAmount;
	};

	if (_currentSMT!=_lastSMT) then
	{
		_lastSMT=_currentSMT;
		Dialog_ScreenMarkersType=_currentSMT;
	};

	if (_currentMMP!=_lastMMP) then
	{
		_lastMMP=_currentMMP;
		Dialog_MapMarkersPType=_currentMMP;
	};

	if (_currentMMV!=_lastMMV) then
	{
		_lastMMV=_currentMMV;
		Dialog_MapMarkersVType=_currentMMV;
	};

	if (_currentMMS!=_lastMMS) then
	{
		_lastMMS=_currentMMS;
		Dialog_MapMarkersSType=_currentMMS;
		switch (_currentMMS) do
		{
			case 0:
			{
				_i=1;
				{
					_NameString=format ["ammoMarker%1",_i];
					_NameString setMarkerTextLocal "";
					_i=_i+1;
				} forEach ([] call Config_AmmoCrates);

				_i=1;
				{
					_NameString=format ["hospMarker%1",_i];
					_NameString setMarkerTextLocal "";
					_i=_i+1;
				} forEach ([] call Config_Hospitals);
			};
			case 1:
			{
				_i=1;
				{
					_NameString=format ["ammoMarker%1",_i];
					_NameString setMarkerTextLocal localize "STR_BASE_Ammo";
					_i=_i+1;
				} forEach ([] call Config_AmmoCrates);

				_i=1;
				{
					_NameString=format ["hospMarker%1",_i];
					_NameString setMarkerTextLocal localize "STR_BASE_Hosp";
					_i=_i+1;
				} forEach ([] call Config_Hospitals);
			};
			default{};
		};
	};

	// Gui sytle
	if (_currentGS!=_lastGS) then
	{
		_lastGS=_currentGS;
		Dialog_GUIType=_currentGS;
		Local_GUIRestart=true;
	};
	// gui color
	if (_currentGC!=_lastGC) then
	{
		_lastGC=_currentGC;
		Dialog_GUIColor=_currentGC;
		Local_GUIRestart=true;
	};


	if (_currentAS!=_lastAS) then
	{
		_lastAS=_currentAS;
		Dialog_AutosaveGearType=_currentAS;
	};

	if (_lastFunds!=_currentFunds) then
	{
		_lastFunds=_currentFunds;
		SliderSetRange[13015,0,_lastFunds];
	};

	if (Dialog_MenuAction==1) then
	{
		Dialog_MenuAction=-1;
		_index=lbCurSel 13016;
		_name=lbData [13016,_index];
		_index=lbValue [13016,_index];
		_unit=Local_CurrentPlayers select _index;
		if ((typeName _unit)=="OBJECT") then
		{
			if ((_transferAmount <= 0) || (_unit==player) || (_transferAmount > (call Func_Client_GetPlayerFunds))) exitWith {};
			if ((_unit getVariable "playername")==_name) then
			{
				_fundsname=format["FT2_WF_Funds_%1",_name];
				_funds = FT2_WF_Logic getVariable _fundsname;
				_funds=_funds+_transferAmount;
				FT2_WF_Logic setVariable[_fundsname,_funds,true];
				-_transferAmount call Func_Client_ChangePlayerFunds;

				["message_transfer_funds", [player getVariable "playername", _transferAmount], _unit] call Func_Common_SendRemoteCommand;

				[_name,format[localize "STR_HINT_FundsTransfered",_transferAmount],"pic\icon_funds.paa",1.35] call Func_Client_ShowCustomMessage;
			}
			else
			{
				[_name,localize "STR_HINT_FundsDenided","pic\no.paa",1.35,"error_sound"] call Func_Client_ShowCustomMessage;
			};
		}
		else
		{
			[_name,localize "STR_HINT_FundsDenided","pic\no.paa",1.35,"error_sound"] call Func_Client_ShowCustomMessage;
		};
	};

	if (Dialog_MenuAction==2) then
	{
		Dialog_MenuAction=-1;

		if (Local_PlayerVehicle!=player) exitWith {};

		_pos=getposATL player;
		_dir=getDir player;

		_nearest_objects = nearestObjects[player,["LandVehicle","Air","Ship"],8];
		
		if ((count _nearest_objects) == 0) then
		{
			[localize "STR_HINT_Warning",localize "STR_HINT_VehNotFliped","pic\no.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
		}
		else
		{		
			_veh=(_nearest_objects select 0);
			if (!(isNull _veh) && (_veh!=player) && (({alive _x} count crew _veh)==0)) then
			{
				_pic=getText(configFile>>"cfgVehicles">>(typeOf _veh)>>"picture");
				_name=getText(configFile>>"cfgVehicles">>(typeOf _veh)>>"displayName");
				[_name,localize "STR_HINT_VehFliped",_pic,1.0] call Func_Client_ShowCustomMessage;
				_veh setPos getPos _veh;
			};
		};
	};

	sleep 0.2;
};