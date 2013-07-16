private ["_get_container_maximum_load", "_result"];

_get_container_maximum_load = 
{
	private ["_item", "_result"];

	_item = _this;

	_result = 0;

	if (_item != "") then
	{
		if (isClass(configfile >> "CfgVehicles" >> _item)) then
		{
			_result = getNumber(configfile >> "CfgVehicles" >> _item >> "maximumLoad");
		}
		else
		{
			_result = getText(configfile >> "CfgWeapons" >> _item >> "ItemInfo" >> "containerClass") call _get_container_maximum_load;
		};
	};

	_result
};

_result = _this call _get_container_maximum_load;

_result
