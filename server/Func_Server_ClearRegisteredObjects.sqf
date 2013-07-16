//param delete unmanned vehicles

while{!Global_GameEnded}do
{
	if ((count Server_RegisteredObjects) > 0) then
	{	
		_timer=serverTime;
		//first part - tracking and deleting destroyed vehicles
		if (({!(alive _x)} count Server_RegisteredObjects) > 0) then
		{
			_to_delete=[];
			{
				if (!alive _x) then
				{
					_time=_x getVariable "deathtime";
					if (format ["%1",_time]=="<null>") then
					{

						_x setVariable ["deathtime",_timer+Config_DeleteBodiesPeriod];
						
					}
					else
					{
						if (_time < _timer) then
						{
							Server_RegisteredObjects set [Server_RegisteredObjects find _x,objNull];
							//_x setVehicleInit "";
							_to_delete=_to_delete+[_x];				
						};
					}				
				};
			} forEach Server_RegisteredObjects;
			
			if ((count _to_delete) > 0) then
			{
				Server_RegisteredObjects=Server_RegisteredObjects-[objNull];		
				//processInitCommands;		
				{

					deleteVehicle _x;
				} forEach _to_delete;
			};	
		};
		//second part - tracking and deleting unmanned vehicles
		if (({alive _x} count Server_RegisteredObjects) > 0) then
		{
			_to_delete=[];
			{
				if (alive _x) then
				{
					if (({alive _x} count crew _x) > 0) then
					{
						if  ((_x getVariable "lastused")!=-1) then
						{
							_x setVariable ["lastused",-1,true];	
						};					
					}
					else
					{
						_time=_x getVariable "lastused";
						_format=format ["%1",_time];
						if ((_format=="<null>") || (_format=="-1")) then
						{
							_deleteUnmanned=_x getVariable "idle_time";
							_x setVariable ["lastused",_timer+_deleteUnmanned,true];
						}
						else
						{
							if (_time < _timer) then
							{
								Server_RegisteredObjects set [Server_RegisteredObjects find _x,objNull];
								//_x setVehicleInit "";
								_to_delete=_to_delete+[_x];				
							};
						}
					};
				};
			} forEach Server_RegisteredObjects;
			
			if ((count _to_delete) > 0) then
			{
				Server_RegisteredObjects=Server_RegisteredObjects-[objNull];		
				//processInitCommands;		
				{
					deleteVehicle _x;
				} forEach _to_delete;
			};	
		};
	};		
	sleep 1;	
};