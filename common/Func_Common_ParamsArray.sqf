
Local_Param_Duration       = paramsArray select 0;
Local_Param_Daytime        = paramsArray select 1;
Local_Param_Weather        = paramsArray select 2;
Local_Param_ViewDistance   = paramsArray select 3;
Local_Param_ExternalView   = paramsArray select 4;
Local_Param_ScreenMarkers  = paramsArray select 5;
Local_Param_Armaments      = paramsArray select 6;
Local_Param_StartFund      = paramsArray select 7;
Local_Param_Halo           = paramsArray select 8;
Local_Param_Grass          = paramsArray select 9;
Local_Param_BicycleAtMHQ   = paramsArray select 10;
Local_Param_ThermalImaging = paramsArray select 11;

diag_log "waiting for Local_TS_description";
waitUntil{!(isNil "Local_TS_description")};
diag_log "got Local_TS_description";

if (Local_TS_description == "Mercenary") then
{
	Local_Param_ExternalView = 3;
	Local_Param_ScreenMarkers = 0;
	Local_Param_Halo = 0;
	Local_Param_BicycleAtMHQ = 0;
};

if (Local_TS_description == "Recruit") then
{
	Local_Param_ExternalView = 0;
	Local_Param_ScreenMarkers = 2;
	Local_Param_StartFund = Local_Param_StartFund * 2;
	Local_Param_Halo = 1;
	Local_Param_BicycleAtMHQ = 1;
	Local_Param_ThermalImaging = 1;
};
