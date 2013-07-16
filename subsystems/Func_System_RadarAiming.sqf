_handler=Local_PlayerVehicle addEventHandler ["fired","_this call Func_System_GetFireMode"];
	
_index=System_HaveAARadarVehicleTypes find (typeOf Local_PlayerVehicle);

if (_index >= 0) then
{	
	_dist=System_HaveAARadarVehicleRanges select _index;
	while {(Local_PlayerVehicle!=player) && (player==gunner Local_PlayerVehicle) && (alive player) && (canFire Local_PlayerVehicle) && Local_RadarGuidanceOn} do
	{
		_found=objNull;
		{
			if ((_x isKindOf "air") && ((_x distance Local_PlayerVehicle) < _dist)) then
			{
				_pos=worldToScreen (getPosATL _x);				
				if ((count _pos) > 0) then
				{
					if (([_pos select 0,_pos select 1,0] distance [0.5,0.5,0]) < 0.12) exitWith
					{
						_found=_x;
					};
				};				
			};
		} forEach vehicles;
			
		if (isNull _found) then
		{
			System_RadarTrackedAircraft=objNull;
		}else{
			System_RadarTrackedAircraft=_found;
		};
		sleep 0.5;
	};
};
	
System_RadarTrackedAircraft=objNull;
Local_PlayerVehicle removeEventHandler ["fired",_handler];
Local_RadarGuidanceOn=false;
	
	