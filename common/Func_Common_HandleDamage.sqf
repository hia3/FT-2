_veh = _this select 0;

if (isServer) then
{
	//diag_log ["Func_Common_HandleDamage", _this];

	_src = _this select 1;
	_dam = _this select 2;

	//diag_log ["_src, _dam", _src, _dam];

	if ((!(isNull _src)) && (_veh != _src)) then
	{
		_ss = _veh getVariable ["damage_sources", []];
		_sv = _veh getVariable ["damage_values",  []];

		//diag_log ["_ss, _sv", _ss, _sv];
		
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

			//diag_log ["_attacker, _idx, _sum, _ss, _sv", _attacker, _idx, _sum, _ss, _sv];

		} forEach (crew _src);
	};
};
