	//compile items list from several sensors
	//see Func_Client_CheckPointCaptured

	private ["_list"];
	_list=[];
	{
		_l = list _x;
		if !(isNil "_l") then
		{
			_list=_list + _l;
		};
	} forEach _this;
	_list;
	