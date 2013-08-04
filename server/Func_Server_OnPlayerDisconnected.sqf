private ["_body"];

sleep 5;

_body = objNull;

{
	private ["_dead_name"];

	_dead_name = _x getVariable ["playername", ""];

	if (_dead_name == _this) exitWith { _body = _x; };
} forEach allDeadMen;

if !(isNull _body) then
{
	if !(alive _body) then
	{
		deleteVehicle _body;
	};
};

deleteMarker format ["body%1", _this];
