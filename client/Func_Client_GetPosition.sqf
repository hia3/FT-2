	//calculate camera posotion
	//see Func_Client_CreateRotatingCamera

	private ["_target","_direction","_offset","_pos"];
	_target=_this select 0;
	_direction=_this select 1;
	_offset=_this select 2;
	_pos=[];
	_pos set [0,(_target select 0)+(sin _direction)*_offset];
	_pos set [1,(_target select 1)+(cos _direction)*_offset];
	_pos set [2,0];
	_pos
	