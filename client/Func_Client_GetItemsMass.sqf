private ["_get_item_mass", "_get_items_mass", "_result"];

_get_item_mass = 
{
	private ["_item", "_result"];

	_item = _this;

	_result = -1;

	{
		if (isClass(_x)) then
		{
			_result = getNumber(_x >> "mass");

			/* don't ask
			if ([configName(_x)] call Func_Client_IsBackpack) then
			{
				private ["_default_items", "_default_items_mass"];

				_default_items = _item call _get_backpack_default_items;

				_default_items_mass = _default_items call _get_items_mass;

				_result = if (_default_items_mass == -1) then { _result } else { _result + _default_items_mass };
			};
			*/
		};

		if (_result == 0) then { _result = -1; };
	} forEach 
		[
			configFile >> "CfgMagazines" >> _item, 
			configFile >> "CfgGlasses"   >> _item, 
			configFile >> "CfgVehicles"  >> _item, 
			configFile >> "CfgWeapons"   >> _item >> "ItemInfo", 
			configFile >> "CfgWeapons"   >> _item >> "WeaponSlotsInfo"
		];

	_result
};

_get_items_mass = 
{
	private ["_items", "_result"];

	_items = _this;

	_result = 0;

	{
		private ["_x_mass"];

		_x_mass = _x call _get_item_mass;

		if (_x_mass == -1) then
		{
			_result = -1;
		}
		else
		{
			if (_result == -1) then
			{
				// error occurred, to nothing
			}
			else
			{
				_result = _result + _x_mass;
			};
		};
	} forEach _items;

	_result
};

_result = _this call _get_items_mass;

_result
