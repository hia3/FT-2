//marks friendly MHQ`s on the map

private["_mhq_marker_type"];
	
switch (Local_PlayerSide) do
{
	case east:{_mhq_marker_type = "o_hq";};
	case west:{_mhq_marker_type = "b_hq";};
	default {_mhq_marker_type = "mil_dot";};
};

_report_mhq_event = 
{
	private ["_mhq", "_event", "_hint_old_event"];
        
	_mhq = _this select 0;
	_event = _this select 1;

	_hint_old_event = _mhq getVariable "Local_MhqHintOldEvent";

	if (_hint_old_event != _event) then
	{
		private ["_message"];

		_message = localize _event;
		switch (_event) do
		{
			case "STR_HINT_MHQ_Moving":
			{
				_veh_driver = driver _x;
				_driver_name = if (!(isNull _veh_driver) && (alive _veh_driver)) then { name _veh_driver; } else { "" };

				_message = composeText [parseText format ["<t align='center' size='1' shadow='true'>%1</t><br/><t align='center' color='#e0e080' size='1.25' shadow='true'>%2</t>", _message, _driver_name]];
			};
			case "STR_HINT_MHQ_Water":
			{
				playSound "error_sound";
			};
			case "STR_HINT_MHQ_Destroyed":
			{
				playSound "mhq_down";
			};
		};

		hint _message;
		_mhq setVariable ["Local_MhqHintOldEvent", _event];
	};
};

_i=1;
{
	if (!isNull _x) then
	{
		//get MHQ marker
		//see client`s precompile.sqf
		_pos=position _x;
		_NameString=format["mhqMarker%1",_i];
		_NameString setMarkerPosLocal _pos;

		if (alive _x) then
		{
			_lastmovetime=0;
			if (((speed _x)>2) || (((getPosATL _x) select 2)>5)) then
			{
				//MHQ is moving
				_lastmovetime=time;
				_x setVariable ["lastmovetime",_lastmovetime];
			}
			else
			{
				//wait some time since MHQ stopped
				_lastmovetime=_x getVariable "lastmovetime";
				if (format ["%1",_lastmovetime]=="<null>") then {_lastmovetime=-Config_MHQStopTime};
			};

			if (!(surfaceIsWater _pos)) then
			{
				if ((time-_lastmovetime)>Config_MHQStopTime) then
				{
					//MHQ status: ready
					_NameString setMarkerColorLocal Local_FriendlyColor;
					_NameString setMarkerTypeLocal _mhq_marker_type;
					_NameString setMarkerSizeLocal [0.85,0.85];
					_NameString setMarkerTextLocal localize "STR_BASE_MHQ";

					[_x, "STR_HINT_MHQ_Deployed"] call _report_mhq_event;
				}
				else
				{
					//MHQ status: is moving
					_NameString setMarkerColorLocal "ColorBlack";
					_NameString setMarkerTypeLocal _mhq_marker_type;
					_NameString setMarkerSizeLocal [0.85,0.85];
					_NameString setMarkerTextLocal localize "STR_BASE_MHQ_Moving";

					[_x, "STR_HINT_MHQ_Moving"] call _report_mhq_event;
				};
			}
			else
			{
				//MHQ status: in water
				_NameString setMarkerColorLocal "ColorBlack";
				_NameString setMarkerTypeLocal _mhq_marker_type;
				_NameString setMarkerSizeLocal [0.85,0.85];
				_NameString setMarkerTextLocal localize "STR_BASE_MHQ_Water";

				[_x, "STR_HINT_MHQ_Water"] call _report_mhq_event;
			};
		}
		else
		{
			//MHQ status: in destroyed
			_NameString setMarkerColorLocal "ColorBlack";
			_NameString setMarkerTypeLocal _mhq_marker_type;
			_NameString setMarkerSizeLocal [0.85,0.85];
			_NameString setMarkerTextLocal localize "STR_BASE_MHQ_Destroyed";

			[_x, "STR_HINT_MHQ_Destroyed"] call _report_mhq_event;
		};
	};
	_i=_i+1;
} forEach ([] call Local_FriendlyMHQ);
