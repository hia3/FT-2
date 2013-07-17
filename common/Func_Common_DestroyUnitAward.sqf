if (isServer) then
{
	//diag_log ["Func_Common_DestroyUnitAward", _this];

	_victim=_this select 0;

	_damage_sources = _victim getVariable ["damage_sources", []];
	_damage_values  = _victim getVariable ["damage_values",  []];

	//diag_log ["_damage_sources, _damage_values", _damage_sources, _damage_values];

	_full_award  = _victim getVariable "kill_award";
	_victim_side = _victim getVariable "ft2_wf_side";
	if (_victim in (call Config_EastMHQ)) then { _victim_side = east };
	if (_victim in (call Config_WestMHQ)) then { _victim_side = west };

	//diag_log ["_full_award, _victim_side", _full_award, _victim_side];

	_full_damage = 0;
	{
		_full_damage = _full_damage + _x;
	} forEach _damage_values;

	for "_i" from 0 to (count(_damage_sources) min (count _damage_values)) - 1 do
	{
		_attacker        = _damage_sources select _i;
		_attacker_damage = _damage_values  select _i;
		_attacker_side   = _attacker getVariable "ft2_wf_side";
		_attacker_name   = _attacker getVariable "playername";
		
		_attacker_award  = ceil(_full_award * (_attacker_damage / _full_damage));
		
		if (_attacker_side == _victim_side) then
		{
			_attacker_award= -_attacker_award * 2;
		}
		else
		{
			if (!(_attacker getVariable "joied_ts")) then
			{
				_attacker_award = _attacker_award * Config_TS3FundsModifier;
			};
		};
		
		_attacker_funds_name = format["FT2_WF_Funds_%1", _attacker_name]; 		
		_attacker_funds      = FT2_WF_Logic getVariable _attacker_funds_name;
		FT2_WF_Logic setVariable [_attacker_funds_name, _attacker_funds + _attacker_award, true];
		
		_message = if (_victim isKindOf "Man") then { "message_kill_infantry" } else { "message_destroy_vehicle" };
		
		_attacker setVariable [_message, _attacker_award, true];

		//diag_log ["_attacker, _attacker_damage, _attacker_side, _attacker_name, _attacker_award, _attacker_funds_name, _attacker_funds, _message", _attacker, _attacker_damage, _attacker_side, _attacker_name, _attacker_award, _attacker_funds_name, _attacker_funds, _message];
	};

	_victim setVariable ["damage_sources", []];
	_victim setVariable ["damage_values",  []];
};
