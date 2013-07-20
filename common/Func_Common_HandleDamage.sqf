if (isServer) then
{
	_veh = _this select 0;
	_src = _this select 1;
	_dam = _this select 2;
	
	if ((!(isNull _src)) && ((vehicle _veh) != (vehicle _src))) then
	{
		_damage_src = _veh getVariable["damage_src", []];
		_damage_val = _veh getVariable["damage_val", []];
		
		{
			_attacker = _x;

			_idx = _damage_src find _attacker;

			_sum = 
		
			if (_idx == -1) then
			{
				_idx = count _damage_src;
				_dam
			}
			else
			{
				(_damage_val select _idx) + _dam
			};

			_damage_src set [_idx, _attacker];
			_damage_val set [_idx, _sum min 1];
			
			_veh setVariable ["damage_src", _damage_src];
			_veh setVariable ["damage_val", _damage_val];
		} forEach (crew _src);
	};
};
