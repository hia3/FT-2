	//marks friendly vehicles on the map

	//Local_RegisteredObjects - see client`s precompile.sqf & Func_Client_RegisterCustomVehicle
	if ((count Local_RegisteredObjects)>0) then
	{
		_timer=serverTime;
		_clearance=false;
		_i=0;
		{
			//if vehicle was just added 
			//see client`s precompile.sqf
			//handle it and prepare for further operations
			if ((typeName _x)!="ARRAY") then
			{
				_name=format["m%1",_x];
				createMarkerLocal [_name,position _x];				

				_name setMarkerTypeLocal "mil_dot";
				_name setMarkerColorLocal "ColorGreen";
				//_name setMarkerSizeLocal [0.8,0.8];
				
				Local_RegisteredObjects set [_i,[_x,_name]];			
			}
			else
			{
				//get vehicle & its marker
				_vehicle=_x select 0;
				_marker=_x select 1;
				if (!isNull _vehicle) then
				{					
					_name=getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
					if (alive _vehicle) then
					{
						if (({alive _x} count crew _vehicle)==0) then
						{
							//adjust marker text
							//according to setup
							//see Func_Dialog_HandleOptionsDialog
							switch (Dialog_MapMarkersVType) do
							{
								case 0:
								{
									_name="";
								};
								case 2:
								{
									_name=format["%1-%2",_name,([(_vehicle getVariable "lastused")-_timer,false] call Func_Client_ConvertToTime)];
								};
								case 3:
								{
									_name=format["%1(%2)-%3",_name,_vehicle getVariable "owner_name",([(_vehicle getVariable "lastused")-_timer,false] call Func_Client_ConvertToTime)];
								};
							};
							
							_marker setMarkerPosLocal position _vehicle;
							_marker setMarkerTextLocal _name;
						}
						else
						{
							_marker setMarkerPosLocal [150000,150000];
						};
					}
					else
					{
						if (Dialog_MapMarkersVType==0) then {_name=""};
						_marker setMarkerPosLocal position _vehicle;
						_marker setMarkerSizeLocal [1.5,1.5];
						_marker setMarkerTypeLocal "waypoint";						
						_marker setMarkerTextLocal format [" %1",_name];
					};
				}
				else
				{
					//server side performes dead vehicle clearance
					//see Func_Server_ClearRegisteredObjects
					//remove existing marker
					deleteMarkerLocal _marker;
					Local_RegisteredObjects set [_i,objNull];
					_clearance=true
				};
			};
			_i=_i+1;
		} forEach Local_RegisteredObjects;
		
		if (_clearance) then
		{
			Local_RegisteredObjects=Local_RegisteredObjects-[objNull];
		};		
	};
	