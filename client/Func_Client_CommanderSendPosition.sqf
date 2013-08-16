private ["_crew_member", "_coordinate", "_function", "_result"];
			
_crew_member = _this select 0;
_coordinate  = _this select 1;
_function    = _this select 2;

_result = if (isNull _crew_member) then { [] } else { [BIS_fnc_MP, [_coordinate, _function, _crew_member]] call Func_Common_Spawn; _coordinate };

_result
