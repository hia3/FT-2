private ["_item", "_item_config", "_result"];

_item = _this select 0;

_item_config = configfile >> "CfgVehicles" >> _item;

_result = if (isClass(_item_config)) then { 1 == getNumber(_item_config >> "isbackpack") } else { false };

_result
