	//register new vehicle on the server for deletion after death
	//and on the local machine for marking on the map

	_veh=_this select 0;

	Local_RegisteredObjects=Local_RegisteredObjects+[_veh];

	if (isServer) then
	{
		Server_RegisteredObjects=Server_RegisteredObjects+[_veh];
	}
	else
	{
		Public_UnitRegistered=_veh;
		publicVariable "Public_UnitRegistered";
	};
	