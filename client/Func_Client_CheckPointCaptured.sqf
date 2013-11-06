#include "defines.sqf"

	//function determines who is controlling a control point

	//randomize threads start on different CP`s
	sleep(5+random(5));

	while{!Global_GameEnded}do
	{


#ifndef FT2_DISABLE_STUFF1
		_total_west_captured_areas = 0;
		_total_east_captured_areas = 0;
		_total_capture_areas_count = count Config_TotalCheckPointData;

		for[{_i=0},{_i<_total_capture_areas_count},{_i=_i+1}] do
		{
			_MarkerTaskColor=markerColor((Config_TotalCheckPointData select _i)select 3);

			if (_MarkerTaskColor==Config_EastColor) then
			{
				_total_east_captured_areas=_total_east_captured_areas+1;
			}
			else
			{
				if (_MarkerTaskColor==Config_WestColor) then
				{
					_total_west_captured_areas=_total_west_captured_areas+1;
				};
			};
		};

		_area_capture_sound = if ((_total_capture_areas_count != 1) && ((_total_east_captured_areas == _total_capture_areas_count) || (_total_west_captured_areas == _total_capture_areas_count))) then { "area_capture_all" } else { "area_capture" };
#else
		_area_capture_sound = "area_capture";
#endif

		{
			_CheckPointName=localize (_x select 1);//displayname of checkpoint
			_MarkerTask=_x select 3;//big marker on checkpoint; see editor&config.sqf
			_SensorScore=_x select 6;//big sensor on checkpoint; see editor&config.sqf
			_SensorTaskArray=_x select 7;//array of flag sensors; see editor&config.sqf
			_flag=_x select 8;//array of flags; see editor&config.sqf
			_AwardValue=_x select 13;//personal score award for capture
			_AwardMoney=_x select 14;//personal funds award for capture
			_IncomeChanges=_x select 15;//income change when CP is captured

			_ColorOfSide=(_flag select 0) getVariable "owner_color";
			_message="";

			_MarkerColor=markerColor _MarkerTask;
			//if CP has changed its former color
			//see Func_Server_DetermineCheckPointOwner
			if(_ColorOfSide!=_MarkerColor)then
			{
				switch(_MarkerColor)do
				{
					//CP is captured by east
					case Config_EastColor:
					{
						//prepare and show hint message
						private ["_min_flag_distance"];
						_min_flag_distance = 10000;
						_message=format [localize "STR_CP_CapturedBy",Config_EastFactionName];
						if (isNull Local_Camera) then
						{
							//each flag on CP say "area_capture"
							{
								_x say [_area_capture_sound,1];
								sleep 0.75;
								_min_flag_distance = (player distance _x) min _min_flag_distance;
							} forEach _flag;
						};

						[_CheckPointName, _message, Config_EastSign, 1.0, (if (_min_flag_distance > 120) then { "area_capture_far" } else { "" })] call Func_Client_ShowCustomMessage;

						//if player is east
						if(Local_PlayerSide==east)then
						{
							//compile common list of flag sensors
							_SensorZone=_SensorTaskArray call Func_Client_ConvertToArray;
							//if player is inside this list
							//means he is one of persons who taken this CP
							if (((vehicle player) in _SensorZone) || (player in _SensorZone)) then
							{
								// award a full value of points and funds
								player sideChat format [localize "STR_CP_RadioMessageCaptured",_CheckPointName,_AwardValue,_AwardMoney];
								_AwardMoney call Func_Client_ChangePlayerFunds;
							}
							else
							{
								//else if player is not in flag zone
								//but inside the control point
								//we consider he just helped to capture
								//and give him half award
								if (((vehicle player) in (list _SensorScore)) || (player in (list _SensorScore))) then
								{
									player sideChat format [localize "STR_CP_RadioMessageHelped",_CheckPointName,(round(_AwardValue/2) max 1),round(_AwardMoney/2)];
									round(_AwardMoney/2) call Func_Client_ChangePlayerFunds;
								};
							};
							//change periodic income
							Config_PeriodicIncome=Config_PeriodicIncome+_IncomeChanges;
						}
						else
						{
							//if this CP was captured by another faction
							//then reset their periodic income
							if (_ColorOfSide==Config_WestColor) then
							{
								Config_PeriodicIncome=Config_PeriodicIncome-_IncomeChanges;
							};
						};
					};
					//CP is captured by west
					case Config_WestColor:
					{
						//prepare and show hint message
						private ["_min_flag_distance"];
						_min_flag_distance = 10000;
						_message=format [localize "STR_CP_CapturedBy",Config_WestFactionName];
						if (isNull Local_Camera) then
						{
							//each flag on CP say "area_capture"
							{
								_x say [_area_capture_sound,1];
								sleep 0.75;
								_min_flag_distance = (player distance _x) min _min_flag_distance;
							} forEach _flag;
						};

						[_CheckPointName, _message, Config_WestSign, 1.0, (if (_min_flag_distance > 120) then { "area_capture_far" } else { "" })] call Func_Client_ShowCustomMessage;

						//if player is west
						if(Local_PlayerSide==west)then
						{
							//compile common list of flag sensors
							_SensorZone=_SensorTaskArray call Func_Client_ConvertToArray;
							//if player is inside this list
							//means he is one of persons who taken this CP
							if (((vehicle player) in _SensorZone) || (player in _SensorZone)) then
							{
								// award a full value of points and funds
								player sideChat format [localize "STR_CP_RadioMessageCaptured",_CheckPointName,_AwardValue,_AwardMoney];
								_AwardMoney call Func_Client_ChangePlayerFunds;
							}
							else
							{
								//else if player is not in flag zone
								//but inside the control point
								//we consider he just helped to capture
								//and give him half award
								if (((vehicle player) in (list _SensorScore)) || (player in (list _SensorScore))) then
								{
									player sideChat format [localize "STR_CP_RadioMessageHelped",_CheckPointName,(round(_AwardValue/2) max 1),round(_AwardMoney/2)];
									round(_AwardMoney/2) call Func_Client_ChangePlayerFunds;
								};
							};
							//change periodic income
							Config_PeriodicIncome=Config_PeriodicIncome+_IncomeChanges;
						}
						else
						{
							//if this CP was captured by another faction
							//then reset their periodic income
							if (_ColorOfSide==Config_EastColor) then
							{
								Config_PeriodicIncome=Config_PeriodicIncome-_IncomeChanges;
							};
						};
					};
					//both east and west appear on CP
					case Config_IndepColor:
					{
						//prepare and show hint message
						private ["_min_flag_distance"];
						_min_flag_distance = 10000;
						_message=format [localize "STR_SIDE_Indep"];
						if (isNull Local_Camera) then
						{
							//each flag on CP say "area_draw"
							{
								_x say ["area_draw",1];
								sleep 0.75;
								_min_flag_distance = (player distance _x) min _min_flag_distance;
							} forEach _flag;
						};

						[_CheckPointName, _message, Config_IndepSign, 1.0, (if (_min_flag_distance > 120) then { "area_capture_far" } else { "" })] call Func_Client_ShowCustomMessage;

						if ((_ColorOfSide==Config_EastColor) && (Local_PlayerSide==east)) then
						{
							//if this CP was captured by east
							//then reset their periodic income
							Config_PeriodicIncome=Config_PeriodicIncome-_IncomeChanges;
						};
						if ((_ColorOfSide==Config_WestColor) && (Local_PlayerSide==west)) then
						{
							//if this CP was captured by east
							//then reset their periodic income
							Config_PeriodicIncome=Config_PeriodicIncome-_IncomeChanges;
						};
					};
					default{}
				};
				(_flag select 0) setVariable ["owner_color",_MarkerColor,false];
			};
		} forEach Config_TotalCheckPointData;
#ifndef FT2_DISABLE_STUFF1
		sleep 0.5;
#else
		sleep 10;
#endif
	};
