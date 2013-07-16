	private["_marker","_body"];

	_marker=format["body%1",_this];

	_body=nearestObject[getMarkerPos _marker,"Man"];

	if (!isNull _body) then
	{
		if (!alive _body) then
		{
			deleteVehicle _body;
		};		
	};	

	deleteMarker _marker;
