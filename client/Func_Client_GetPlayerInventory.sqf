
_get_primary_weapon_items = 
{
	private ["_unit", "_items", "_result"];

	_unit = _this;

	_items = primaryWeaponItems _unit;

	_result = if (0 == (count _items)) then {["", "", ""]} else {_items};

	_result
};

_get_secondary_weapon_items = 
{
	private ["_unit", "_items", "_result"];

	_unit = _this;

	_items = secondaryWeaponItems _unit;

	_result = if (0 == (count _items)) then {["", "", ""]} else {_items};

	_result
};


_get_handgun_weapon_items = 
{
	private ["_unit", "_items", "_result"];

	_unit = _this;

	_items = handgunItems _unit;

	_result = if (0 == (count _items)) then {["", "", ""]} else {_items};

	_result
};

_weapon_to_simplest = 
{
	private ["_weapon", "_result", "_weapon_config", "_parents", "_i"];

	_weapon = _this;

	_result = "";

	if (_weapon != "") then
	{
		_weapon_config = configFile >> "CfgWeapons" >> _weapon;

		_parents = [_weapon] + ([_weapon_config, true] call BIS_fnc_returnParents);

		for [{_i=0},{_i<count _parents},{_i=_i+1}] do
		{
			private ["_parent", "_simplest_model"];

			_parent = _parents select _i;

			_simplest_model = !isClass(configFile >> "CfgWeapons" >> _parent >> "LinkedItems");

			if ((_simplest_model) && (_result == "")) then
			{
				_result = _parent;
			};
		};
	};
	
	_result
};

_get_weapon_magazines = 
{
	private ["_result", "_weapon", "_weapon_config", "_magazines"];

	_result = [];

	_weapon    = _this select 0;
	_magazines = _this select 1;
	
	if (_weapon != "") then
	{
		_weapon_config = configFile >> "CfgWeapons" >> _weapon;

		{
			private ["_muzzle_config", "_muzzle_compatible_magazines", "_loaded_magazine"];

			_muzzle_config               = if (_x == "this") then { _weapon_config } else { _weapon_config >> _x};
			_muzzle_string               = if (_x == "this") then { _weapon call _weapon_to_simplest } else { configName(_muzzle_config) };
			_muzzle_compatible_magazines = getArray(_muzzle_config >> "magazines");
						
			_loaded_magazine = "";
			{
				if (_x in _muzzle_compatible_magazines) exitWith
				{
					_loaded_magazine = _x;
				};
			} forEach _magazines;
			
			if (_loaded_magazine != "") then { _magazines = _magazines - [_loaded_magazine] };

			_result = _result + [[_muzzle_string, _loaded_magazine]];

		} forEach getArray(_weapon_config >> "muzzles");
	};
	
	_result
};

_primary_weapon_magazines = 
{
	private ["_target"];

	_target = _this;

	[primaryWeapon _target, primaryWeaponMagazine _target] call _get_weapon_magazines;
};

_secondary_weapon_magazines = 
{
	private ["_target"];

	_target = _this;

	[secondaryWeapon _target, secondaryWeaponMagazine _target] call _get_weapon_magazines;
};

_handgun_weapon_magazines = 
{
	private ["_target"];

	_target = _this;

	[handgunWeapon _target, handgunMagazine _target] call _get_weapon_magazines;
};

_unit = _this select 0;

	[
/*+00*/		"RESERVED",

/*+01*/		uniform _unit,
/*+02*/		(if (uniform _unit == "") then { [] } else { (uniformItems _unit) + (backpackCargo (uniformContainer _unit)) }),
/*+03*/		"RESERVED",

/*+04*/		vest _unit,
/*+05*/		(if (vest _unit == "") then { [] } else { (vestItems _unit) + (backpackCargo (vestContainer _unit)) }),
/*+06*/		"RESERVED",

/*+07*/		backpack _unit,
/*+08*/		(if (backpack _unit == "") then { [] } else { (backpackItems _unit) + (backpackCargo (backpackContainer _unit)) }),
/*+09*/		"RESERVED",

/*+10*/		assignedItems _unit,

/*+11*/		headgear _unit,
/*+12*/		goggles _unit,

/*+13*/		(primaryWeapon _unit) call _weapon_to_simplest,
/*+14*/		(_unit call _get_primary_weapon_items) + [(_unit call _primary_weapon_magazines)],

/*+15*/		(secondaryWeapon _unit) call _weapon_to_simplest,
/*+16*/		(_unit call _get_secondary_weapon_items) + [(_unit call _secondary_weapon_magazines)],

/*+17*/		(handgunWeapon   _unit) call _weapon_to_simplest,
/*+18*/		(_unit call _get_handgun_weapon_items) + [(_unit call _handgun_weapon_magazines)],

/*19*/		"RESERVED",

/*20*/		"RESERVED"
	]
