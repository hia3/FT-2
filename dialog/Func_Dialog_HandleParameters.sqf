
disableSerialization;
_display = _this select 0;

_pat0 = "";
_pat1 = "";
_pat2 = "";
_pat3 = "";
_pat4 = "";
_pat5 = "";
_pat6 = "";
_pat7 = "";
_pat8 = "";
_pat9 = "";
_pat10 = "";
_pat11 = "";

parameterIDC=[7000,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011];

switch(Local_Param_Duration) do 
{
	case 1800  : {_pat0 =  localize "STR_P_Duration30"};
	case 2700  : {_pat0 =  localize "STR_P_Duration45"};
	case 3600  : {_pat0 =  localize "STR_P_Duration60"};
	case 5400  : {_pat0 =  localize "STR_P_Duration90"};
	case 7200  : {_pat0 =  localize "STR_P_Duration120"};
	case 86400 : {_pat0 =  localize "STR_P_Duration1440"};
};


switch(Local_Param_Daytime) do 
{
	case 4.5 : {_pat1 = localize "STR_P_Time01"};
	case 7.0 : {_pat1 = localize "STR_P_Time02"};
	case 12.0 : {_pat1 = localize "STR_P_Time03"};
	case 18.5 : {_pat1 = localize "STR_P_Time04"};
	case 1.0 : {_pat1 = localize "STR_P_Time05"};
	case 99 : {_pat1 = localize "STR_P_Time06"};
};

switch(Local_Param_Weather) do 
{
	case 1.0 : {_pat2 = localize "STR_P_Weather01"};
	case 0.66 : {_pat2 = localize "STR_P_Weather02"};
	case 0.33 : {_pat2 = localize "STR_P_Weather03"};
	case 0 : {_pat2 = localize "STR_P_Weather04"};
	case -1 : {_pat2 = localize "STR_P_Weather05"};
};

if (Config_DisableWeatherChange) then
{
	_pat2 = localize "STR_P_Disable";
};

switch(Local_Param_ViewDistance) do 
{
	case  500  : {_pat3 = localize "STR_P_Distance00"};
	case  750  : {_pat3 = localize "STR_P_Distance01"};
	case 1000  : {_pat3 = localize "STR_P_Distance02"};
	case 1500  : {_pat3 = localize "STR_P_Distance03"};
	case 2500  : {_pat3 = localize "STR_P_Distance04"};
	case 3000  : {_pat3 = localize "STR_P_Distance05"};
	case 3500  : {_pat3 = localize "STR_P_Distance06"};
	case 4000  : {_pat3 = localize "STR_P_Distance07"};
	case 5000  : {_pat3 = localize "STR_P_Distance08"};
	case 7500  : {_pat3 = localize "STR_P_Distance09"};
	case 10000 : {_pat3 = localize "STR_P_Distance10"};
};


switch(Local_Param_ExternalView) do 
{
	case 0: {_pat4 = localize "STR_P_View01"};
	case 1: {_pat4 = localize "STR_P_View02"};
	case 2: {_pat4 = localize "STR_P_View03"};
	case 3: {_pat4 = localize "STR_P_View04"};
};


switch(Local_Param_ScreenMarkers) do 
{
	case 0 : {_pat5 = localize "STR_WF_SMType00"};
	case 1 : {_pat5 = localize "STR_WF_SMType01"};
	case 2 : {_pat5 = localize "STR_WF_SMType02"};
};


switch(Local_Param_Armaments) do 
{
	case 0 : {_pat6 = localize "STR_P_Armament01"};
	case 1 : {_pat6 = localize "STR_P_Armament02"};

};

_pat7 = "$" + (str Local_Param_StartFund);

switch(Local_Param_Halo) do 
{
	case 0: {_pat8 = localize "STR_P_Disable"};
	case 1: {_pat8 = localize "STR_P_Enable"};
};


switch(Local_Param_Grass) do 
{
	case 0: {_pat9 = localize "STR_P_Disable"};
	case 1: {_pat9 = localize "STR_P_Enable"};
};

switch(Local_Param_BicycleAtMHQ) do 
{
	case 0: {_pat10 = localize "STR_P_Disable"};
	case 1: {_pat10 = localize "STR_P_Enable"};
};

switch(Local_Param_ThermalImaging) do 
{
	case 0: {_pat11 = localize "STR_P_Disable"};
	case 1: {_pat11 = localize "STR_P_Enable"};
};

_fmt = "%1 %2";

(_display displayCtrl 7000) ctrlSetText format[_fmt, localize "STR_P_Duration",       _pat0];
(_display displayCtrl 7001) ctrlSetText format[_fmt, localize "STR_P_Time",           _pat1];
(_display displayCtrl 7002) ctrlSetText format[_fmt, localize "STR_P_Weather",        _pat2];
(_display displayCtrl 7003) ctrlSetText format[_fmt, localize "STR_P_Distance",       _pat3];
(_display displayCtrl 7004) ctrlSetText format[_fmt, localize "STR_P_View",           _pat4];
(_display displayCtrl 7005) ctrlSetText format[_fmt, localize "STR_P_Markers",        _pat5];
(_display displayCtrl 7006) ctrlSetText format[_fmt, localize "STR_P_Armament",       _pat6];
(_display displayCtrl 7007) ctrlSetText format[_fmt, localize "STR_P_StartFunds",     _pat7];
(_display displayCtrl 7008) ctrlSetText format[_fmt, localize "STR_P_Halo",           _pat8];
(_display displayCtrl 7009) ctrlSetText format[_fmt, localize "STR_P_Grass",          _pat9];
(_display displayCtrl 7010) ctrlSetText format[_fmt, localize "STR_P_BicycleAtMHQ",   _pat10];
(_display displayCtrl 7011) ctrlSetText format[_fmt, localize "STR_P_ThermalImaging", _pat11];
