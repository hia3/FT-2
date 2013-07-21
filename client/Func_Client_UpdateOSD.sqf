	_fast_op_timer=0;
	_slow_op_timer=0;
	
	_playerInVehicle         = false;
	_commanderScanner        = false;

	_lasers=[];
	
	_laser_spot_types = if (Local_PlayerSide==east) then { ["LaserTargetE"] } else { ["LaserTargetW"] };
	
	while {!Global_GameEnded && !visibleMap && Local_GUIActive && (alive player) && !Local_GUIRestart} do
	{
		_timer=time;
		
		if (_fast_op_timer < _timer) then
		{
			_fast_op_timer = _timer + 0.5;
			
			Local_PlayerIsMedic = ("Medikit" in (items player));
			
			_playerInVehicle  = (Local_PlayerVehicle != player);
			_commanderScanner = (_playerInVehicle && (player==(commander Local_PlayerVehicle)) && (cameraView=="Gunner"));
			
			if (_playerInVehicle) then
			{
				private ["_destination_reached", "_is_commander_not_here", "_is_driver_not_here", "_is_gunner_not_here"];
					
				_destination_reached   = if ((count Local_TankDrivePos) == 0) then { false } else { (player distance Local_TankDrivePos) < 3 };
				_is_commander_not_here = isNull (commander Local_PlayerVehicle);
				_is_driver_not_here    = isNull (driver    Local_PlayerVehicle);
				_is_gunner_not_here    = isNull (gunner    Local_PlayerVehicle);
			
				if (_destination_reached || _is_driver_not_here || _is_commander_not_here) then
				{
					Local_TankDrivePos=[];
					
					if (_destination_reached) then
					{
						Local_PlayerVehicle say ["arrived", 1];
					};
				};
				
				if (_is_gunner_not_here || _is_commander_not_here) then
				{
					Local_TankFirePos=[];
				};
			}
			else
			{
				Local_TankDrivePos=[];
				Local_TankFirePos=[];
			};
			
			if (_commanderScanner) then
			{
				_pos=screenToWorld [0.5, 0.5];
				
				if ((_pos distance Local_PlayerVehicle) < viewDistance) then
				{
					Local_CommanderDetectedVehicles=(_pos nearEntities ["LandVehicle", 100]) - [Local_PlayerVehicle];
				};
			}
			else
			{
				Local_CommanderDetectedVehicles = [];
			};
			
			if (_slow_op_timer < _timer) then
			{
				_slow_op_timer = _timer + 2;
				
				if (_playerInVehicle) then
				{
					_isArmedVehicle = (0 != count(getArray(configFile >> "CfgVehicles" >> (typeOf Local_PlayerVehicle) >> "weapons")));
					
					if (_isArmedVehicle) then
					{
						Local_LaserSpots = (position Local_PlayerVehicle) nearEntities [_laser_spot_types, 5000];
					};
				}
				else
				{
					Local_LaserSpots = [];
				};
			};
		};
		
		sleep 0.1;
	};
