if (isServer) then
{
	_side_color =
	{
		switch (_this) do
		{
			case east:
			{
				"#ff0000"
			};
			case west:
			{
				"#0000ff"
			};
			default
			{
				"#00ff00"
			};
		};
	};

	_format_name_side =
	{
		private ["_name", "_side"];
		_name = _this select 0;
		_side = _this select 1;

		format ["<t color='%1'>%2</t>", _side call _side_color, _name];
	};

	_victim = _this select 0;

	_damage_src = _victim getVariable["damage_src", []];
	_damage_val = _victim getVariable["damage_val", []];

	_full_award   = _victim getVariable ["kill_award", 1];

	_victim_name = if (_victim isKindOf "Man") then { _victim getVariable ["playername", "***UNKNOWN***"] } else { getText(configFile >> "CfgVehicles" >> (typeOf _victim) >> "displayName") };
	_victim_side  = _victim getVariable ["ft2_wf_side", civilian];
	_victim_owner = _victim getVariable ["owner_name", ""];

	if (_victim in (call Config_EastMHQ)) then { _victim_side = east };
	if (_victim in (call Config_WestMHQ)) then { _victim_side = west };

	_full_damage = 0;
	_attacker_count = 0;
	
	_data_size = ((count _damage_src) min (count _damage_val));
	
	for "_i" from 0 to _data_size - 1 do
	{
		_attacker        = _damage_src select _i;
		_attacker_damage = _damage_val select _i;

		if !(isNull _attacker) then
		{
			_attacker_name = _attacker getVariable ["playername", "***UNKNOWN***"];

			if (_victim_owner != _attacker_name) then
			{
				_full_damage = _full_damage + _attacker_damage;
				_attacker_count = _attacker_count + 1;
			};
		};
	};

	_text = ([_victim_name, _victim_side] call _format_name_side) + (if (_victim isKindOf "Man") then { " was killed " } else { " was destroyed " });
	
	_one_attacker = (_attacker_count == 1);

	for "_i" from 0 to _data_size - 1 do
	{
		_attacker        = _damage_src select _i;
		_attacker_damage = _damage_val select _i;

		if !(isNull _attacker) then
		{
			_attacker_side   = _attacker getVariable ["ft2_wf_side", civilian];
			_attacker_name   = _attacker getVariable ["playername", "***UNKNOWN***"];

			if (_victim_owner != _attacker_name) then
			{
				if (_i == 0) then
				{
					_text = _text + "by " + (if (_one_attacker) then {""} else {"["});
				};
			
				_attacker_award  = _full_award * (_attacker_damage / _full_damage);

				_attacker_damage_percent = floor (100 * _attacker_damage / _full_damage);

				if (_attacker_side == _victim_side) then
				{
					_attacker_award= -_attacker_award * 2;
				}
				else
				{
					if (!(_attacker getVariable ["joied_ts", true])) then
					{
						_attacker_award = _attacker_award * Config_TS3FundsModifier;
					};
				};

				_attacker_award = floor(_attacker_award);
				
				_text = _text + ([_attacker_name, _attacker_side] call _format_name_side) + "(" + (str _attacker_award) + "$" + (if (_one_attacker) then { "" } else { " = " + (str _attacker_damage_percent) + "%1" }) + ")";

				_attacker_funds_name = format["FT2_WF_Funds_%1", _attacker_name];
				_attacker_funds      = FT2_WF_Logic getVariable _attacker_funds_name;
				FT2_WF_Logic setVariable [_attacker_funds_name, _attacker_funds + _attacker_award, true];

				_message = if (_victim isKindOf "Man") then { "message_kill_infantry" } else { "message_destroy_vehicle" };
				[_message, _attacker_award, _attacker] call Func_Common_SendRemoteCommand;
				
				if ((_data_size - 1) == _i) then
				{
					_text = _text + (if (_one_attacker) then {""} else {"]"});
				}
				else
				{
					_text = _text + ", ";
				};

			};
		};
	};
	
	_text = _text + "<br/>";

	["log_info_message", "[""" + _text + """, '%']", true] call Func_Common_SendRemoteCommand;

	_victim setVariable ["damage_src", []];
	_victim setVariable ["damage_val", []];
};
