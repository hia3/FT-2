	//when player respawns 
	//create rotating camera

	private ["_Target","_Direction","_DirectionIncrement","_Offset","_CameraAltitude","_position"];
	
	_Target=_this select 0;
	_Direction=_this select 1;
	_DirectionIncrement=_this select 2;
	_Offset=_this select 3;
	_CameraAltitude=_this select 4;
	
	Local_Camera camSetTarget _Target;
	_position=[_Target,_Direction,_Offset] call Func_Client_GetPosition;
	
	Local_Camera camSetPos [_position select 0,_position select 1,_CameraAltitude];
	Local_Camera camCommit 0;
	waitUntil{camCommitted Local_Camera};
	while{!Global_GameEnded&&(Dialog_RespawnState!="readytospawn")&&(Dialog_RespawnState!="revived")&&(alive player)}do
	{
		_Direction=_Direction+_DirectionIncrement;	
		_position=[_Target,_Direction,_Offset] call Func_Client_GetPosition;		
		Local_Camera camSetPos [_position select 0,_position select 1,_CameraAltitude];
		Local_Camera camCommit 1;
		waitUntil{camCommitted Local_Camera};
	};
