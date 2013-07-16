	Private["_count","_nearest","_nearestDistance","_total"];

	_position=_this select 0;
	_spawnpoints=_this select 1;

	_total=count _spawnpoints;
	_nearest=0;
	_nearestDistance=100000;
	
	for [{_count=0},{_count<_total},{_count=_count + 1}] do 
	{		
		_distance=(getMarkerPos ((_spawnpoints select _count)select 0)) distance _position;
		if (_distance < _nearestDistance) then
		{
			_nearest=_count;
			_nearestDistance=_distance;
		};
	};
	
	_nearest
	
	