	//marks friendly players on GPS
	
	#define MarkerColorGroup "ColorGreen";

	
	//if GPS is shown
	//see Func_Client_UpdateGUI
	if ((visibleMap) || (dialog) || Local_GUIActive) then
	{
		_i=1;
		{				
			//if units is actual
			if ((typeName _x)=="OBJECT") then
			{
				//compile marker name
				//see client`s precompile.sqf
				_marker=format["playerMarker%1",_i];
				if (alive _x) then
				{		
					_veh=vehicle _x;
					//if there are some people in the vehicle
					//show only one marker - we don`t need a lot of markers at one place
					//if unit is on foot, or this is player, show marker anyway
					if ((_veh==_x) || (_x==(effectiveCommander _veh)) || (_x==player)) then
					{						
						//if unit is a member of player`s group, mark him another color
						if (((_x getVariable "GroupNumber")==Local_PlayerGroupNumber) && (Local_PlayerGroupNumber!=-1)) then
						{
							_marker setMarkerColorLocal MarkerColorGroup;
						}
						else
						{
							_marker setMarkerColorLocal Local_FriendlyColor;
						};
						_marker setMarkerPosLocal (position _x);
						
						if (_veh==_x) then
						{
							//check marker setup
							//see Func_Dialog_HandleOptionsDialog
							if (Dialog_MapMarkersPType==1) then
							{
								_marker setMarkerTextLocal (_x getVariable "playername");
							}
							else
							{
								_marker setMarkerTextLocal "";
							};													

							if ("Medikit" in (items _x)) then
							{
								_marker setMarkerTypeLocal "mil_start";
								_marker setMarkerSizeLocal [0.4,0.4];
							}
							else
							{
								_marker setMarkerTypeLocal "mil_arrow2";
								_marker setMarkerSizeLocal [0.3,0.3];
							};

						}
						else
						{
							//check marker setup
							//see Func_Dialog_HandleOptionsDialog
							if (Dialog_MapMarkersPType==1) then
							{
								_marker setMarkerTextLocal ((_x getVariable "playername")+" - "+getText(configFile>>"cfgVehicles">>(typeOf _veh)>>"displayName"));
							}
							else
							{
								_marker setMarkerTextLocal getText(configFile>>"cfgVehicles">>(typeOf _veh)>>"displayName");
							};
						};					
						_marker setMarkerDirLocal (direction  (vehicle _x));
						
						if (_x==player) then
						{
							_marker setMarkerColorLocal "ColorWhite";
						};
					}
					else
					{
						//set marker to invisible area on the map
						_marker setMarkerPosLocal [15000,15000];
					};					
				}
				else
				{
					_marker setMarkerPosLocal [15000,15000];
				};				
			};
			_i=_i+1;
		} forEach Local_CurrentPlayers;		
	};
	