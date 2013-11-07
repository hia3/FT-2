	
Dialog_VehicleFiller="car";
Dialog_ScreenMarkersDistance = Local_Param_ViewDistance;
Dialog_ScreenMarkersType     = Local_Param_ScreenMarkers;//0-off,1-group,2-all
Dialog_MapMarkersVType=2;//0-show only map mark,1-with vehicle name,2-with name and delete time,3-with name, time and owner name
Dialog_MapMarkersPType=1;//0-only marks,1-with names
Dialog_MapMarkersSType=1;//0-only marks,1-with names	
Dialog_AutosaveGearType=0;//0-never,1-when respawn,2-allways;	

Dialog_GUITypeMax = if (Local_TS_description == "Mercenary") then { 0 } else { 3 };
Dialog_GUIType = Dialog_GUITypeMax; // 00-no health no gps, 01-no health, 10-no gps, 11-all
Dialog_GUIColor=0; // Default Gui color is almost white


Func_Dialog_CreateRespawnDialog=compile preprocessFile ("dialog\Func_Dialog_CreateRespawnDialog.sqf");
Func_Dialog_HandleGearDialog=compile preprocessFile ("dialog\Func_Dialog_HandleGearDialog.sqf");
Func_Dialog_HandleGroupsDialog=compile preprocessFile ("dialog\Func_Dialog_HandleGroupsDialog.sqf");
Func_Dialog_HandleHelpDialog=compile preprocessFile ("dialog\Func_Dialog_HandleHelpDialog.sqf");
Func_Dialog_HandleMainMenu=compile preprocessFile ("dialog\Func_Dialog_HandleMainMenu.sqf");
Func_Dialog_HandleOptionsDialog=compile preprocessFile ("dialog\Func_Dialog_HandleOptionsDialog.sqf");
Func_Dialog_HandleRespawnDialog=compile preprocessFile ("dialog\Func_Dialog_HandleRespawnDialog.sqf");
Func_Dialog_HandleVehiclesDialog=compile preprocessFile ("dialog\Func_Dialog_HandleVehiclesDialog.sqf");
Func_Dialog_MarkerAnim=compile preprocessFile ("dialog\Func_Dialog_MarkerAnim.sqf");
Func_Dialog_RespawnDialogClosed=compile preprocessFile ("dialog\Func_Dialog_RespawnDialogClosed.sqf");
Func_Dialog_SortByDistance=compile preprocessFile ("dialog\Func_Dialog_SortByDistance.sqf");
Func_Dialog_HandleParameters=compile preprocessFile ("dialog\Func_Dialog_HandleParameters.sqf");