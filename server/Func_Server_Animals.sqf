_track_animal =
{
	private ["_animal", "_marker"];

	_animal = _this select 0;
	_marker = _this select 1;

	_animal_fear = false;

	while {(alive _animal) && !(Global_GameEnded)} do
	{
		private ["_animal_pos", "_animal_x", "_animal_y", "_animal_dir", "_force_x", "_force_y"];

		_animal_pos = getPosATL _animal;
			_animal_x = _animal_pos select 0;
			_animal_y = _animal_pos select 1;
		_animal_dir = getDir _animal;

		_force_x = 0;
		_force_y = 0;

		{
			private ["_marker_pos", "_marker_x", "_marker_y", "_marker_size", "_marker_size_x", "_marker_size_y", "_marker_dir", "_marker_shape", "_dx", "_dy", "_surface_point_x", "_surface_point_y", "_surface_distance", "_nx", "_ny", "_k"];

			_marker_pos  = markerPos _x;
				_marker_x = _marker_pos select 0;
				_marker_y = _marker_pos select 1;
			_marker_size = markerSize _x;
				_marker_size_x = _marker_size select 0;
				_marker_size_y = _marker_size select 1;
			_marker_dir  = markerDir  _x;
			_marker_shape = markerShape _x;

			_dx = _animal_x - _marker_x;
			_dy = _animal_y - _marker_y;

			_surface_point_x = 0;
			_surface_point_y = 0;

			if ((_marker_shape == "ELLIPSE") || (_marker_shape == "RECTANGLE")) then
			{
				private ["_dx0", "_dy0", "_surface_dx0", "_surface_dy0", "_surface_dx1", "_surface_dy1"];

				_dx0 = (cos _marker_dir) * _dx - (sin _marker_dir) * _dy;
				_dy0 = (sin _marker_dir) * _dx + (cos _marker_dir) * _dy;

				_surface_dx0 = _dx0 min _marker_size_x max -_marker_size_x;
				_surface_dy0 = _dy0 min _marker_size_y max -_marker_size_y;

				_surface_dx1 = (cos (-_marker_dir)) * _surface_dx0 - (sin (-_marker_dir)) * _surface_dy0;
				_surface_dy1 = (sin (-_marker_dir)) * _surface_dx0 + (cos (-_marker_dir)) * _surface_dy0;

				_surface_point_x = _marker_x + _surface_dx1;
				_surface_point_y = _marker_y + _surface_dy1;
			};

			_surface_distance = [_surface_point_x, _surface_point_y, 0] distance [_animal_x, _animal_y, 0];

			_nx = (_animal_x - _surface_point_x) / _surface_distance;
			_ny = (_animal_y - _surface_point_y) / _surface_distance;

			_k = 10 / _surface_distance;

			_force_x = _force_x + _nx * _k;
			_force_y = _force_y + _ny * _k;

		} forEach _marker;

		_lever = 10;

		_lx = _lever * (sin _animal_dir) + _force_x;
		_ly = _lever * (cos _animal_dir) + _force_y;

		_new_dir = _lx atan2 _ly;

		_force_abs = [0, 0, 0] distance [_force_x, _force_y, 0];

		if (_force_abs > 3) then
		{
			_animal setDir _new_dir;
			_animal disableAI "MOVE";
			_animal_fear = true;
		};

		if ((_force_abs < 0.7) && _animal_fear) then
		{
			_animal enableAI "MOVE";
			_animal_fear = false;
		};

		sleep 0.1;
	};
};

_track_animals =
{
	private ["_animal_fence", "_animals"];

	_animal_fence = [];
	{
		if ((markerText _x) == "animal_fence") then
		{
			_animal_fence set [count _animal_fence, _x];
		};
	} forEach allMapMarkers;

	_animals = (allMissionObjects "Animal");

	{
		private ["_dummy"];

		_dummy = [_track_animal, [_x, _animal_fence]] call Func_Common_Spawn;

	} forEach _animals;
};

call _track_animals;
