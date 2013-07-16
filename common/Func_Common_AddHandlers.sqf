_veh = _this;

_veh addEventHandler['killed',       "_this call Func_Common_DestroyUnitAward"];
_veh addEventHandler['HandleDamage', "_this call Func_Common_HandleDamage"];    

if (false) then
{

_veh addEventHandler
[
	'GetIn', 

	{
		private ["_veh", "_handlers_set", "_killed_handler_index", "_damage_handler_index"];
	
		_veh          = _this select 0;
		_handlers_set = _veh getVariable ["handlers_set", 0];
		_veh setVariable ["handlers_set", _handlers_set + 1, true];
		
		if (_handlers_set == 0) then
		{
			_killed_handler_index = _veh addEventHandler['killed',       "_this call Func_Common_DestroyUnitAward"];
			_damage_handler_index = _veh addEventHandler['HandleDamage', "_this call Func_Common_HandleDamage"];
			
			_veh setVariable ["killed_handler_index", _killed_handler_index, true];
			_veh setVariable ["damage_handler_index", _damage_handler_index, true];
		};
	}
];

_veh addEventHandler
[
	'GetOut', 

	{
		private ["_veh", "_handlers_set"];
	
		_veh = _this select 0;
		
		_handlers_set = _veh getVariable ["handlers_set", 0];
		_veh setVariable ["handlers_set", _handlers_set - 1, true];
		
		if (_handlers_set == 1) then
		{
			_killed_handler_index = _veh getVariable ["killed_handler_index", -1];
			_damage_handler_index = _veh getVariable ["damage_handler_index", -1];
			if (_killed_handler_index != -1) then { _veh removeEventHandler ['killed',       _killed_handler_index] };
			if (_damage_handler_index != -1) then { _veh removeEventHandler ['HandleDamage', _damage_handler_index] };
			_veh setVariable ["killed_handler_index", -1, true];
			_veh setVariable ["damage_handler_index", -1, true];
		};
	}
];

};
