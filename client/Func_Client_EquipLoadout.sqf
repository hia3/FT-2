private ["_add_weapon_and_stuff", "_is_addMagazine_applicable", "_is_addWeapon_applicable", "_add_stuff_to_container", "_assigning_code_array"];

_add_weapon_and_stuff = 
{
	private ["_weapon", "_stuff", "_assign_item_code", "_i"];

	_weapon			  = _this select 0;
	_stuff			  = _this select 1;
	_assign_item_code = _this select 2;

	{
		private ["_magazine"];
		_magazine = _x select 1;
		if (_magazine != "") then
		{
			_target addMagazine _magazine;
		};
	} forEach (_stuff select 3);

	if (_weapon != "") then { _target addWeapon _weapon; };

	for [{_i=0},{_i<3},{_i=_i+1}] do
	{
		private ["_weapon_item"];

		_weapon_item = _stuff select _i;

		if (_weapon_item != "") then
		{
			_weapon_item call _assign_item_code;
		};
	};
};

_is_addMagazine_applicable = 
{
	private ["_item", "_result"];

	_item = _this;

	_result = isClass(configFile >> "CfgMagazines" >> _item);

	_result
};

_is_addWeapon_applicable = 
{
	private ["_item", "_result"];

	_item = _this;

	_result = if (isClass(configFile >> "CfgWeapons" >> _item)) then { isClass(configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo") && getNumber(configFile >> "CfgWeapons" >> _item >> "showEmpty") == 1 } else { false };

	_result
};

_add_stuff_to_container = 
{
	private ["_container", "_items", "_maximum_load", "_items_mass", "_i"];

	_container = _this select 0;
	_items	   = _this select 1;

	if (_container != "") then
	{
		_maximum_load = _container call Func_Client_GetContainerMaximumLoad;
		_items_mass	  = _items	   call Func_Client_GetItemsMass;

		if ((_items_mass != -1) && (_maximum_load >= _items_mass)) then
		{
			{
				if (_x call _is_addMagazine_applicable) then
				{
					_target addMagazine _x;
				}
				else
				{
					if (_x call _is_addWeapon_applicable) then
					{
						_target addWeapon _x;
					}
					else
					{
						_target addItem _x;
					};
				};
			} forEach _items;

			_garbage_count = _garbage_count + (_maximum_load - _items_mass);

			for [{_i=0},{_i<(_maximum_load - _items_mass)},{_i=_i+1}] do
			{
				_target addItem "ItemWatch";
			};
		};
	};
};

_assigning_code_array = 
[
	{
		removeAllAssignedItems _target;
		removeAllContainers _target;
		removeAllItems _target;
		removeAllWeapons _target;
		removeGoggles _target;
		removeHeadgear _target;

		waitUntil { ((vest _target) == "") && ((uniform _target) == "") && ((backpack _target) == "") };
	}, 

	{ if (_this == "") then { removeUniform _target } else { _target addUniform _this }; waitUntil { uniform _target == _this }; },
	{
		[_inventory select 1, _this] call _add_stuff_to_container;
	},
	{},

	{ if (_this == "") then { removeVest _target } else { _target addVest _this }; waitUntil { vest _target == _this }; },
	{
		[_inventory select 4, _this] call _add_stuff_to_container;
	},
	{},

	{ if (_this == "") then { removeBackpack _target; waitUntil { backpack _target == _this }; } else { _target addBackpack _this; waitUntil { backpack _target == _this }; clearAllItemsFromBackpack _target; }; },
	{
		{
			if ([_x] call Func_Client_IsBackpack) then
			{
				(unitBackpack _target) addBackpackCargoGlobal [_x, 1];
			}
			else
			{
				if (_x call _is_addMagazine_applicable) then
				{
					(unitBackpack _target) addMagazineCargoGlobal [_x, 1];
				}
				else
				{
					if (_x call _is_addWeapon_applicable) then
					{
						(unitBackpack _target) addWeaponCargoGlobal [_x, 1];
					}
					else
					{
						// (unitBackpack _target) addItemCargo [_x, 1]; won't work with CfgGlasses
						_target addItem _x;
					};
				};
			};
		} forEach _this;
	},
	{},

	{
		{
			if (_x call _is_addWeapon_applicable) then 
			{
				_target addWeapon _x;
			}
			else
			{
				_target addItem _x;
			};

			_target assignItem _x;
		} forEach _this;

		removeBackpack _target;
		waitUntil { (backpack _target) == "" };
	},

	{ if (_this != "") then { _target addHeadgear _this }; },
	{ if (_this != "") then { _target addGoggles  _this }; },

	{  },
	{
		_target addBackpack "B_Carryall_ocamo";
		waitUntil { (backpack _target) == "B_Carryall_ocamo" };

		[_inventory select 13, _this, { _target addPrimaryWeaponItem _this }] call _add_weapon_and_stuff;
	},

	{  },
	{
		[_inventory select 15, _this, { _target addSecondaryWeaponItem _this }] call _add_weapon_and_stuff;
	},

	{  },
	{
		[_inventory select 17, _this, { _target addHandgunItem _this }] call _add_weapon_and_stuff;
	}, 

	{
		private ["_i"];

		for [{_i=0},{_i<_garbage_count},{_i=_i+1}] do
		{
			_target removeItem "ItemWatch";
		};
	},

	{ /* rank */ }
];


_assign_inventory = 
{
	private ["_target", "_inventory", "_garbage_count", "_assigning_order", "_i"];

	_target	   = _this select 0;
	_inventory = _this select 1;

	_target setVariable ["weapons", _inventory, true];

	_garbage_count = 0;

	//hint str _inventory;

	_assigning_order = [0,	13, 14,	 15, 16,  17, 18,  10,	11, 12,	 1, 2, 3,  4, 5, 6,	 7, 8, 9,  19,	20];

	for [{_i=0},{_i<count _inventory},{_i=_i+1}] do
	{
		private ["_inventory_item", "_assigning_code"];

		_inventory_item = _inventory			select (_assigning_order select _i);
		_assigning_code = _assigning_code_array select (_assigning_order select _i);

		_inventory_item call _assigning_code;
	};
};

_this call _assign_inventory;
