	Private ["_markerColor","_markerName","_markerPosition","_markerSize","_markerType"];
	_markerName = _this select 0;
	_markerPosition = _this select 1;
	_markerType = _this select 2;
	_markerSize = _this select 3;
	_markerColor = _this select 4;

	deleteMarkerLocal _markerName;
	CreateMarkerLocal [_markerName,getMarkerPos _markerPosition];
	_markerName setMarkerTypeLocal _markerType;
	_markerName setMarkerColorLocal _markerColor;
	_markerName setMarkerSizeLocal [_markerSize,_markerSize];

	_direction = 0;
	_expand = true;
	Dialog_RespawnMarkerAnimation=true;

	while {(Dialog_RespawnMarkerAnimation) && (dialog)} do 
	{
		sleep 0.03;

		_direction = (_direction + 1) % 360;
		_markerName setMarkerPosLocal getMarkerPos _markerPosition;
		_markerName setMarkerDirLocal _direction;
		_markerName setMarkerSizeLocal [_markerSize,_markerSize];

		if (_markerSize > 1.2) then {_expand = false};
		if (_markerSize < 1) then {_expand = true};
		if (_expand) then {_markerSize = _markerSize + 0.02} else {_markerSize = _markerSize - 0.02};
	};

	deleteMarkerLocal _markerName;