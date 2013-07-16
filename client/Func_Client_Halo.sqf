/**/
Halo_Marker_Init = {
	if((isServer)&& (!(localplayer))) exitWith{};
	
	_markerName = format["%1_Halo",name player];	
	_marker = createMarker [_markerName ,  [-1,-1,0]];
	_marker setMarkerShapeLocal "ICON";
	_markerName setMarkerTypeLocal "mil_dot";
	_marker setmarkerColor "ColorOrange";
	_marker setMarkerText format["Halo %1",name player];
	
	onMapSingleClick {format['%1_Halo',name player] setMarkerPosLocal _pos; true;};
};

Halo_Marker_Remove = {
	deleteMarker format["%1_Halo",name player];
};

Halo_Jump_F = {
	_parashute = "B_parachute";
	_haloCost = 400;
	_HaloHeight = 1500;
	
	// Firstly, checks all conditions 
	if((secondaryWeapon player) !="")exitWith{
		hint format ["You cant use halo if you have secondary weapon.\nRemove %1.",secondaryWeapon player];
	};
	if( ((backpack player)!="" && ((backpack player)!=_parashute)) )exitWith{
		hint format ["You cant use halo if you have backpack.\nRemove %1.",(backpack player)];
	};
	_pos = getMarkerpos format["%1_Halo",(name player)]; 
	if( ((_pos select 0)<=0) &&  ((_pos select 1)<=0) ) exitWith{
		hint "Select coordinate on the minimap.";
	};
	if( (backpack player)==_parashute ) then{ 
		_haloCost = _haloCost - (_parashute call Func_Client_GetItemCost);
	}else{
		player addBackpack _parashute;
	};
	_cash = [] call Func_Client_GetPlayerFunds;
	if(_cash < _haloCost )exitWith{
		hint format["You can not afford to Halo\nMissing %1",_haloCost - _cash];
	};
	
	// YOU CAN
	closedialog 0;
	-_haloCost call Func_Client_ChangePlayerFunds;
	titleText ["Get Ready", "BLACK OUT",2];
	sleep 2.2;
	player setpos [_pos select 0,_pos select 1, _HaloHeight];
	titleText ["Don't forget about parashute", "BLACK IN",7];
	[] call Halo_Fall;
};

Halo_Fall = {
	_unit = player; 
	[] spawn{
		// FREEFALL 
		while { (alive player) && (vehicle player) == player} do {
			sleep 0.2;
		};

		//OPEN PARASHUTE
		_vehicle = vehicle player;
		while { alive player && ((position player) select 2)>2} do {
			sleep 0.2;
		};

		//TOUCH
		while {alive player &&  _vehicle == (vehicle player)}do{
			sleep 0.1;
		};
		//delete parachute to avoid explosion
		deleteVehicle _vehicle;
	};
};
