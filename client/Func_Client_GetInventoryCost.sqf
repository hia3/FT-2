private ["_inventory", "_result"];

_inventory = _this;

_result = 0;

{
	_result = _result + (_x call Func_Client_GetItemCost);
} forEach (_inventory call Func_Client_InventoryToArray);

_result
