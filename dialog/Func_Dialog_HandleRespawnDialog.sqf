	private["_display","_tip","_map","_markers","_markerIndex","_markerName","_spawn","_ta","_delay","_index","_state","_cost","_position","_respawnText","_funds"];
	
	disableSerialization;
	_display=_this select 0;

	_tip = _display DisplayCtrl 15000;
	_map = _display DisplayCtrl 15001;

	_last_tip_time = time;
	_tip_shown     = true;
	_number_of_tips = 37;
	_tip_indexes = [];
	for "_i" from 1 to _number_of_tips do
	{
		_tip_indexes = _tip_indexes + [_i];
	};
	_tip_indexes = _tip_indexes call BIS_fnc_arrayShuffle;
	_tip_current_index = 0;
	
	//create yellow round markers on available spawn-positions
	_markers = [];
	_markerIndex = 0;
	{
		_markerName = Format ["spawn%1",_markerIndex];
		_markers = _markers + [_markerName];
		createMarkerLocal [_markerName,getMarkerPos (_x select 0)];
		_markerName setMarkerTypeLocal "selector_selectedFriendly";
		_markerName setMarkerColorLocal "ColorYellow";
		_markerName setMarkerSizeLocal [1,1];
		_markerIndex = _markerIndex + 1;
	} forEach Local_FriendlySpawnPoints;
	
	//get a desired respawn marker
	_spawn=(Local_FriendlySpawnPoints select Dialog_RespawnCurrentPoint) select 0;	
	
	_map ctrlMapAnimAdd [2,0.16,getMarkerPos _spawn];
	ctrlMapAnimCommit _map;
	
	//create a rotating yellow marker on the desired spawn position	
	_ta=["TempAnim",_spawn,"selector_selectedMission",1.4,"ColorYellow"] spawn Func_Dialog_MarkerAnim;
	
	//disable "respawn" button
	ctrlEnable [3904,false];
	
	_cost=FT2_WF_Logic getVariable "currentCost";
	
	//main cycle.. until player presses "respawn" button
	Dialog_RespawnState="idle";		
	_state=Dialog_RespawnState;

	while {(dialog) && ((_state=="idle") || (_state=="reviving")) && (alive player)} do
	{
		if ((time - _last_tip_time < 3) && _tip_shown) then
		{
			_tip_shown = false;
			_tip ctrlShow false;
		}
		else
		{
			if ((time - _last_tip_time > 3) && (time - _last_tip_time < 18) && !_tip_shown) then
			{
				_tip_shown = true;

				_tip_index = toArray(str(_tip_indexes select _tip_current_index));
				while {(count _tip_index) < 3} do { _tip_index = toArray("0") + _tip_index};
				_tip_index_str = "STR_TIP_" + toString(_tip_index);

				_tip ctrlSetStructuredText parseText format ["<br/><t align='center' size='1.2' color='#FFDEAD'>Tip: </t><t align='center' size='1.2' color='#dddddd'>%1</t>", localize _tip_index_str];

				_tip ctrlShow true;
				playSound "tip_sound";

				_tip_current_index = if (_tip_current_index >= (_number_of_tips - 1)) then { 0 } else { _tip_current_index + 1 };
				if (_tip_current_index == 0) then
				{
					_tip_indexes = _tip_indexes call BIS_fnc_arrayShuffle;
				};
			};
			if (time - _last_tip_time > 18) then
			{
				_last_tip_time = time;
			};
		};

		if (!dialog) exitWith {};
		
		_state=Dialog_RespawnState;
		switch (_state) do
		{
			//waiting and timing mode.. process respawn
			//countdown and respawn point selection
			case "idle":
			{	
				//spawn point selection
				if ((FT2_WF_Logic getVariable "MouseButtonUp") == 0) then 
				{			
					FT2_WF_Logic setVariable ["MouseButtonUp",-1];
					if (count Local_FriendlySpawnPoints > 1) then 
					{
						_position=_map PosScreenToWorld (FT2_WF_Logic getVariable "MousePos");
						
						_index=[_position,Local_FriendlySpawnPoints] Call Func_Dialog_SortByDistance;				
						if ((getMarkerPos ((Local_FriendlySpawnPoints select _index) select 0)) distance _position < 100) then 
						{
							_spawn=(Local_FriendlySpawnPoints select _index) select 0;
							
							Dialog_RespawnCurrentPoint=_index;
							Dialog_RespawnMarkerAnimation=false;
							terminate _ta;
							deleteMarkerLocal "TempAnim";
							_ta=["TempAnim",_spawn,"selector_selectedMission",1.4,"ColorYellow"] spawn Func_Dialog_MarkerAnim;																			
						};
					};
				};
				
				//replace yellow markers on moving MHQ`s
				_markerIndex = 0;
				{				
					(_markers select _markerIndex) setMarkerPosLocal getMarkerPos (_x select 0);				
					_markerIndex = _markerIndex + 1;
				} forEach Local_FriendlySpawnPoints;
				
				//respawn countdown
				_respawnText="";
				_delay=Config_SpawnDelay-time+Dialog_RespawnDeathTime;
				
				if (_delay > 0) then
				{
					//respawndelay not passed yet
					_respawnText=format[localize "STR_DLG_RespawnDelay",floor _delay];			
				};						
				ctrlSetText[15003, _respawnText];	
				
				_funds=[] call Func_Client_GetPlayerFunds;		
				ctrlSetText[15002, format [localize "STR_DLG_RespawnPoint",(Local_FriendlySpawnPoints select Dialog_RespawnCurrentPoint) select 1]];
				ctrlSetText[15004, format [localize "STR_DLG_RespawnFunds",_funds]];		
				ctrlSetText[15005, format [localize "STR_DLG_RespawnCost",_cost]];		

				//enable "respawn" button only if
				//-respawn delay passed
				//-player has enough money to buy his weapons
				//-captured respawn point selected
				if ((_respawnText=="") && (_funds > 0) && (getMarkerColor _spawn==Local_FriendlyColor)) then
				{
					ctrlEnable[3904,true];
				}
				else
				{
					ctrlEnable[3904,false];
				};
			};
			//player pressed "loadout" button
			case "changeloadout":
			{
				closeDialog 0;
				waitUntil{!dialog};
				createDialog "RscGear";
			};
			//player pressed "respawn" button
			//don`t need to do anything
			case "readytospawn":
			{
				
			};
		};
		sleep 0.5;		
	};
	//deleting yellow markers
	{deleteMarkerLocal _x} forEach _markers;
	if (!alive player) then
	{
		closeDialog 0;
	};
