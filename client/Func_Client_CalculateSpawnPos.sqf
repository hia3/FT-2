//function calculates player respawn position
//not to place him inside a building

private ["_Place","_is_big_object","_Pos0","_Pos1000","_Attempt","_Object","_x","_y","_a","_b"];
//limit attempts number
_Attempt=512;
_Place=0;

_is_big_object = if ((count _this) > 3) then { _this select 3 } else { false };

if ((typeName(_this select 2))=="ARRAY") then
{
	_a=((_this select 2)select 0)/2;
	_b=((_this select 2)select 1)/2;
	_b=_b-_a;
}else{
	_a=0;
	_b=(_this select 2)/2;
};
	
while{_Place<_Attempt}do
{
	_x=random(_b) + _a;
	_y=random(_b) + _a;
	
	if(random(2)>1)then
	{
		_x=-_x
	};
	if(random(2)>1)then
	{
		_y=-_y
	};
	_Pos0=[(_this select 0)+_x,(_this select 1)+_y,0];
	_Pos1000=[(_this select 0)+_x,(_this select 1)+_y,1000];
	_Object=nearestObjects [_Pos0,["ALLVEHICLES","STATIC","THING"],10];
	_Object_above = str lineIntersectsWith [_Pos1000, _Pos0];
	_is_inside_rock = ((["rock", _Object_above] call BIS_fnc_inString) || (["stone", _Object_above] call BIS_fnc_inString));
	_fences_nearby = if (_is_big_object) then { _fences = str nearestObjects [_Pos0, [], 10]; ({[_x, _fences] call BIS_fnc_inString } count ["stone_8m_f", "stone_pillar_f", "city_8m_f", "city2_8m_f", "mound01_8m_f", "sportground_fence_f"])>0 } else { false };
	if (((count _Object)<1) && !_is_inside_rock && !_fences_nearby) then
	{
		_Place=_Attempt;
	};
};

_Pos0
