_veh = _this select 0;

if (isServer) then
{
	["Func_Common_HandleDamage", _this] call Server_diag_log;

	_src = _this select 1;
	_dam = _this select 2;

	["_src, _dam", _src, _dam] call Server_diag_log;

	if ((!(isNull _src)) && (_veh != _src)) then
	{
		_ss = _veh getVariable ["damage_sources", []];
		_sv = _veh getVariable ["damage_values",  []];

		["_ss, _sv", _ss, _sv] call Server_diag_log;
		
		{
			_attacker = _x;
			
			_idx = _ss find _attacker;

			_sum = 
		
			if (_idx == -1) then
			{
				_idx = count _ss;
				_dam
			}
			else
			{
				(_sv select _idx) + _dam
			};

			_ss set [_idx, _attacker]; 
			_sv set [_idx, _sum min 1];

			_veh setVariable ["damage_sources", _ss];
			_veh setVariable ["damage_values",  _sv];

			["_attacker, _idx, _sum, _ss, _sv", _attacker, _idx, _sum, _ss, _sv] call Server_diag_log;

		} forEach (crew _src);
	};
};
