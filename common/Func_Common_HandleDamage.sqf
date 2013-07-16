_veh     = _this select 0;
_section = _this select 1;
_src     = _this select 3;
_ammo    = _this select 4;

_prev_damage = damage _veh;

if ((_section == "") && (!(isNull _src)) && (_veh != _src) && (_ammo != "") && (_prev_damage <= 1)) then
{
	_dam = ((_this select 2) - _prev_damage);

	_ss = _veh getVariable ["damage_sources", []];
	_sv = _veh getVariable ["damage_values",  []];
	
	_attackers = crew _src;
	
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

		_veh setVariable ["damage_sources", _ss, true];
		_veh setVariable ["damage_values",  _sv, true];

		//[[_ss, _sv, _dam],"SMS_Func",nil,true] spawn BIS_fnc_MP;
	} forEach _attackers;
};

_this select 2;
