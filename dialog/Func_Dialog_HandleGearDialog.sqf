#define PERF_BEGIN(fun) /**/
//private ["_perf_time_begin", "_perf_time_end"]; if !(fun in Global_GearDialog_AllProfFunctionNames) then { private["_perf_func_idx"]; _perf_func_idx = count Global_GearDialog_AllProfFunctionNames; Global_GearDialog_AllProfFunctionNames set [_perf_func_idx, fun]; Global_GearDialog_AllProfFunctionTimes set [_perf_func_idx, 0]; Global_GearDialog_AllProfFunctionConts set [_perf_func_idx, 0]; }; _perf_time_begin = diag_tickTime;
#define PERF_END(fun) /**/
//_perf_time_end = diag_tickTime; if ((_perf_time_end - _perf_time_begin) > 0.02) then { diag_log ["perf:", fun, _perf_time_end - _perf_time_begin]; }; private["_perf_func_idx", "_perf_prev_time", "_perf_prev_cnt"]; _perf_func_idx = Global_GearDialog_AllProfFunctionNames find fun; _perf_prev_time = Global_GearDialog_AllProfFunctionTimes select _perf_func_idx; _perf_prev_cnt = Global_GearDialog_AllProfFunctionConts select _perf_func_idx; Global_GearDialog_AllProfFunctionTimes set [_perf_func_idx, _perf_prev_time + (_perf_time_end - _perf_time_begin)]; Global_GearDialog_AllProfFunctionConts set [_perf_func_idx, _perf_prev_cnt + 1];

// canCarryBackPack == 1
// glassesEnabled == 1

#include "RscGear_defines.hpp"

disableSerialization;

private ["_result", "_action", "_get_item_cost_str", "_is_weapon_compatible_with_slot"];

_action = _this select 0;

//diag_log _this;

_get_item_cost_str =
{
PERF_BEGIN("_get_item_cost_str")

	private ["_result"];

	_result = "$" + str (_this call Func_Client_GetItemCost);

PERF_END("_get_item_cost_str")

	_result
};

_get_empty_inventory_from_player =
{
	[
/*00*/		"RESERVED",

/*01*/		"",
/*02*/		[],
/*03*/		"RESERVED",

/*04*/		"",
/*05*/		[],
/*06*/		"RESERVED",

/*07*/		"",
/*08*/		[],
/*09*/		"RESERVED",

/*10*/		[],

/*11*/		"",
/*12*/		"",

/*13*/		"",
/*14*/		["", "", "", []],

/*15*/		"",
/*16*/		["", "", "", []],

/*17*/		"",
/*18*/		["", "", "", []],

/*19*/		"RESERVED",

/*20*/		"RESERVED"
	]
};

_is_entity_of_type =
{
PERF_BEGIN("_is_entity_of_type")

	private ["_config", "_base", "_parents"];

	_config = _this select 0;
	_base = _this select 1;

	_parents = [_config, true] call BIS_fnc_returnParents;

PERF_END("_is_entity_of_type")

	_base in _parents
};

_is_primary_weapon =
{
PERF_BEGIN("_is_primary_weapon")

	private ["_result", "_item", "_is_weapon"];

	_result = false;

	_item = _this select 0;

	_is_weapon = isClass(configFile >> "CfgWeapons" >> _item);
	if (_is_weapon) then
	{
		_result = [configFile >> "CfgWeapons" >> _item, "RifleCore"] call _is_entity_of_type;
	};

PERF_END("_is_primary_weapon")

	_result
};

_is_compatible_obves =
{
PERF_BEGIN("_is_compatible_obves")

	private ["_result", "_item", "_inventory_index", "_inventory", "_weapon", "_weapon_slot", "_compatibles"];

	_result = false;

	_item = _this select 0;
	_inventory = _this select 1;
	_inventory_index = _this select 2;
	_weapon_slot = _this select 3;
		_weapon = _inventory select _inventory_index;

	if (_weapon != "") then
	{
		if (isClass(configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> _weapon_slot)) then
		{
			_compatibles = getArray(configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> _weapon_slot >> "compatibleItems");
			{
				if ((toLower _item) == (toLower _x)) then
				{
					_result = true;
				};
			} forEach _compatibles;
		};
	};

PERF_END("_is_compatible_obves")

	_result

};

_is_compatible_primary_muzzle =
{
	(_this + [13, "MuzzleSlot"]) call _is_compatible_obves;
};


_is_compatible_primary_flashlight =
{
	(_this + [13, "PointerSlot"]) call _is_compatible_obves;
};


_is_compatible_primary_optics =
{
	(_this + [13, "CowsSlot"]) call _is_compatible_obves;
};

_get_weapon_compatible_magazines =
{
PERF_BEGIN("_get_weapon_compatible_magazines")

	private ["_weapon_config", "_magazines", "_muzzle"];

	_weapon_config = _this;

        _magazines = [];
        {
            _muzzle = if (_x == "this") then {_weapon_config} else {_weapon_config >> _x};
            _magazines = _magazines + getArray(_muzzle >> "magazines");
        } forEach getArray(_weapon_config >> "muzzles");

PERF_END("_get_weapon_compatible_magazines")

	_magazines
};

_is_compatible_magazine =
{
PERF_BEGIN("_is_compatible_magazine")

	private ["_result", "_item", "_inventory", "_inventory_index", "_weapon", "_weapon_config", "_compatible_magazines"];

	_result = false;

	_item = _this select 0;
	_inventory = _this select 1;
	_inventory_index = _this select 2;
		_weapon = _inventory select _inventory_index;

	if (_weapon != "") then
	{
		_weapon_config = configFile >> "CfgWeapons" >> _weapon;

		_compatible_magazines = _weapon_config call _get_weapon_compatible_magazines;

		_result = (_item in _compatible_magazines);
	};

PERF_END("_is_compatible_magazine")

	_result
};

_is_compatible_primary_magazine =
{
	(_this + [13]) call _is_compatible_magazine;
};


_is_secondary_weapon =
{
PERF_BEGIN("_is_secondary_weapon")

	private ["_result", "_item", "_is_weapon"];

	_result = false;

	_item = _this select 0;

	_is_weapon = isClass(configFile >> "CfgWeapons" >> _item);
	if (_is_weapon) then
	{
		_result = [configFile >> "CfgWeapons" >> _item, "LauncherCore"] call _is_entity_of_type;
	};

PERF_END("_is_secondary_weapon")

	_result
};

_is_compatible_secondary_muzzle =
{
	(_this + [15, "MuzzleSlot"]) call _is_compatible_obves;
};


_is_compatible_secondary_flashlight =
{
	(_this + [15, "PointerSlot"]) call _is_compatible_obves;
};


_is_compatible_secondary_optics =
{
	(_this + [15, "CowsSlot"]) call _is_compatible_obves;
};


_is_compatible_secondary_magazine =
{
	(_this + [15]) call _is_compatible_magazine;
};


_is_handgun =
{
PERF_BEGIN("_is_handgun")

	private ["_result", "_item", "_is_weapon"];

	_result = false;

	_item = _this select 0;

	_is_weapon = isClass(configFile >> "CfgWeapons" >> _item);
	if (_is_weapon) then
	{
		_result = [configFile >> "CfgWeapons" >> _item, "PistolCore"] call _is_entity_of_type;
	};

PERF_END("_is_handgun")

	_result
};


_is_compatible_handgun_muzzle =
{
	(_this + [17, "MuzzleSlot"]) call _is_compatible_obves;
};


_is_compatible_handgun_flashlight =
{
	(_this + [17, "PointerSlot"]) call _is_compatible_obves;
};


_is_compatible_handgun_optics =
{
	(_this + [17, "CowsSlot"]) call _is_compatible_obves;
};


_is_compatible_handgun_magazine =
{
	(_this + [17]) call _is_compatible_magazine;
};


_is_headgear =
{
PERF_BEGIN("_is_headgear")

	private ["_result", "_item", "_is_weapon"];

	_result = false;

	_item = _this select 0;

	_is_weapon = isClass(configFile >> "CfgWeapons" >> _item);
	if (_is_weapon) then
	{
		_result = [configFile >> "CfgWeapons" >> _item, "H_HelmetB"] call _is_entity_of_type;
	};

PERF_END("_is_headgear")

	_result
};


_is_goggles =
{
	private ["_result", "_item"];

	_item = _this select 0;

	_result = isClass(configFile >> "CfgGlasses" >> _item);

	_result
};


_is_hmd =
{
	private ["_item"];

	_item = _this select 0;

	_item == "NVGoggles"
};


_is_binocular =
{
PERF_BEGIN("_is_binocular")

	private ["_item", "_result"];

	_item = _this select 0;

	_result = (([configFile >> "CfgWeapons" >> _item, "Binocular"] call _is_entity_of_type) && !(_this call _is_hmd));

PERF_END("_is_binocular")

	_result
};


_is_map =
{
	private ["_item"];

	_item = _this select 0;

	_item == "ItemMap";
};


_is_gps =
{
	private ["_item"];

	_item = _this select 0;

	_item == "ItemGPS";
};


_is_compass =
{
	private ["_item"];

	_item = _this select 0;

	_item == "ItemCompass";
};


_is_radio =
{
	private ["_item"];

	_item = _this select 0;

	_item == "ItemRadio";
};


_is_watch =
{
	private ["_item"];

	_item = _this select 0;

	_item == "ItemWatch"
};

_is_uniform =
{
	private ["_item"];

	_item = _this select 0;

	getNumber(configfile >> "CfgWeapons" >> _item >> "ItemInfo" >> "type") == 801
};

_can_add_item_to_container =
{
PERF_BEGIN("_can_add_item_to_container")

	private ["_container", "_container_items", "_item", "_maximum_load", "_item_mass", "_result"];

	_container       = _this select 0;
	_container_items = _this select 1;
	_item            = _this select 2;

	_maximum_load = _container call Func_Client_GetContainerMaximumLoad;

	_item_mass = [_item] call Func_Client_GetItemsMass;

	_result = false;

	if (_item_mass != -1) then
	{
		private ["_container_items_mass"];

		_container_items_mass = _container_items call Func_Client_GetItemsMass;

		if (_container_items_mass != -1) then
		{
			_result = ((_container_items_mass + _item_mass) <= _maximum_load);
		};
	};

PERF_END("_can_add_item_to_container")

	_result
};

