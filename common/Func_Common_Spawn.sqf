private ["_result", "_code", "_code_str", "_params"];

if (isNil "Local_RunningTasks") then
{
	Local_RunningTasks = [];

	[] spawn
	{
		while {!Global_GameEnded} do
		{
			sleep 30;

			{
				private ["_desc", "_handle", "_code"];

				_desc = _x;
					_handle  = _desc select 0;
					//_code    = _desc select 1;
					//_state   = _desc select 2;
				_desc set [2, scriptDone _handle];
			} forEach Local_RunningTasks;
		};
	};
};

_code = _this select 0;
_code_str = [str _code, 0, 10] call BIS_fnc_trimString;

if (1 == (count _this)) then
{
	_result = _code spawn { call _this };
}
else
{
	_params = _this select 1;

	_result = _params spawn _code;
};

Local_RunningTasks set [count Local_RunningTasks, [_result, _code_str, scriptDone _result]];

_result
