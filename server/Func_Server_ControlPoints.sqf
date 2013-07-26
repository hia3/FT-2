/**/
	_ConvertToList=
	{
		private ["_result"];
		_result = [];
		{ _list = list _x; if !(isNil "_list") then { _result = _result + _list; }; } forEach _this;
		_result
	};

	_AddScore=
	{
		private["_unit","_SensorTaskList","_AwardValue"];

		_unit=_this select 0;
		_SensorTaskList=_this select 1;
		_AwardValue=_this select 2;

		if (_unit isKindOf "man") then
		{
			if (_unit in _SensorTaskList) then
			{
				_unit addScore(_AwardValue);
			}
			else
			{
				_unit addScore(round(_AwardValue) max 1);
			};
		}
		else
		{
			if (_unit in _SensorTaskList) then
			{
				{_x addScore(_AwardValue)} forEach (crew _unit);
			}
			else
			{
				{_x addScore(round(_AwardValue) max 1)} forEach (crew _unit);
			};
		};
	};

	_CountUnitsInList=
	{
		private ["_SensorTaskList","_side","_result"];
		_SensorTaskList=_this select 0;
		_side=_this select 1;

		_result=0;

		{
			if ((side _x)==_side) then
			{
				if (((getPosATL _x) select 2) < 20) then
				{
					if (_x isKindOf "man") then
					{
						_result=_result+1;
					}
					else
					{
						_result=_result+({alive _x} count crew _x);
					};
				};
			};
		} forEach _SensorTaskList;
		_result
	};

	_delay=0.9;

	while {!(Global_GameEnded)} do
	{
		{
			_MarkerTask=_x select 3;
			_SensorScore=_x select 6;
			_SensorTaskArray=_x select 7;
			_FlagTask=_x select 8;
			_UnitsCount=_x select 9;
			_TimeStep=_x select 10;
			_BonusForCapture=_x select 11;
			_BonusForHold=_x select 12;
			_AwardValue=_x select 13;

			_SensorTaskList=_SensorTaskArray call _ConvertToList;
			_east=[_SensorTaskList,east] call _CountUnitsInList;
			_west=[_SensorTaskList,west] call _CountUnitsInList;
			_ownerside=(_FlagTask select 0) getVariable "owner_side";
			_timing=0;

			if ((_east >= _UnitsCount) && (_west == 0) && (_ownerside != "east")) then
			{
				_timing=(_FlagTask select 0) getVariable "flag_timing_east";
				if (_timing > _TimeStep) then
				{
					_SideScore=Config_EastBaseFlag getVariable "score";

					if (((_FlagTask select 0) getVariable "last_owner_side")=="east") then
					{
						Config_EastBaseFlag setVariable ["score",_SideScore+round(_BonusForCapture*0.5),true];
					}
					else
					{
						Config_EastBaseFlag setVariable ["score",_SideScore+_BonusForCapture,true];
					};

					(_FlagTask select 0) setVariable ["flag_timing_award",0,false];
					(_FlagTask select 0) setVariable ["flag_timing_east",0,false];
					(_FlagTask select 0) setVariable ["owner_side","east",false];
					(_FlagTask select 0) setVariable ["last_owner_side","east",false];

					_MarkerTask setMarkerColor Config_EastColor;
					if (Config_EastFlagTexture != "") then
					{
						{_x setFlagTexture Config_EastFlagTexture}forEach _FlagTask;
					};
					{
						if((side _x)==east)then
						{
							[_x,_SensorTaskList,_AwardValue] call _addscore;
						};
					}forEach (list _SensorScore);
				}
				else
				{
					(_FlagTask select 0) setVariable ["flag_timing_east",_timing+_delay,false];
				};
				(_FlagTask select 0) setVariable ["flag_timing_west",0,false];
			}
			else
			{
				if ((_east == 0) && (_west >= _UnitsCount) && (_ownerside != "west")) then
				{
					_timing=(_FlagTask select 0) getVariable "flag_timing_west";
					if (_timing > _TimeStep) then
					{
						_SideScore=Config_WestBaseFlag getVariable "score";

						if (((_FlagTask select 0) getVariable "last_owner_side")=="west") then
						{
							Config_WestBaseFlag setVariable ["score",_SideScore+round(_BonusForCapture*0.5),true];
						}
						else
						{
							Config_WestBaseFlag setVariable ["score",_SideScore+_BonusForCapture,true];
						};

						(_FlagTask select 0) setVariable ["flag_timing_award",0,false];
						(_FlagTask select 0) setVariable ["flag_timing_west",0,false];
						(_FlagTask select 0) setVariable ["owner_side","west",false];
						(_FlagTask select 0) setVariable ["last_owner_side","west",false];

						_MarkerTask setMarkerColor Config_WestColor;
						if (Config_WestFlagTexture != "") then
						{
							{_x setFlagTexture Config_WestFlagTexture}forEach _FlagTask;
						};
						{
							if((side _x)==west)then
							{
								[_x,_SensorTaskList,_AwardValue] call _addscore;
							};
						}forEach (list _SensorScore);
					}
					else
					{
						(_FlagTask select 0) setVariable ["flag_timing_west",_timing+_delay,false];
					};
					(_FlagTask select 0) setVariable ["flag_timing_east",0,false];
				}
				else
				{
					if ((_east > 0) && (_west > 0) && (_ownerside != "enemy")) then
					{
						_MarkerTask setMarkerColor Config_IndepColor;
						{_x setFlagTexture Config_IndepFlagTexture}forEach _FlagTask;

						(_FlagTask select 0) setVariable ["owner_side","enemy",false];
						(_FlagTask select 0) setVariable ["flag_timing_award",0,false];
						(_FlagTask select 0) setVariable ["flag_timing_east",0,false];
						(_FlagTask select 0) setVariable ["flag_timing_west",0,false];
					}
					else
					{
						if ((_east == 0) && (_west == 0) && (_ownerside == "enemy")) then
						{
							_MarkerTask setMarkerColor Config_NeutralColor;
							{_x setFlagTexture Config_NeutralFlagTexture}forEach _FlagTask;

							(_FlagTask select 0) setVariable ["owner_side","none",false];
							(_FlagTask select 0) setVariable ["last_owner_side","none",false];
							(_FlagTask select 0) setVariable ["flag_timing_award",0,false];
							(_FlagTask select 0) setVariable ["flag_timing_east",0,false];
							(_FlagTask select 0) setVariable ["flag_timing_west",0,false];
						}
						else
						{
							if ((_east == 0) && (_west == 0)) then
							{
								(_FlagTask select 0) setVariable ["flag_timing_east",0,false];
								(_FlagTask select 0) setVariable ["flag_timing_west",0,false];
							}
						};
					};
				};
			};

			_timing=(_FlagTask select 0) getVariable "flag_timing_award";
			if (_timing >= 15) then
			{
				(_FlagTask select 0) setVariable ["flag_timing_award",0,false];
				switch ((_FlagTask select 0) getVariable "owner_side") do
				{
					case "east":
					{
						_SideScore=Config_EastBaseFlag getVariable "score";
						Config_EastBaseFlag setVariable ["score",_SideScore+_BonusForHold,true];
					};
					case "west":
					{
						_SideScore=Config_WestBaseFlag getVariable "score";
						Config_WestBaseFlag setVariable ["score",_SideScore+_BonusForHold,true];
					};
					default{};
				};
			}
			else
			{
				(_FlagTask select 0) setVariable ["flag_timing_award",_timing+_delay,false];
			};

		} forEach Config_TotalCheckPointData;
		sleep _delay;
	};

