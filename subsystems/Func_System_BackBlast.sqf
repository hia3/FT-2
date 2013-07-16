/**/
_unit=_this select 0;

_pos=position _unit;
_maxdam=0.9;
_deviation=45;
_maxdist=10;
	
_men=(nearestObjects [_unit,["man"],_maxdist])-[_unit];
	
{
	_manpos=position _x;
	_px=(_manpos select 0) - (_pos select 0);
	_pz=(_manpos select 1) - (_pos select 1);
	_angletoman=_px atan2 _pz;
	if (_angletoman < 360) then {_angletoman=_angletoman+360};
	_angletoman=_angletoman-(getDir _unit);
	
	if ((_angletoman > (180-_deviation)) && (_angletoman < (180+_deviation))) then
	{
		_hands=false;
		if ((handsHit _x)==1) then {_hands=true};
		_legs=false;
		if (!(canStand _x)) then {_legs=true};
		
		_dist=_x distance _unit;
		_percent=((_maxdist-_dist)/(_maxdist));
		_dam=_maxdam*_percent;
		_x setDamage ((getDammage _x)+_dam);
		
		if (_hands) then {_x setHit ["Hands",1]};
		if (_legs) then {_x setHit ["Legs",1]};
		
		_x setVariable ["message_blast",player,true];
	};
	
} forEach _men;

	