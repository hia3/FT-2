if (isServer) then
{
	_victim=_this select 0;
	
	_damage_src = _victim getVariable["damage_src", []];
	_damage_val = _victim getVariable["damage_val", []];

	_full_award   = _victim getVariable "kill_award";
	_victim_side  = _victim getVariable "ft2_wf_side";
	_victim_owner = _victim getVariable ["owner_name", ""];
	if (_victim in (call Config_EastMHQ)) then { _victim_side = east };
	if (_victim in (call Config_WestMHQ)) then { _victim_side = west };

	_full_damage = 0;
	for "_i" from 0 to (count _damage_src) - 1 do
	{
		_attacker        = _damage_src select _i;
		_attacker_damage = _damage_val select _i;
	
		if !(isNull _attacker) then
		{
			_attacker_name = _attacker getVariable "playername";
			
			if (_victim_owner != _attacker_name) then
			{
				_full_damage = _full_damage + _attacker_damage;
			};
		};
	};

	for "_i" from 0 to (count _damage_src) - 1 do
	{
		_attacker        = _damage_src select _i;
		_attacker_damage = _damage_val select _i;
		
		if !(isNull _attacker) then
		{
			_attacker_side   = _attacker getVariable "ft2_wf_side";
			_attacker_name   = _attacker getVariable "playername";
			
			if (_victim_owner != _attacker_name) then
			{
				_attacker_award  = _full_award * (_attacker_damage / _full_damage);
				
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
				
				_attacker_award = floor(_attacker_award);
				
				_attacker_funds_name = format["FT2_WF_Funds_%1", _attacker_name]; 		
				_attacker_funds      = FT2_WF_Logic getVariable _attacker_funds_name;
				FT2_WF_Logic setVariable [_attacker_funds_name, _attacker_funds + _attacker_award, true];
				
				_message = if (_victim isKindOf "Man") then { "message_kill_infantry" } else { "message_destroy_vehicle" };
				
				_attacker setVariable [_message, _attacker_award, true];
			};
		};		
	};

	_victim setVariable ["damage_src", []];
	_victim setVariable ["damage_val", []];
};
