	//compile items list from several sensors
	//see Func_Client_CheckPointCaptured

	private ["_list"];
	_list=[];
	{_list=_list+list _x;}forEach _this;
	_list;
	