_is_addWeapon_applicable =
{
PERF_BEGIN("_is_addWeapon_applicable")

	private ["_item", "_result"];

	_item = _this;

	_result = if (isClass(configFile >> "CfgWeapons" >> _item)) then { isClass(configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo") && getNumber(configFile >> "CfgWeapons" >> _item >> "showEmpty") == 1 } else { false };

PERF_END("_is_addWeapon_applicable")

	_result
};

_can_add_item_to_uniform =
{
PERF_BEGIN("_can_add_item_to_uniform")

	private ["_item", "_inventory", "_uniform", "_uniform_items", "_result"];

	_item      = _this select 0;
	_inventory = _this select 1;
		_uniform       = _inventory select 1;
		_uniform_items = _inventory select 2;

	_result = false;

	if (!(_item call _is_addWeapon_applicable) && (_item != "Medikit")) then
	{
		_result = [_uniform, _uniform_items, _item] call _can_add_item_to_container;
	};

PERF_END("_can_add_item_to_uniform")

	_result
};

_can_add_item_to_vest =
{
PERF_BEGIN("_can_add_item_to_vest")

	private ["_item", "_inventory", "_vest", "_vest_items", "_result"];

	_item      = _this select 0;
	_inventory = _this select 1;
		_vest       = _inventory select 4;
		_vest_items = _inventory select 5;

	_result = false;

	if (!(_item call _is_addWeapon_applicable) && (_item != "Medikit")) then
	{
		_result = [_vest, _vest_items, _item] call _can_add_item_to_container;
	};

PERF_END("_can_add_item_to_vest")

	_result
};

_can_add_item_to_backpack =
{
PERF_BEGIN("_can_add_item_to_backpack")

	private ["_item", "_inventory", "_backpack", "_backpack_items", "_result"];

	_item      = _this select 0;
	_inventory = _this select 1;
		_backpack       = _inventory select 7;
		_backpack_items = _inventory select 8;

	_result = [_backpack, _backpack_items, _item] call _can_add_item_to_container;

PERF_END("_can_add_item_to_backpack")

	_result
};


_is_vest =
{
	private ["_item"];

	_item = _this select 0;

	getNumber(configfile >> "CfgWeapons" >> _item >> "ItemInfo" >> "type") == 701
};


_get_backpack_default_items =
{
PERF_BEGIN("_get_backpack_default_items")

	private ["_item", "_item_config", "_result"];

	_item = _this;

	_item_config = configfile >> "CfgVehicles" >> _item;

	_result = [];

	{
		private ["_config_root", "_property_name", "_default_load_config"];

		_config_root   = _x select 0;
		_property_name = _x select 1;

		_default_load_config = _item_config >> _config_root;

		if (isClass(_default_load_config)) then
		{
			private ["_i", "_j"];

			for [{_i=0},{_i<count _default_load_config},{_i=_i+1}] do
			{
				private ["_default_load_entity", "_default_load_entity_name", "_default_load_entity_count"];

				_default_load_entity = _default_load_config select _i;

				_default_load_entity_name  = getText  (_default_load_entity >> _property_name);
				_default_load_entity_count = getNumber(_default_load_entity >> "count");

				for [{_j=0},{_j<_default_load_entity_count},{_j=_j+1}] do
				{
					_result = _result + [_default_load_entity_name];
				};
			};
		};
	} forEach [["TransportItems", "name"], ["TransportMagazines", "magazine"], ["TransportWeapons", "weapon"]];

PERF_END("_get_backpack_default_items")

	_result
};

_all_preset_buttons = [IDC_Preset_1_button, IDC_Preset_2_button, IDC_Preset_3_button, IDC_Preset_4_button, IDC_Preset_5_button];

_all_slot_ids =
[
	IDC_SlotPrimary,
	IDC_SlotPrimaryMuzzle,
	IDC_SlotPrimaryGrip,
	IDC_SlotPrimaryFlashlight,
	IDC_SlotPrimaryOptics,
	IDC_SlotPrimaryMagazine,
	IDC_SlotSecondary,
	IDC_SlotSecondaryMuzzle,
	IDC_SlotSecondaryGrip,
	IDC_SlotSecondaryFlashlight,
	IDC_SlotSecondaryOptics,
	IDC_SlotSecondaryMagazine,
	IDC_SlotHandgun,
	IDC_SlotHandgunMuzzle,
	IDC_SlotHandgunGrip,
	IDC_SlotHandgunFlashlight,
	IDC_SlotHandgunOptics,
	IDC_SlotHandgunMagazine,
	IDC_SlotHeadgear,
	IDC_SlotGoggles,
	IDC_SlotHMD,
	IDC_SlotBinoculars,
	IDC_SlotMap,
	IDC_SlotGPS,
	IDC_SlotCompass,
	IDC_SlotRadio,
	IDC_SlotWatch,
	IDC_UniformSlot,
	IDC_VestSlot,
	IDC_BackpackSlot
];

_all_slots =
[
	[IDC_SlotPrimary,             _is_primary_weapon],
	[IDC_SlotPrimaryMuzzle,       _is_compatible_primary_muzzle],
	[IDC_SlotPrimaryGrip,         {false}],
	[IDC_SlotPrimaryFlashlight,   _is_compatible_primary_flashlight],
	[IDC_SlotPrimaryOptics,       _is_compatible_primary_optics],
	[IDC_SlotPrimaryMagazine,     _is_compatible_primary_magazine],
	[IDC_SlotSecondary,           _is_secondary_weapon],
	[IDC_SlotSecondaryMuzzle,     _is_compatible_secondary_muzzle],
	[IDC_SlotSecondaryGrip,       {false}],
	[IDC_SlotSecondaryFlashlight, _is_compatible_secondary_flashlight],
	[IDC_SlotSecondaryOptics,     _is_compatible_secondary_optics],
	[IDC_SlotSecondaryMagazine,   _is_compatible_secondary_magazine],
	[IDC_SlotHandgun,             _is_handgun],
	[IDC_SlotHandgunMuzzle,       _is_compatible_handgun_muzzle],
	[IDC_SlotHandgunGrip,         {false}],
	[IDC_SlotHandgunFlashlight,   _is_compatible_handgun_flashlight],
	[IDC_SlotHandgunOptics,       _is_compatible_handgun_optics],
	[IDC_SlotHandgunMagazine,     _is_compatible_handgun_magazine],
	[IDC_SlotHeadgear,            _is_headgear],
	[IDC_SlotGoggles,             _is_goggles],
	[IDC_SlotHMD,                 _is_hmd],
	[IDC_SlotBinoculars,          _is_binocular],
	[IDC_SlotMap,                 _is_map],
	[IDC_SlotGPS,                 _is_gps],
	[IDC_SlotCompass,             _is_compass],
	[IDC_SlotRadio,               _is_radio],
	[IDC_SlotWatch,               _is_watch],
	[IDC_UniformSlot,             { (_this call _is_uniform)  || (_this call _can_add_item_to_uniform)  }],
	[IDC_VestSlot,                { (_this call _is_vest)     || (_this call _can_add_item_to_vest)     }],
	[IDC_BackpackSlot,            { (_this call Func_Client_IsBackpack) || (_this call _can_add_item_to_backpack) }],

	[IDC_BackpackContainer,       { _this call _can_add_item_to_backpack }],
	[IDC_VestContainer,           { _this call _can_add_item_to_vest     }],
	[IDC_UniformContainer,        { _this call _can_add_item_to_uniform  }]
];

_slot_to_background =
[
	[IDC_SlotPrimary,               IDC_BackgroundSlotPrimary],
	[IDC_SlotPrimaryMuzzle,         IDC_BackgroundSlotPrimaryMuzzle],
	[IDC_SlotPrimaryFlashlight,     IDC_BackgroundSlotPrimaryFlashlight],
	[IDC_SlotPrimaryOptics,         IDC_BackgroundSlotPrimaryOptics],
	[IDC_SlotPrimaryMagazine,       IDC_BackgroundSlotPrimaryMagazine],
	[IDC_SlotSecondary,             IDC_BackgroundSlotSecondary],
	[IDC_SlotSecondaryMuzzle,       IDC_BackgroundSlotSecondaryMuzzle],
	[IDC_SlotSecondaryFlashlight,   IDC_BackgroundSlotSecondaryFlashlight],
	[IDC_SlotSecondaryOptics,       IDC_BackgroundSlotSecondaryOptics],
	[IDC_SlotSecondaryMagazine,     IDC_BackgroundSlotSecondaryMagazine],
	[IDC_SlotHandgun,               IDC_BackgroundSlotHandgun],
	[IDC_SlotHandgunMuzzle,         IDC_BackgroundSlotHandgunMuzzle],
	[IDC_SlotHandgunFlashlight,     IDC_BackgroundSlotHandgunFlashlight],
	[IDC_SlotHandgunOptics,         IDC_BackgroundSlotHandgunOptics],
	[IDC_SlotHandgunMagazine,       IDC_BackgroundSlotHandgunMagazine],
	[IDC_SlotHeadgear,              IDC_BackgroundSlotHeadgear],
	[IDC_SlotGoggles,               IDC_BackgroundSlotGoggles],
	[IDC_SlotHMD,                   IDC_BackgroundSlotHMD],
	[IDC_SlotBinoculars,            IDC_BackgroundSlotBinoculars],
	[IDC_SlotMap,                   IDC_BackgroundSlotMap],
	[IDC_SlotGPS,                   IDC_BackgroundSlotGPS],
	[IDC_SlotCompass,               IDC_BackgroundSlotCompass],
	[IDC_SlotRadio,                 IDC_BackgroundSlotRadio],
	[IDC_SlotWatch,                 IDC_BackgroundSlotWatch],

	[IDC_BackpackContainer,         IDC_PlayerContainerBackground],
	[IDC_VestContainer,             IDC_PlayerContainerBackground],
	[IDC_UniformContainer,          IDC_PlayerContainerBackground],

	[IDC_UniformSlot,               IDC_UniformTab],
	[IDC_VestSlot,                  IDC_VestTab],
	[IDC_BackpackSlot,              IDC_BackpackTab]
];

_simple_assign_slot_item_to_inventory =
{
	private ["_inventory", "_item", "_index"];

	_inventory = _this select 0;
	_item      = _this select 1;
	_index     = _this select 2;

	[_inventory, _index, _item] call BIS_fnc_setNestedElement;
};

_find_weapon_of_type =
{
PERF_BEGIN("_find_weapon_of_type")

	private ["_items", "_code", "_result", "_i"];

	_items = _this select 0;
	_code  = _this select 1;

	_result = -1;

	for [{_i=0},{_i<count _items},{_i=_i+1}] do
	{
		private ["_item"];

		_item = _items select _i;

		if ([_item] call _code) then
		{
			_result = _i;
		};
	};

PERF_END("_find_weapon_of_type")

	_result
};

_simple_add_assigned_item_to_inventory =
{
PERF_BEGIN("_simple_add_assigned_item_to_inventory")

	private ["_inventory", "_item", "_code", "_assigned_items"];

	_inventory = _this select 0;
	_item      = _this select 1;
	_code      = _this select 2;

	_assigned_items = _inventory select 10;

	if (_item == "") then
	{
		private ["_item_to_remove"];
		{
			if ([_x] call _code) then
			{
				_item_to_remove = _x;
			};
		} forEach _assigned_items;

		_assigned_items = _assigned_items - [_item_to_remove];

		_inventory set [10, _assigned_items];
	}
	else
	{
		private ["_index"];

		_index = [_assigned_items, _code] call _find_weapon_of_type;

		if (_index == -1) then
		{
			_assigned_items set [count _assigned_items, _item];
		}
		else
		{
			_assigned_items set [_index, _item];
		};
	};

PERF_END("_simple_add_assigned_item_to_inventory")

};

_set_weapon_item_to_inventory =
{
PERF_BEGIN("_set_weapon_item_to_inventory")

	private ["_inventory", "_weapon", "_index", "_clean_muzzles", "_weapon_config"];

	_inventory          = _this select 0;
	_weapon             = _this select 1;
	_weapon_index       = _this select 2;
	_weapon_items_index = _this select 3;

	[_inventory, _weapon, [_weapon_index]]        call _simple_assign_slot_item_to_inventory;
	[_inventory, "",    [_weapon_items_index, 0]] call _simple_assign_slot_item_to_inventory;
	[_inventory, "",    [_weapon_items_index, 1]] call _simple_assign_slot_item_to_inventory;
	[_inventory, "",    [_weapon_items_index, 2]] call _simple_assign_slot_item_to_inventory;

	_clean_muzzles = [];

	_weapon_config = configFile >> "CfgWeapons" >> _weapon;

	{
		private ["_muzzle", "_current_magazine"];

		_muzzle = if (_x == "this") then {_weapon} else {_x};

		_current_magazine = "";

		_clean_muzzles = _clean_muzzles + [[_muzzle, _current_magazine]];

	} forEach getArray(_weapon_config >> "muzzles");

	[_inventory, _clean_muzzles, [_weapon_items_index, 3]] call _simple_assign_slot_item_to_inventory;

PERF_END("_set_weapon_item_to_inventory")

};

_simple_assign_magazine_to_weapon =
{
PERF_BEGIN("_simple_assign_magazine_to_weapon")

	private ["_inventory", "_magazine", "_weapon_index", "_weapon_items_index", "_weapon", "_weapon_items", "_weapon_config", "_muzzle_index", "_muzzle_current_index"];

	_inventory          = _this select 0;
	_magazine           = _this select 1;
	_weapon_index       = _this select 2;
	_weapon_items_index = _this select 3;

	_weapon       = _inventory select _weapon_index;
	_weapon_items = _inventory select _weapon_items_index;

	if (_magazine == "") then
	{
		private ["_weapon_magazines", "_i"];

		_weapon_magazines = _weapon_items select 3;

		for [{_i=0},{_i<count _weapon_magazines},{_i=_i+1}] do
		{
			(_weapon_magazines select _i) set [1, ""];
		};
	}
	else
	{
		_weapon_config = configFile >> "CfgWeapons" >> _weapon;

		_muzzle_index = -1;
	        _muzzle_current_index = 0;

	        {
	            private ["_muzzle", "_muzzle_compatible_magazines"];

	            _muzzle = if (_x == "this") then {_weapon_config} else {_weapon_config >> _x};
	            _muzzle_compatible_magazines = getArray(_muzzle >> "magazines");

	            if (_magazine in _muzzle_compatible_magazines) then // TODO: check case insensitive
	            {
	                _muzzle_index = _muzzle_current_index;
	            };

	            _muzzle_current_index = _muzzle_current_index + 1;

	        } forEach getArray(_weapon_config >> "muzzles");

		if (_muzzle_index != -1) then
		{
	            [_inventory, _magazine, [_weapon_items_index, 3, _muzzle_index, 1]] call _simple_assign_slot_item_to_inventory;
		};
	};

PERF_END("_simple_assign_magazine_to_weapon")

};

_simple_assign_uniform_to_inventory =
{
PERF_BEGIN("_simple_assign_uniform_to_inventory")

	private ["_inventory", "_item"];

	_inventory = _this select 0;
	_item      = _this select 1;

	if ([_item] call _is_uniform) then
	{
		[_inventory, _item, [1]] call _simple_assign_slot_item_to_inventory;
		[_inventory, [],    [2]] call _simple_assign_slot_item_to_inventory;
	}
	else
	{
		private ["_items"];

		_items = _inventory select 2;

		_items = _items + [_item];

		[_inventory, _items, [2]] call _simple_assign_slot_item_to_inventory;
	};

PERF_END("_simple_assign_uniform_to_inventory")

};


_simple_assign_vest_to_inventory =
{
PERF_BEGIN("_simple_assign_vest_to_inventory")

	private ["_inventory", "_item"];

	_inventory = _this select 0;
	_item      = _this select 1;

	if ([_item] call _is_vest) then
	{
		[_inventory, _item, [4]] call _simple_assign_slot_item_to_inventory;
		[_inventory, [],    [5]] call _simple_assign_slot_item_to_inventory;
	}
	else
	{
		private ["_items"];

		_items = _inventory select 5;

		_items = _items + [_item];

		[_inventory, _items, [5]] call _simple_assign_slot_item_to_inventory;
	};

PERF_END("_simple_assign_vest_to_inventory")

};

_simple_assign_backpack_to_inventory =
{
PERF_BEGIN("_simple_assign_backpack_to_inventory")

	private ["_inventory", "_item"];

	_inventory = _this select 0;
	_item      = _this select 1;

	if ([_item] call Func_Client_IsBackpack) then
	{
		private ["_default_items"];

		[_inventory, _item, [7]] call _simple_assign_slot_item_to_inventory;

		_default_items = _item call _get_backpack_default_items;

		[_inventory, _default_items, [8]] call _simple_assign_slot_item_to_inventory;
	}
	else
	{
		private ["_items"];

		_items = _inventory select 8;

		_items = _items + [_item];

		[_inventory, _items, [8]] call _simple_assign_slot_item_to_inventory;
	};

PERF_END("_simple_assign_backpack_to_inventory")

};


_assign_slot_item_to_inventory =
[
	[IDC_SlotPrimary,             { (_this + [13, 14]) call _set_weapon_item_to_inventory }],
	[IDC_SlotPrimaryMuzzle,       { (_this + [[14, 0]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotPrimaryGrip,         { }],
	[IDC_SlotPrimaryFlashlight,   { (_this + [[14, 1]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotPrimaryOptics,       { (_this + [[14, 2]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotPrimaryMagazine,     { (_this + [13, 14]) call _simple_assign_magazine_to_weapon }],

	[IDC_SlotSecondary,           { (_this + [15, 16]) call _set_weapon_item_to_inventory }],
	[IDC_SlotSecondaryMuzzle,     { (_this + [[16, 0]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotSecondaryGrip,       { }],
	[IDC_SlotSecondaryFlashlight, { (_this + [[16, 1]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotSecondaryOptics,     { (_this + [[16, 2]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotSecondaryMagazine,   { (_this + [15, 16]) call _simple_assign_magazine_to_weapon }],

	[IDC_SlotHandgun,             { (_this + [17, 18]) call _set_weapon_item_to_inventory }],
	[IDC_SlotHandgunMuzzle,       { (_this + [[18, 0]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotHandgunGrip,         { }],
	[IDC_SlotHandgunFlashlight,   { (_this + [[18, 1]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotHandgunOptics,       { (_this + [[18, 2]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotHandgunMagazine,     { (_this + [17, 18]) call _simple_assign_magazine_to_weapon }],

	[IDC_SlotHeadgear,            { (_this + [[11]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotGoggles,             { (_this + [[12]]) call _simple_assign_slot_item_to_inventory }],
	[IDC_SlotHMD,                 { (_this + [_is_hmd])        call _simple_add_assigned_item_to_inventory }],
	[IDC_SlotBinoculars,          { (_this + [_is_binocular])  call _simple_add_assigned_item_to_inventory }],
	[IDC_SlotMap,                 { (_this + [_is_map])        call _simple_add_assigned_item_to_inventory }],
	[IDC_SlotGPS,                 { (_this + [_is_gps])        call _simple_add_assigned_item_to_inventory }],
	[IDC_SlotCompass,             { (_this + [_is_compass])    call _simple_add_assigned_item_to_inventory }],
	[IDC_SlotRadio,               { (_this + [_is_radio])      call _simple_add_assigned_item_to_inventory }],
	[IDC_SlotWatch,               { (_this + [_is_watch])      call _simple_add_assigned_item_to_inventory }],

	[IDC_UniformSlot,             { _this call _simple_assign_uniform_to_inventory  }],
	[IDC_VestSlot,                { _this call _simple_assign_vest_to_inventory     }],
	[IDC_BackpackSlot,            { _this call _simple_assign_backpack_to_inventory }],

	[IDC_UniformContainer,        { _this call _simple_assign_uniform_to_inventory  }],
	[IDC_VestContainer,           { _this call _simple_assign_vest_to_inventory     }],
	[IDC_BackpackContainer,       { _this call _simple_assign_backpack_to_inventory }]
];

_get_compatible_slots =
{
PERF_BEGIN("_get_compatible_slots")

	//_item      = _this select 0;
	//_inventory = _this select 1;

	private ["_result"];

	_result = [];

	{
		private ["_slot", "_code", "_is"];

		_slot = _x select 0;
		_code = _x select 1;

		_is = _this call _code;
		if (_is) then
		{
			_result = _result + [_slot];
		};
	} forEach _all_slots;

PERF_END("_get_compatible_slots")

	_result
};

_is_weapon_compatible_with_slot =
{
PERF_BEGIN("_is_weapon_compatible_with_slot")

    private ["_result", "_param", "_destination_control", "_source_control", "_dragged_items", "_inventory", "_item_type", "_compatible_slots"];
    _result = false;

    _param = _this select 1;
        _destination_control = ctrlIDC (_param select 0);
        //_destination_x       = _param select 1;
        //_destination_y       = _param select 2;
        _source_control      = _param select 3;
        _dragged_items       = _param select 4;

    _inventory = _this select 2;

    {
        //_display_name = _x select 0;
        //_unused       = _x select 1;
        _item_type      = _x select 2;

	_compatible_slots = [_item_type, _inventory] call _get_compatible_slots;
	_result = _destination_control in _compatible_slots;

    } forEach _dragged_items;

PERF_END("_is_weapon_compatible_with_slot")

    _result;

};

_save_button_color =
{
	private ["_control", "_enabled", "_color", "_active_color"];

	_control = _this select 0;
	_enabled = _this select 1;

	if (_enabled) then
	{
		_color =
		[
			0,
			1,
			0,
			0.8
		];

		_active_color =
		[
			0,
			1,
			0,
			1
		];
	}
	else
	{
		_color =
		[
			(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69]),
			(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75]),
			(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5]),
			0.4
		];

		_active_color =
		[
			(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69]),
			(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75]),
			(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5]),
			1
		];
	};

	_control ctrlSetTextColor _color;
	_control ctrlSetActiveColor _active_color;
};

_initial_fill_inventory_gui =
{
PERF_BEGIN("_initial_fill_inventory_gui")

    private ["_target", "_display", "_player_name_control", "_player_rank_control", "_set_simple_visual_generic", "_set_simple_visual", "_set_simple_magazine_visual", "_set_container_visual", "_assignedItems", "_set_weapon_visual", "_empty_slot_pictures"];

    _target_tmp = _this select 0;
	//_target_unit_name            = _target_tmp select  0;

	_target_uniform                = _target_tmp select  1;
	_target_uniform_items          = _target_tmp select  2;
	_target_load_uniform           = _target_tmp select  3;

        _target_vest                   = _target_tmp select  4;
	_target_vest_items             = _target_tmp select  5;
	_target_load_vest              = _target_tmp select  6;

        _target_backpack               = _target_tmp select  7;
	_target_backpack_items         = _target_tmp select  8;
	_target_load_backpack          = _target_tmp select  9;

	_target_assigned_items         = _target_tmp select 10;

	_target_headgear               = _target_tmp select 11;
	_target_goggles                = _target_tmp select 12;

        _target_primary_weapon         = _target_tmp select 13;
        _target_primary_weapon_items   = _target_tmp select 14;

	_target_secondary_weapon       = _target_tmp select 15;
	_target_secondary_weapon_items = _target_tmp select 16;

	_target_handgun_weapon         = _target_tmp select 17;
	_target_handgun_items          = _target_tmp select 18;

	_target_load_abs               = _target_tmp select 19;

	//_target_rank                 = _target_tmp select 20;

     //hint str _target_tmp;

    _display = _this select 1;
    _player_name_control = _display displayCtrl IDC_PlayersName;
    _player_rank_control = _display displayCtrl IDC_RankPicture;

    _player_name_control ctrlSetText Local_PlayerName;
    _player_rank_control ctrlSetText format ["\A3\Ui_f\data\GUI\Cfg\Ranks\%1_gs.paa", rank player];

    _set_simple_visual_generic =
    {
        private ["_slot_control", "_slot_item", "_empty_picture", "_root_config", "_is_slot_empty", "_picture", "_tooltip"];

        _slot_control    = _display displayCtrl (_this select 0);
        _slot_item       = _this select 1;
        _empty_picture   = _this select 2;

	{
		if (isClass(configfile >> _x >> _slot_item)) then
		{
			_root_config = configfile >> _x;
		};
	} forEach ["CfgVehicles", "CfgWeapons", "CfgMagazines", "CfgGlasses"];

        _is_slot_empty   = (_slot_item == "");

        _picture = if (_is_slot_empty) then { _empty_picture } else { getText(_root_config >> _slot_item >> "picture") };
        _tooltip = if (_is_slot_empty) then { ""             } else { getText(_root_config >> _slot_item >> "displayName") };
        _slot_control ctrlSetText    _picture;
        _slot_control ctrlSetTooltip _tooltip;
    };

    _set_simple_visual =
    {
        [_this select 0, _this select 1, _this select 2] call _set_simple_visual_generic;
    };

    _set_container_visual =
    {
        private ["_slot_control", "_slot_item", "_load_control", "_load_item", "_content_control", "_content_item", "_empty_picture", "_load_control_frame", "_load_control", "_a", "_slot_item_maximum_load", "_content_item_mass"];

        _slot_control    = _this select 0;
        _slot_item       = _this select 1;

        _load_control    = _display displayCtrl (_this select 2);
        _load_item       = _this select 3;

        _content_control = _display displayCtrl (_this select 4);
        _content_item    = _this select 5;

        _empty_picture   = _this select 6;

	_load_control_frame = ctrlPosition (_display displayCtrl (_this select 7));
	_load_control       = _display displayCtrl (_this select 8);

        [_slot_control, _slot_item, _empty_picture] call _set_simple_visual;

	_a = 0;
	lbClear _content_control;
	{
		private ["_item", "_display_name", "_picture", "_config"];
		_item = _x;

		_display_name = _item;
        	_picture      = "\A3\ui_f\data\gui\cfg\cursors\hc_unsel_gs.paa";

		{
			_config = configFile >> _x >> _item;

			if (isClass(_config)) then
			{
		                _display_name = getText(_config >> "displayName");
	        	        _picture      = getText(_config >> "picture");
			};
		} forEach ["CfgWeapons", "CfgMagazines", "CfgGlasses", "CfgVehicles"];

		_content_control lbAdd         _display_name;
		_content_control lbSetPicture [_a, _picture];

		_a = _a + 1;
	} forEach _content_item;

	_slot_item_maximum_load = _slot_item call Func_Client_GetContainerMaximumLoad;
	_content_item_mass = if ((_slot_item == "") || (_slot_item_maximum_load == 0)) then { 0 } else { (_content_item call Func_Client_GetItemsMass) / _slot_item_maximum_load };

	_load_control ctrlSetPosition [_load_control_frame select 0, _load_control_frame select 1, _content_item_mass * (_load_control_frame select 2), _load_control_frame select 3];
	_load_control ctrlCommit 0;


    };

    [IDC_UniformSlot,  _target_uniform,  IDC_UniformLoad,  _target_load_uniform,  IDC_UniformContainer,  _target_uniform_items,  "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_uniform_gs.paa",  IDC_UniformLoad,  IDC_UniformLoadPicture ] call _set_container_visual;
    [IDC_VestSlot,     _target_vest,     IDC_VestLoad,     _target_load_vest,     IDC_VestContainer,     _target_vest_items,     "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_vest_gs.paa",     IDC_VestLoad,     IDC_VestLoadPicture    ] call _set_container_visual;
    [IDC_BackpackSlot, _target_backpack, IDC_BackpackLoad, _target_load_backpack, IDC_BackpackContainer, _target_backpack_items, "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_backpack_gs.paa", IDC_BackpackLoad, IDC_BackpackLoadPicture] call _set_container_visual;

    if (true) then
    {
	private ["_total_inventory_mass", "_total_load_control_frame", "_total_load_control"];

	_total_inventory_mass = (_target_tmp call Func_Client_InventoryToArray) call Func_Client_GetItemsMass;

	_total_load_control_frame = ctrlPosition (_display displayCtrl IDC_TotalLoad);
	_total_load_control       =               _display displayCtrl IDC_TotalLoadPicture;

	if (_total_inventory_mass != -1) then
	{
		_total_load_control ctrlSetPosition
			[
				_total_load_control_frame select 0,
				_total_load_control_frame select 1,
				(_total_inventory_mass / 2000) * (_total_load_control_frame select 2),
				_total_load_control_frame select 3
			];
		_total_load_control ctrlCommit 0;
	};
    };

    {
        private ["_code", "_info", "_control", "_picture", "_index"];

        _code = _x select 0;
        _info = _x select 1;
        	_control = _info select 0;
	        _picture = _info select 1;

	_index = [_target_assigned_items, _code] call _find_weapon_of_type;

        [_control, if (_index == -1) then { "" } else { _target_assigned_items select _index }, _picture] call _set_simple_visual;

    } forEach
        [
            [_is_hmd,       [IDC_SlotHMD, "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_nvg_gs.paa"]],
            [_is_binocular, [IDC_SlotBinoculars, "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_binocular_gs.paa"]],
            [_is_map,       [IDC_SlotMap, "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_map_gs.paa"]],
            [_is_compass,   [IDC_SlotCompass, "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_compass_gs.paa"]],
            [_is_watch,     [IDC_SlotWatch, "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_watch_gs.paa"]],
            [_is_gps,       [IDC_SlotGPS, "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_gps_gs.paa"]],
            [_is_radio,     [IDC_SlotRadio, "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_radio_gs.paa"]]
        ];

    [IDC_SlotHeadgear, _target_headgear, "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_helmet_gs.paa" ] call _set_simple_visual;
    [IDC_SlotGoggles,  _target_goggles,  "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_glasses_gs.paa"] call _set_simple_visual;

    _set_weapon_visual =
    {
	private ["_weapon", "_slot_idcs", "_weapon_items", "_empty_slot_pictures", "_i"];

        _this call _set_simple_visual;

        _weapon    = _this select 1;
        _slot_idcs = _this select 3;

        _weapon_items        = _this select 4;
        _empty_slot_pictures = _this select 5;

        for [{_i = 0},{_i != 3},{_i = _i + 1}] do
        {
            private ["_weapon_item"];

            _weapon_item = if (_i < (count _weapon_items)) then { _weapon_items select _i } else {""};
            [_slot_idcs select _i, _weapon_item, _empty_slot_pictures select _i] call _set_simple_visual;
        };

	// show primary magazine
	if (true) then
	{
		private ["_current_magazines", "_main_muzzle_info", "_main_muzzle_name", "_main_muzzle_magazine"];

        	_current_magazines = _weapon_items select 3;

		if (0 == (count _current_magazines)) then
		{
			[_slot_idcs select 3, "", _empty_slot_pictures select 3] call _set_simple_visual;
		}
		else
		{
			_main_muzzle_info = _current_magazines select 0;
				_main_muzzle_name     = _main_muzzle_info select 0;
				_main_muzzle_magazine = _main_muzzle_info select 1;

			[_slot_idcs select 3, _main_muzzle_magazine, _empty_slot_pictures select 3] call _set_simple_visual;
		};
	};
    };

    _empty_slot_pictures =
        [
            "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa",
            "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa",
            "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa",
            "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_magazine_gs.paa"
        ];

    [
        IDC_SlotPrimary,
        _target_primary_weapon,
        "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_primary_gs.paa",
        [IDC_SlotPrimaryMuzzle, IDC_SlotPrimaryFlashlight, IDC_SlotPrimaryOptics, IDC_SlotPrimaryMagazine],
        _target_primary_weapon_items,
        _empty_slot_pictures
    ] call _set_weapon_visual;

    [
        IDC_SlotSecondary,
        _target_secondary_weapon,
        "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_secondary_gs.paa",
        [IDC_SlotSecondaryMuzzle, IDC_SlotSecondaryFlashlight, IDC_SlotSecondaryOptics, IDC_SlotSecondaryMagazine],
        _target_secondary_weapon_items,
        _empty_slot_pictures
    ] call _set_weapon_visual;

    [
        IDC_SlotHandgun,
        _target_handgun_weapon,
        "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_hgun_gs.paa",
        [IDC_SlotHandgunMuzzle, IDC_SlotHandgunFlashlight, IDC_SlotHandgunOptics, IDC_SlotHandgunMagazine],
        _target_handgun_items,
        _empty_slot_pictures
    ] call _set_weapon_visual;

    if (true) then
    {
		private ["_preset_index", "_preset_inventory", "_display_inventory", "_is_preset_changed", "_save_button_control"];

        _preset_index = uiNamespace getVariable "FT2_RscGear_CurrentPreset";
		_preset_inventory = if (_preset_index == 0) then { Local_RscGear_SavedInventory } else { _preset_index call _restore_preset };
		_display_inventory = _target_tmp;

		_is_preset_changed = !([_preset_inventory, _display_inventory] call BIS_fnc_areEqual);

		_save_button_control = _display displayCtrl IDC_Save_button;
		[_save_button_control, _is_preset_changed] call _save_button_color;
    };

    if (true) then
    {
        private ["_cash_control", "_cost_control", "_upgrade_cost", "_current_cash", "_can_buy", "_ok_button_control"];

        _cash_control = _display displayCtrl IDC_Cash_text;
        _cost_control = _display displayCtrl IDC_Cost_text;

	Local_RscGear_CurrentCost = _target_tmp call Func_Client_GetInventoryCost;

	_upgrade_cost = Local_RscGear_CurrentCost - Local_RscGear_InitialCost;
        _cost_control ctrlSetText format[localize "STR_WF_Cost", _upgrade_cost];

	_current_cash = call Func_Client_GetPlayerFunds;
        _cash_control ctrlSetText format["%1 $ %2.", localize "STR_WF_CashLabel", _current_cash];

	_can_buy = ((_current_cash - _upgrade_cost) >= 0);

	_ok_button_control = _display displayCtrl IDC_OK_button;
	_ok_button_control ctrlEnable _can_buy;
	_ok_button_control ctrlSetTextColor (if (_can_buy) then { [ 0, 1, 0, 0.5 ] } else { [1, 0, 0, 0.5] });
    };

PERF_END("_initial_fill_inventory_gui")

};


_set_weapons_list =
{
PERF_BEGIN("_set_weapons_list")

	private ["_display", "_config_list", "_current_weapon", "_weapons_list_control", "_a", "_list_current_index"];

	_display        = _this select 0;
	_config_list    = _this select 1;
	_current_weapon = _this select 2;

	_weapons_list_control = _display displayCtrl IDC_Weapons_list;

	lnbClear _weapons_list_control;

	_a = 0;
	_list_current_index = _a;

	{
		private ["_weapon_config", "_weapon_config_name", "_display_name", "_picture", "_cost"];

		_weapon_config = _x;

		_weapon_config_name = configName(_weapon_config);

                _display_name = getText(_weapon_config >> "displayName");
                _picture = getText(_weapon_config >> "picture");

                if ((_display_name != "") && (_picture != "")) then
                {
                    _cost = _weapon_config_name call _get_item_cost_str;
                    _weapons_list_control lnbAddRow   [_display_name, _cost];

                    lnbSetPicture [ctrlIDC _weapons_list_control, [_a, 0], _picture];
                    _weapons_list_control lnbSetData  [[_a, 0], _weapon_config_name];
                    _weapons_list_control lnbSetValue [[_a, 0], _a];

                    if (_weapon_config_name == _current_weapon) then
                    {
                        _list_current_index = _a;
                    };

                    _a = _a + 1;
                };
	} forEach _config_list;

	_weapons_list_control lnbSetCurSelRow _list_current_index;

PERF_END("_set_weapons_list")

};

_is_weapon_allowed =
{
	private ["_weapon_config", "_parents", "_algo_index_1", "_algo_index_2", "_algo_index", "_is_allowed_by_class", "_result"];

	_weapon_config = _this select 0;
	_parents       = _this select 1;

	_algo_index_1 = if (isNil "Config_AllowedWeapons")       then { 0 } else { if (0 == (count Config_AllowedWeapons))       then { 1 } else { 2 } };
	_algo_index_2 = if (isNil "Config_AllowedWeaponClasses") then { 0 } else { if (0 == (count Config_AllowedWeaponClasses)) then { 1 } else { 2 } };

	_algo_index = 3 * _algo_index_1 + _algo_index_2;

//		weapon	class
//---------------------------------
// 0	nil		nil		all
// 1	nil		[]		none
// 2	nil		[c]		[c]
// 3	[]		nil		none
// 4	[]		[]		none
// 5	[]		[c]		[c]
// 6	[w]		nil		[w]
// 7	[w]		[]		[w]
// 8	[w]		[c]		[w] + [c]

	_is_allowed_by_class =
	{
		private ["_parents", "_result"];

		_parents = _this;

		_result = false;
		{
			if (_x in _parents) exitWith
			{
				_result = true;
			};
		} forEach Config_AllowedWeaponClasses;

		_result
	};

	_result = switch (_algo_index) do
	{
		case 0:
		{
			true
		};
		case 1:
		{
			false
		};
		case 2:
		{
			_parents call _is_allowed_by_class
		};
		case 3:
		{
			false
		};
		case 4:
		{
			false
		};
		case 5:
		{
			_parents call _is_allowed_by_class
		};
		case 6:
		{
			configName(_weapon_config) in Config_AllowedWeapons
		};
		case 7:
		{
			configName(_weapon_config) in Config_AllowedWeapons
		};
		case 8:
		{
			((configName(_weapon_config) in Config_AllowedWeapons) || (_parents call _is_allowed_by_class))
		};
	};

	_result
};

_enum_simplest_weapons =
{
PERF_BEGIN("_enum_simplest_weapons")

    private ["_base_class", "_weapons_config", "_config_list", "_i"];

    _base_class     = _this select 0;

    _weapons_config = configFile >> "CfgWeapons";

    _config_list = [];

    for [{_i=0},{_i<count _weapons_config},{_i=_i+1}] do
    {
        private ["_weapon_config"];

        _weapon_config = _weapons_config select _i;

        if (isClass _weapon_config) then
        {
			if (getNumber(_weapon_config >> "scope") >= 2) then
			{
				private ["_parents", "_is_weapon_of_base_class", "_simplest_model"];

				_parents = [_weapon_config, true] call BIS_fnc_returnParents;

				_is_weapon_of_base_class = (_base_class in _parents);

				_simplest_model = !isClass(_weapon_config >> "LinkedItems");

				if (_is_weapon_of_base_class && _simplest_model) then
				{
					if ([_weapon_config, _parents] call _is_weapon_allowed) then
					{
						_config_list = _config_list + [_weapon_config];
					};
				};
			};
        };
    };

PERF_END("_enum_simplest_weapons")

    _config_list
};

_add_simplest_weapons =
{
PERF_BEGIN("_add_simplest_weapons")

    private ["_base_class", "_display", "_current_weapon", "_config_list"];

    _base_class     = _this select 0;
    _display        = _this select 1;
    _current_weapon = _this select 2;

    _config_list = [_base_class] call _enum_simplest_weapons;

    [_display, _config_list, _current_weapon] call _set_weapons_list;

PERF_END("_add_simplest_weapons")
};

_show_available_weapons_list =
{
PERF_BEGIN("_show_available_weapons_list")

    private ["_param", "_button", "_weapon_kind", "_display", "_inventory", "_current_weapon"];

    _param = _this select 1;
		_button = _param select 0;
	_weapon_kind = _this select 2;

    _display = ctrlParent _button;

    _inventory = [_display] call _restore_inventory_from_display;
    _current_weapon = "";
    switch (_weapon_kind) do
    {
        case "RifleCore":
        {
            _current_weapon = _inventory select 13;
        };
        case "LauncherCore":
        {
            _current_weapon = _inventory select 15;
        };
        case "PistolCore":
        {
            _current_weapon = _inventory select 17;
        };
    };

    [_weapon_kind, _display, _current_weapon] call _add_simplest_weapons;

PERF_END("_show_available_weapons_list")

};

_show_available_weapons_list_pred =
{
PERF_BEGIN("_show_available_weapons_list_pred")

	private ["_param", "_button", "_display", "_weapons_config", "_config_list", "_i"];

	_param = _this select 1;
		_button = _param select 0;
			_display = ctrlParent _button;
	_pred  = _this select 2;

	_weapons_config = configfile >> "CfgWeapons";

	_config_list = [];

	for [{_i = 0},{_i != count _weapons_config},{_i = _i + 1}] do
	{
		private ["_item_config", "_item_config_name"];

		_item_config = _weapons_config select _i;

		if (isClass(_item_config)) then
		{
			_item_config_name = configName(_item_config);

			if ([_item_config_name] call _pred) then
			{
				_config_list = _config_list + [_item_config];
			};
		};
	};

	[_display, _config_list, ""] call _set_weapons_list;

PERF_END("_show_available_weapons_list_pred")

};

_paint_compatible_slot_backgrounds =
{
PERF_BEGIN("_paint_compatible_slot_backgrounds")

	private ["_display", "_slot_ids", "_current_tab"];

	_display  = _this select 0;
	_slot_ids = _this select 1;

	_current_tab = uinamespace getVariable "FT2_RscGear_CurrentTab";

	{
		private ["_slot_idc", "_back_idc", "_color", "_alpha", "_back"];

		_slot_idc = _x select 0;
		_back_idc = _x select 1;

		if (ctrlVisible _slot_idc) then
		{
			_alpha = if (_current_tab == _back_idc) then { 1.0 } else { 0.5 };

			if (_slot_idc in _slot_ids) then
			{
				_color = [1, 1, 1, _alpha];
			}
			else
			{
				_color = [1, 0, 0, _alpha];
			};

			_back = _display displayCtrl _back_idc;
			_back ctrlSetTextColor _color;
		};

	} forEach _slot_to_background;

PERF_END("_paint_compatible_slot_backgrounds")

};

_on_drag_and_drop_started =
{
PERF_BEGIN("_on_drag_and_drop_started")

	private ["_param", "_control", "_dragged_items", "_display", "_inventory", "_compatible_slots"];

	_param = _this select 1;
		_control = _param select 0;
                _dragged_items = _param select 1;
	_display = ctrlParent _control;

        _inventory = _this select 2;

	{
		private ["_item_index", "_item_type", "_compatible_slots"];

		_item_index = _x select 1;
		_item_type  = _x select 2;

		_compatible_slots = [_item_type, _inventory] call _get_compatible_slots;
		[_display, _compatible_slots] call _paint_compatible_slot_backgrounds;

		_control lnbSetCurSelRow _item_index;
	} forEach _dragged_items;

PERF_END("_on_drag_and_drop_started")

};

_on_drag_and_drop_finished =
{
PERF_BEGIN("_on_drag_and_drop_finished")

	private ["_display", "_slots", "_slot_idc", "_back_idc"];

	_display = _this select 0;

	_slots = [];
	{
		_slot_idc = _x select 0;
		_back_idc = _x select 1;

		_slots = _slots + [_slot_idc];
	} forEach _slot_to_background;

	[_display, _slots] call _paint_compatible_slot_backgrounds;

PERF_END("_on_drag_and_drop_finished")

};

_activate_container =
{
PERF_BEGIN("_activate_container")

	private ["_button_idc", "_display"];
	_button_idc = _this select 0;
	_display    = _this select 1;

	{
		private ["_slot_idc", "_container_idc", "_tab_idc", "_is_this_tab", "_container_control"];
		_slot_idc      = _x select 0;
		_container_idc = _x select 1;
		_tab_idc       = _x select 2;

		_is_this_tab = (_slot_idc == _button_idc);

		_container_control = _display displayCtrl _container_idc;
		_container_control ctrlShow _is_this_tab;

		if (_is_this_tab) then
		{
			uinamespace setVariable ["FT2_RscGear_CurrentTab", _tab_idc];
		};
	} forEach
		[
			[ IDC_UniformSlot,  IDC_UniformContainer,  IDC_UniformTab],
			[    IDC_VestSlot,     IDC_VestContainer,     IDC_VestTab],
			[IDC_BackpackSlot, IDC_BackpackContainer, IDC_BackpackTab]
		];

PERF_END("_activate_container")

};

_remove_container_itself =
{
PERF_BEGIN("_remove_container_itself")

	private ["_button_idc", "_inventory"];
	_button_idc = _this select 0;
	_inventory  = _this select 1;

	{
		private ["_slot_idc", "_inventory_indexes", "_inventory_container_index", "_inventory_container_items_index", "_is_this_tab"];

		_slot_idc          = _x select 0;
		_inventory_indexes = _x select 1;
			_inventory_container_index       = _inventory_indexes select 0;
			_inventory_container_items_index = _inventory_indexes select 1;

		_is_this_tab = (_slot_idc == _button_idc);

		if (_is_this_tab) then
		{
			_inventory set [_inventory_container_index,       ""];
			_inventory set [_inventory_container_items_index, []];
		};
	} forEach
		[
			[ IDC_UniformSlot, [1,2]],
			[    IDC_VestSlot, [4,5]],
			[IDC_BackpackSlot, [7,8]]
		];

PERF_END("_remove_container_itself")

};

_remove_item_from_container =
{
PERF_BEGIN("_remove_item_from_container")

	private ["_button_idc", "_inventory"];
	_button_idc = _this select 0;
	_inventory  = _this select 1;

	{
		private ["_slot_idc", "_inventory_container_items_index", "_is_this_tab"];

		_slot_idc                        = _x select 0;
		_inventory_container_items_index = _x select 1;

		_is_this_tab = (_slot_idc == _button_idc);

		if (_is_this_tab) then
		{
			private ["_current_item"];

			_current_item = lnbCurSelRow _button_idc;

			if (_current_item == -1) then
			{
				_inventory set [_inventory_container_items_index, []];
			}
			else
			{
				private ["_items"];

				_items = _inventory select _inventory_container_items_index;

				if (_current_item < (count _items)) then
				{
					_items set [_current_item, "removed"];

					_items = _items - ["removed"];

					_inventory set [_inventory_container_items_index, _items];
				};
			};
		};
	} forEach
		[
			[ IDC_UniformContainer, 2],
			[    IDC_VestContainer, 5],
			[IDC_BackpackContainer, 8]
		];

PERF_END("_remove_item_from_container")

};

_on_container_slot_click =
{
PERF_BEGIN("_on_container_slot_click")

	private ["_param", "_button", "_button_idc", "_display", "_mouse_button", "_inventory"];

	_param = _this select 1;
            _button       = _param select 0;
                _button_idc = ctrlIDC _button;
	        _display    = ctrlParent _button;
            _mouse_button = _param select 1;
	_inventory = _this select 2;

	if (_mouse_button == 0) then
	{
		[_button_idc, _display] call _activate_container;

		[_display] call _on_drag_and_drop_finished;
	}
	else
	{
		[_button_idc, _inventory] call _remove_container_itself;
	};

PERF_END("_on_container_slot_click")

};

_on_container_item_click =
{
PERF_BEGIN("_on_container_item_click")

	private ["_param", "_button", "_button_idc", "_display", "_mouse_button", "_inventory"];

	_param = _this select 1;
            _button       = _param select 0;
                _button_idc = ctrlIDC _button;
	        _display    = ctrlParent _button;
            _mouse_button = _param select 1;
	_inventory = _this select 2;

	//if (_mouse_button == 1) then
	if (true) then
	{
		[_button_idc, _inventory] call _remove_item_from_container;
	};

PERF_END("_on_container_item_click")

};

_store_inventory_in_display =
{
PERF_BEGIN("_store_inventory_in_display")

	private ["_display", "_inventory", "_tmp"];

	_display   = _this select 0;
	_inventory = _this select 1;

	uinamespace setVariable ["FT2_RscGear_Inventory", str _inventory];
	//diag_log format ["!  store = %1", _inventory];

	[_inventory, _display] call _initial_fill_inventory_gui;

PERF_END("_store_inventory_in_display")
};

_restore_inventory_from_display =
{
	private ["_inventory"];

	_inventory = call compile (uinamespace getVariable "FT2_RscGear_Inventory");
	//diag_log format ["!restore = %1", _inventory];

	_inventory
};

_on_slot_click =
{
PERF_BEGIN("_on_slot_click")

	private ["_inventory", "_control_idc"];

	_inventory   = _this select 0;
	_control_idc = _this select 1;

	{
		private ["_slot", "_code"];

		_slot = _x select 0;
		_code = _x select 1;

		if (_slot == _control_idc) then
		{
			[_inventory, ""] call _code;
		};
	} forEach _assign_slot_item_to_inventory;

PERF_END("_on_slot_click")

};

_on_preset_click =
{
PERF_BEGIN("_on_preset_click")

        private ["_param", "_button", "_button_idc", "_display", "_preset_index", "_i"];

        _param = _this select 1;
            _button = _param select 0;
	        _button_idc = ctrlIDC _button;
                _display = ctrlParent _button;

	_preset_index = 0;
	_i = 1;
	{
		if (_x == _button_idc) then
		{
			_preset_index = _i;
		}
		else
		{
			(_display displayCtrl _x) ctrlSetText "A3\ui_f\data\gui\rsc\RscDisplayMultiplayerSetup\flag_opfor_empty_ca.paa";
		};

		_i = _i + 1;
	} forEach _all_preset_buttons;

	uiNamespace setVariable ["FT2_RscGear_CurrentPreset", _preset_index];

	if (_button_idc == IDC_Preset_0_button) then
	{
		[_display, Local_RscGear_SavedInventory] call _store_inventory_in_display;
	}
	else
	{
		_button ctrlSetText "A3\ui_f\data\gui\rsc\RscDisplayMultiplayerSetup\flag_opfor_ca.paa";

		private ["_inventory"];

		_inventory = _preset_index call _restore_preset;

		[_display, _inventory] call _store_inventory_in_display;
	};

PERF_END("_on_preset_click")

};

_store_preset =
{
PERF_BEGIN("_store_preset")

	private ["_inventory", "_preset_index", "_preset_namespace"];

	_inventory    = + _this select 0;
	_preset_index =   _this select 1;

	_preset_namespace = if (isNil "Config_PresetNamespace") then { "default" } else { Config_PresetNamespace };

	profileNamespace setVariable [format ["FT2_Preset_%1_%2_%3", _preset_namespace, Local_PlayerSide, _preset_index], _inventory];

PERF_END("_store_preset")

};

_restore_preset =
{
PERF_BEGIN("_restore_preset")

	private ["_preset_index", "_preset_namespace", "_inventory"];

	_preset_index = _this;

	_preset_namespace = if (isNil "Config_PresetNamespace") then { "default" } else { Config_PresetNamespace };

	_inventory = profileNamespace getVariable [format ["FT2_Preset_%1_%2_%3", _preset_namespace, Local_PlayerSide, _preset_index], [] call _get_empty_inventory_from_player];

	_inventory = + _inventory;

PERF_END("_restore_preset")

	_inventory
};

_precache_config =
{
PERF_BEGIN("_precache_config")

	private ["_vehicles_config", "_i"];

	if (isNil "Local_RscGear_east_uniform") then
	{
		Local_RscGear_east_uniform = [];
		Local_RscGear_west_uniform = [];

		Local_RscGear_east_vest = [];
		Local_RscGear_west_vest = [];

		Local_RscGear_east_headgear = [];
		Local_RscGear_west_headgear = [];

		_vehicles_config = configfile >> "CfgVehicles";

		for [{_i=0},{_i<count _vehicles_config},{_i=_i+1}] do
		{
			private ["_config"];

			_config = _vehicles_config select _i;

			if (isClass(_config)) then
			{
				if (getText(_config >> "uniformClass") != "") then
				{
					if ("Man" in ([_config, true] call BIS_fnc_returnParents)) then
					{
						private ["_side", "_uniform", "_uniform_naked", "_linked_items", "_vest", "_headgear"];

						_side          = getNumber(_config >> "side");
						_uniform       = getText  (_config >> "uniformClass");
						_uniform_naked = getText  (_config >> "nakedUniform");
						_linked_items  = getArray (_config >> "linkedItems");

						_vest     = "";
						_headgear = "";
						{
							if ([_x] call _is_vest) then
							{
								_vest = _x;
							};
							if ([_x] call _is_headgear) then
							{
								_headgear = _x;
							};
						} forEach _linked_items;

						switch (_side) do
						{
							case 0:
							{
								if ((_uniform  != "") && !(_uniform  in Local_RscGear_east_uniform))  then { Local_RscGear_east_uniform  set [count Local_RscGear_east_uniform,   _uniform] };
								if ((_vest     != "") && !(_vest     in Local_RscGear_east_vest))     then { Local_RscGear_east_vest     set [count Local_RscGear_east_vest,         _vest] };
								if ((_headgear != "") && !(_headgear in Local_RscGear_east_headgear)) then { Local_RscGear_east_headgear set [count Local_RscGear_east_headgear, _headgear] };
							};
							case 1:
							{
								if ((_uniform  != "") && !(_uniform  in Local_RscGear_west_uniform))  then { Local_RscGear_west_uniform  set [count Local_RscGear_west_uniform,   _uniform] };
								if ((_vest     != "") && !(_vest     in Local_RscGear_west_vest))     then { Local_RscGear_west_vest     set [count Local_RscGear_west_vest,         _vest] };
								if ((_headgear != "") && !(_headgear in Local_RscGear_west_headgear)) then { Local_RscGear_west_headgear set [count Local_RscGear_west_headgear, _headgear] };
							};
						};
					};
				};
			};
		};
	};

PERF_END("_precache_config")

};

_clear_seapon_stuff_controls =
{
	lnbClear IDC_Magazines_list;
	lnbClear IDC_Obves1_list;
	lnbClear IDC_Obves2_list;
	lnbClear IDC_Obves3_list;
};

switch (_action) do
{
    case "RscGear_onLoad":
    {
	Global_GearDialog_AllProfFunctionNames = [];
	Global_GearDialog_AllProfFunctionTimes = [];
	Global_GearDialog_AllProfFunctionConts = [];

PERF_BEGIN("RscGear_onLoad")

        private ["_param", "_display", "_inventory", "_current_primary_weapon"];

	[] call _precache_config;

        _param = _this select 1;
        _display = _param select 0;

	_inventory = [player] call Func_Client_GetPlayerInventory;

	_current_primary_weapon = _inventory select 13;

	Local_RscGear_InitialCost = _inventory call Func_Client_GetInventoryCost;

	if (isNil "Local_RscGear_SavedInventory") then
	{
		Local_RscGear_SavedInventory = + _inventory;
	};

        uiNamespace setVariable ["FT2_RscGear_CurrentPreset", 0];
	[_display, _inventory] call _store_inventory_in_display;

	["", [_display displayCtrl IDC_UniformSlot, 0], _inventory] call _on_container_slot_click;

	[_display] call _on_drag_and_drop_finished;

	Local_RscGear_Running = true;

	[_display] spawn
	{
		disableSerialization;

		private ["_display"];
		_display = _this select 0;

		while {Local_RscGear_Running} do
		{
			private ["_cash_control", "_upgrade_cost", "_current_cash", "_can_buy", "_ok_button_control"];

			_cash_control = _display displayCtrl IDC_Cash_text;

			_upgrade_cost = Local_RscGear_CurrentCost - Local_RscGear_InitialCost;

			_current_cash = call Func_Client_GetPlayerFunds;

			_cash_control ctrlSetText format["%1 $ %2.", localize "STR_WF_CashLabel", _current_cash];

			_can_buy = ((_current_cash - _upgrade_cost) >= 0);

			_ok_button_control = _display displayCtrl IDC_OK_button;
			_ok_button_control ctrlEnable _can_buy;
			_ok_button_control ctrlSetTextColor (if (_can_buy) then { [ 0, 1, 0, 0.5 ] } else { [1, 0, 0, 0.5] });

			sleep 1;
		};
	};

        //["RifleCore", _display, _current_primary_weapon] call _add_simplest_weapons;
PERF_END("RscGear_onLoad")
    };
    case "RscGear_onUnload":
    {
	/*
	private ["_i"];
	for "_i" from 0 to (count Global_GearDialog_AllProfFunctionNames) - 1 do
	{
		diag_log format ["%1,%2,%3", Global_GearDialog_AllProfFunctionNames select _i, Global_GearDialog_AllProfFunctionTimes select _i, Global_GearDialog_AllProfFunctionConts select _i];
	};
	*/
    };
    case "RscGear_onMouseButtonDown":
    {
    };
    case "RscGear_onMouseButtonUp":
    {
	PERF_BEGIN("RscGear_onMouseButtonUp")

        _param = _this select 1;
		_display = _param select 0;

        [_display] call _on_drag_and_drop_finished;

	PERF_END("RscGear_onMouseButtonUp")
    };

    case "Primary_button":
    {
	PERF_BEGIN("Primary_button")

	call _clear_seapon_stuff_controls;

        (_this + ["RifleCore"]) call _show_available_weapons_list;

	PERF_END("Primary_button")
    };
    case "Secondary_button":
    {
	PERF_BEGIN("Secondary_button")

	call _clear_seapon_stuff_controls;

        (_this + ["LauncherCore"]) call _show_available_weapons_list;

	PERF_END("Secondary_button")
    };
    case "Sidearms_button":
    {
	PERF_BEGIN("Sidearms_button")

	call _clear_seapon_stuff_controls;

        (_this + ["PistolCore"]) call _show_available_weapons_list;

	PERF_END("Sidearms_button")
    };
    case "Explosives_button":
    {
	PERF_BEGIN("Explosives_button")

		private ["_param", "_button", "_display", "_config_list"];
		
		call _clear_seapon_stuff_controls;

		_param = _this select 1;
			_button = _param select 0;
				_display = ctrlParent _button;

		_config_list = [];

		{
			private ["_all_kind", "_i"];

			_all_kind = configfile >> "CfgWeapons" >> _x;

			for [{_i = 0},{_i != count _all_kind},{_i = _i + 1}] do
			{
				private ["_muzzle"];

				_muzzle = _all_kind select _i;

				if (isClass _muzzle) then
				{
					private ["_magazines"];
				
					_magazines = getArray(_muzzle >> "magazines");
					{
						private ["_magazine_config", "_parents", "_is_allowed"];
					
						_magazine_config = configfile >> "CfgMagazines" >> _x;

						_parents = [_magazine_config, true] call BIS_fnc_returnParents;
						
						_is_allowed = [_magazine_config, _parents] call _is_weapon_allowed;

						if (_is_allowed && !(_magazine_config in _config_list)) then
						{
							_config_list set [count _config_list, _magazine_config];
						};
					} forEach _magazines;
				};
			};
		} forEach ["Throw", "Put"];

		[_display, _config_list, ""] call _set_weapons_list;

	PERF_END("Explosives_button")
    };
    case "Items_button":
    {
	PERF_BEGIN("Items_button")

	(_this +
	[
		{
			private ["_config"];

			_config = configFile >> "CfgWeapons" >> (_this select 0);

			(([_config, "ItemCore"] call _is_entity_of_type) || ([_config, "Binocular"] call _is_entity_of_type) || ([_config, "DetectorCore"] call _is_entity_of_type)) &&
			!((_this call _is_headgear) || (_this call _is_vest) || (_this call _is_uniform))
		}
	]
	) call _show_available_weapons_list_pred;

	PERF_END("Items_button")
    };
    case "Clothing_button":
    {
	PERF_BEGIN("Clothing_button")

	private ["_param", "_button", "_display", "_side_uniform", "_side_vest", "_side_headgear", "_config_list"];

	_param = _this select 1;
		_button = _param select 0;
			_display = ctrlParent _button;

	switch (playerSide) do
	{
		case east:
		{
			_side_uniform  = Local_RscGear_east_uniform;
			_side_vest     = Local_RscGear_east_vest;
			_side_headgear = Local_RscGear_east_headgear;

		};
		case west:
		{
			_side_uniform  = Local_RscGear_west_uniform;
			_side_vest     = Local_RscGear_west_vest;
			_side_headgear = Local_RscGear_west_headgear;
		};
	};

	_config_list = [];

	{
		_config_list set [count _config_list, configfile >> "CfgWeapons" >> _x];
	} forEach (_side_uniform + _side_vest + _side_headgear);

	[_display, _config_list, ""] call _set_weapons_list;

	PERF_END("Clothing_button")
    };
    case "Backpacks_button":
    {
	PERF_BEGIN("Backpacks_button")

	private ["_param", "_button", "_display", "_vehicles_config", "_config_list", "_i"];

	_param = _this select 1;
		_button = _param select 0;
			_display = ctrlParent _button;

	_vehicles_config = configfile >> "CfgVehicles";

//	_config_list = [_vehicles_config >> "B_Parachute"];
	_config_list = [];

	for [{_i = 0},{_i != count _vehicles_config},{_i = _i + 1}] do
	{
		private ["_item_config", "_item_config_name", "_is_item_packpack", "_no_default_items", "_can_carry_items"];

		_item_config      = _vehicles_config select _i;
		_item_config_name = configName(_item_config);

		_is_item_packpack = [_item_config_name] call Func_Client_IsBackpack;

		if (_is_item_packpack) then
		{
			_no_default_items = count (_item_config_name call _get_backpack_default_items) == 0;
			_can_carry_items  = getNumber(_item_config >> "maximumLoad") != 0;

			if (_no_default_items && _can_carry_items && (2 == getNumber(_item_config >> "scope"))) then
			{
				_config_list = _config_list + [_item_config];
			};
		};
	};

	[_display, _config_list, ""] call _set_weapons_list;

	PERF_END("Backpacks_button")
    };
    case "Goggles_button":
    {
	PERF_BEGIN("Goggles_button")

	private ["_param", "_button", "_display", "_glasses_config", "_config_list", "_i", "_item_config", "_has_model"];

	_param = _this select 1;
		_button = _param select 0;
	_display = ctrlParent _button;

	_glasses_config = configfile >> "CfgGlasses";

	_config_list = [];

	for [{_i = 0},{_i != count _glasses_config},{_i = _i + 1}] do
	{
		_item_config = _glasses_config select _i;

		_has_model = getText(_item_config >> "model") != "";

		if (_has_model) then
		{
			_config_list = _config_list + [_item_config];
		};
	};

	[_display, _config_list, ""] call _set_weapons_list;

	PERF_END("Goggles_button")
    };

    case "Weapons_list_onLBSelChanged":
    {
	PERF_BEGIN("Weapons_list_onLBSelChanged")

        private ["_current_row", "_weapon", "_weapon_config", "_set_compatible_magazines", "_compatible_gadgets", "_cows_slot", "_muzzle_slot", "_pointer_slot", "_set_compatible_items"];

        _current_row = lnbCurSelRow IDC_Weapons_list;

        if (_current_row != -1) then
        {
            _weapon = lnbData [IDC_Weapons_list, [_current_row,0]];
            _weapon_config = configFile >> "cfgWeapons" >> _weapon;

            _set_compatible_magazines =
            {
                private ["_list", "_items", "_config", "_a", "_item_config", "_item_config_name", "_item_display_name", "_item_picture", "_cost"];
                _list = IDC_Magazines_list;
                _items = _this select 0;

                lnbClear _list;

                _config = configfile >> "CfgMagazines";

                _a = 0;
                {
                    _item_config = _config >> _x;
		    _item_config_name = configName(_item_config);

                    _item_display_name = getText(_item_config >> "displayName");
                    _item_picture      = getText(_item_config >> "picture");

                    _cost = _item_config_name call _get_item_cost_str;
                    lnbAddRow     [_list, [_item_display_name, _cost]];
                    lnbSetPicture [_list, [_a, 0], _item_picture];
                    lnbSetData    [_list, [_a, 0], _item_config_name];
                    lnbSetValue   [_list, [_a, 0], _a];

                    _a = _a + 1;

                } forEach _items;

                lnbSetCurSelRow [_list, 0];
            };

            [_weapon_config call _get_weapon_compatible_magazines] call _set_compatible_magazines;

            _compatible_gadgets =
            {
                private ["_weapon_config", "_slot"];
                _weapon_config = _this select 0;
                _slot = _this select 1;
                getArray(_weapon_config >> "WeaponSlotsInfo" >> _slot >> "compatibleItems")
            };

            _cows_slot    = [_weapon_config, "CowsSlot"]    call _compatible_gadgets;
            _muzzle_slot  = [_weapon_config, "MuzzleSlot"]  call _compatible_gadgets;
            _pointer_slot = [_weapon_config, "PointerSlot"] call _compatible_gadgets;

            _set_compatible_items =
            {
                private ["_list", "_items", "_config", "_a"];
                _list = _this select 0;
                _items = _this select 1;

                lnbClear _list;

                _config = configfile >> "CfgWeapons";

                _a = 0;
                {
                    private ["_item_config", "_item_config_name", "_item_display_name", "_item_picture", "_cost"];
                    _item_config = _config >> _x;
                    _item_config_name = configName(_item_config);

                    _item_display_name = getText(_item_config >> "displayName");
                    _item_picture      = getText(_item_config >> "picture");

                    _cost = _item_config_name call _get_item_cost_str;
                    lnbAddRow     [_list, [_item_display_name, _cost]];
                    lnbSetPicture [_list, [_a, 0], _item_picture];
                    lnbSetData    [_list, [_a, 0], _item_config_name];
                    lnbSetValue   [_list, [_a, 0], _a];

                    _a = _a + 1;
                } forEach _items;

                lnbSetCurSelRow [_list, 0];
            };

            [IDC_Obves1_list, _cows_slot]    call _set_compatible_items;
            [IDC_Obves2_list, _muzzle_slot]  call _set_compatible_items;
            [IDC_Obves3_list, _pointer_slot] call _set_compatible_items;
        };

	PERF_END("Weapons_list_onLBSelChanged")
    };

    case "Weapons_list_onLBDblClick":
    {
	PERF_BEGIN("Weapons_list_onLBDblClick")

        private ["_param", "_control", "_display", "_index", "_inventory", "_weapon_config_name", "_compatible_slots", "_added"];

	_param = _this select 1;
		_control = _param select 0;
			_display = ctrlParent _control;
		_index   = _param select 1;

	_inventory = [_display] call _restore_inventory_from_display;

	_weapon_config_name = _control lnbData [_index, 0];

	_compatible_slots = [_weapon_config_name, _inventory] call _get_compatible_slots;

	_added = false;
	{
		private ["_compatible_slot"];

		_compatible_slot = _x;

		{
			private ["_slot", "_code", "_skip"];

			_slot = _x select 0;
			_code = _x select 1;

			_skip =
				(([_weapon_config_name] call _is_uniform)            && (_slot != IDC_UniformSlot))  ||
				(([_weapon_config_name] call _is_vest)               && (_slot != IDC_VestSlot))     ||
				(([_weapon_config_name] call Func_Client_IsBackpack) && (_slot != IDC_BackpackSlot));

			if ((!_skip) && (_slot == _compatible_slot) && (!_added)) then
			{
				[_inventory, _weapon_config_name] call _code;
				_added = !([[_display] call _restore_inventory_from_display, _inventory] call BIS_fnc_areEqual);

				if (_added) then
				{
					if (_slot in [IDC_UniformSlot, IDC_VestSlot, IDC_BackpackSlot]) then
					{
						["", [_display displayCtrl _slot, 0], _inventory] call _on_container_slot_click;
					};
				};
			};
		} forEach _assign_slot_item_to_inventory;
	} forEach _compatible_slots;

	[_display, _inventory] call _store_inventory_in_display;

	PERF_END("Weapons_list_onLBDblClick")
    };

    case "onAnyLBDrag":
    {
	PERF_BEGIN("onAnyLBDrag")

        private ["_param", "_control", "_display", "_inventory"];

	_param = _this select 1;
		_control = _param select 0;
			_display = ctrlParent _control;

	_inventory = [_display] call _restore_inventory_from_display;

	(_this + [_inventory]) call _on_drag_and_drop_started;

	PERF_END("onAnyLBDrag")
    };

    case "Slot_onMouseButtonClick":
    {
	PERF_BEGIN("Slot_onMouseButtonClick")

        private ["_param", "_control", "_control_idc", "_display", "_mouse_button", "_inventory"];

	_param = _this select 1;
		_control = _param select 0;
			_control_idc = ctrlIDC _control;
			_display     = ctrlParent _control;
		_mouse_button = _param select 1;

	if (_mouse_button == 1) then
	{
		_inventory = [_display] call _restore_inventory_from_display;

		[_inventory, _control_idc] call _on_slot_click;

		[_display, _inventory] call _store_inventory_in_display;
	};

	PERF_END("Slot_onMouseButtonClick")
    };

    case "Slot_onLBDrag":
    {
    };

    case "Slot_onLBDragging":
    {
	PERF_BEGIN("Slot_onLBDragging")

        private ["_param", "_control", "_display", "_inventory"];

	_param = _this select 1;
		_control = _param select 0;
			_display = ctrlParent _control;

	_inventory = [_display] call _restore_inventory_from_display;

        _result = (_this + [_inventory]) call _is_weapon_compatible_with_slot;

	PERF_END("Slot_onLBDragging")
    };
    case "Slot_onLBDrop":
    {
	PERF_BEGIN("Slot_onLBDrop")

        private ["_param", "_destination_control", "_destination_control_idc", "_display", "_inventory", "_dragged_items"];

	_param = _this select 1;
		_destination_control     = _param select 0;
		_destination_control_idc = ctrlIDC _destination_control;
			_display = ctrlParent _destination_control;

	_inventory = [_display] call _restore_inventory_from_display;

        _result = (_this + [_inventory]) call _is_weapon_compatible_with_slot;

        if (_result) then
        {
            _dragged_items = _param select 4;

            {
                private ["_item_type"];

                _item_type = _x select 2;

		{
			_slot = _x select 0;
			_code = _x select 1;

			if (_slot == _destination_control_idc) then
			{
				[_inventory, _item_type] call _code;
			};
		} forEach _assign_slot_item_to_inventory;

            } forEach _dragged_items;
        };

	[_display, _inventory] call _store_inventory_in_display;

	PERF_END("Slot_onLBDrop")
    };

    case "ContainerSlot_onMouseButtonClick":
    {
	PERF_BEGIN("ContainerSlot_onMouseButtonClick")

        private ["_param", "_control", "_display", "_inventory"];

	_param = _this select 1;
		_control = _param select 0;
			_display = ctrlParent _control;

	_inventory = [_display] call _restore_inventory_from_display;

	(_this + [_inventory]) call _on_container_slot_click;

	[_display, _inventory] call _store_inventory_in_display;

	PERF_END("ContainerSlot_onMouseButtonClick")
    };

    case "ContainerItem_onMouseButtonClick":
    {
	PERF_BEGIN("ContainerItem_onMouseButtonClick")

        private ["_param", "_control", "_display", "_inventory"];

	_param = _this select 1;
		_control = _param select 0;
			_display = ctrlParent _control;

	_inventory = [_display] call _restore_inventory_from_display;

	(_this + [_inventory]) call _on_container_item_click;

	[_display, _inventory] call _store_inventory_in_display;

	PERF_END("ContainerItem_onMouseButtonClick")
    };

    case "Clear_button":
    {
	PERF_BEGIN("Clear_button")

        private ["_param", "_button", "_display", "_inventory"];

        _param = _this select 1;
            _button = _param select 0;
                _display = ctrlParent _button;

        _inventory = [] call _get_empty_inventory_from_player;

	[_display, _inventory] call _store_inventory_in_display;

	PERF_END("Clear_button")
    };
    case "Save_button":
    {
	PERF_BEGIN("Save_button")

        private ["_param", "_button", "_display", "_preset_index", "_inventory"];

        _param = _this select 1;
            _button = _param select 0;
                _display = ctrlParent _button;

	_preset_index = uiNamespace getVariable "FT2_RscGear_CurrentPreset";

	_inventory = [_display] call _restore_inventory_from_display;

	if (_preset_index == 0) then
	{
		Local_RscGear_SavedInventory = _inventory;
	}
	else
	{
		[_inventory, _preset_index] call _store_preset;
	};

        [_button, false] call _save_button_color;

	player commandChat localize "STR_MES_LoadoutSaved";

	PERF_END("Save_button")
    };

    case "OK_button":
    {
	PERF_BEGIN("OK_button")

        private ["_param", "_button", "_display", "_inventory", "_cost"];

        _param = _this select 1;
            _button = _param select 0;
                _display = ctrlParent _button;

        _inventory = [_display] call _restore_inventory_from_display;

	_cost = Local_RscGear_CurrentCost - Local_RscGear_InitialCost;
	(-_cost) Call Func_Client_ChangePlayerFunds;
	Local_RscGear_InitialCost = Local_RscGear_CurrentCost;

	[player, _inventory] call Func_Client_EquipLoadout;

	uiNamespace setVariable ["FT2_RscGear_CurrentPreset", 0];
	{
		(_display displayCtrl _x) ctrlSetText "A3\ui_f\data\gui\rsc\RscDisplayMultiplayerSetup\flag_opfor_empty_ca.paa";
	} forEach _all_preset_buttons;

	[_inventory, _display] call _initial_fill_inventory_gui; // TODO: put debug here, get player loadout, check equal to _inventory, fix price

	PERF_END("OK_button")
    };

    case "Cancel_button":
    {
	PERF_BEGIN("Cancel_button")

        private ["_param", "_button", "_display"];

        _param = _this select 1;
            _button = _param select 0;
                _display = ctrlParent _button;

	_display closeDisplay 1;

	PERF_END("Cancel_button")
    };

    case "Preset_button":
    {
	PERF_BEGIN("Preset_button")

	_this call _on_preset_click;

	PERF_END("Preset_button")
    };

    default
    {
    };
};

_result
