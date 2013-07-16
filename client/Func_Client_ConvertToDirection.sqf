	//convert player direction to
	//letter it
	//see Func_Client_UpdateGUI

	private ["_a","_r"];
	
	_a=_this;
	_r="";	
	if(_a>=337.5||_a<22.5)then
	{
		_r=format [localize "STR_MOVE_N"];
	};
	if(_a>=292.5&&_a<337.5)then
	{
		_r=format [localize "STR_MOVE_NW"];
	};
	if(_a>=247.5&&_a<292.5)then
	{
		_r=format [localize "STR_MOVE_W"];
	};
	if(_a>=202.5&&_a<247.5)then
	{
		_r=format [localize "STR_MOVE_SW"];
	};
	if(_a>=157.5&&_a<202.5)then
	{
		_r=format [localize "STR_MOVE_S"];
	};
	if(_a>=112.5&&_a<157.5)then
	{
		_r=format [localize "STR_MOVE_SE"];
	};
	if(_a>=67.5&&_a<112.5)then
	{
		_r=format [localize "STR_MOVE_E"];
	};
	if(_a>=22.5&&_a<67.5)then
	{
		_r=format [localize "STR_MOVE_NE"];
	};
	_r
	