private ["_inventory", "_result"];

_inventory = _this;

_result = [];

{
	if ((_inventory select _x) != "") then { _result = _result + [_inventory select _x] };
} forEach [1, 4, 7, 11, 13, 15, 17];


{
	if (count (_inventory select _x) != 0) then { _result = _result + (_inventory select _x) };
} forEach [2, 5, 8, 10];

{
	private ["_weapon_items", "_i"];

	_weapon_items = _inventory select _x;

	for [{_i=0},{_i<3},{_i=_i+1}] do
	{
		if ((_weapon_items select _i) != "") then { _result = _result + [_weapon_items select _i] };
	};


	{
		private ["_magazine"];
		_magazine = _x select 1;
		if (_magazine != "") then { _result = _result + [_magazine]; };
	} forEach (_weapon_items select 3);
	
} forEach [14, 16, 18];

_result
