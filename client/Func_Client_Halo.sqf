/**/
Halo_Marker_Init = 
{
	private ["_markerName","_marker"];
	_markerName = format["%1_Halo", Local_PlayerName];	
	_marker = createMarker [_markerName ,  [-1,-1,0]];
	_marker setMarkerShapeLocal "ICON";
	_markerName setMarkerTypeLocal "mil_dot";
	_marker setmarkerColor "ColorOrange";
	_marker setMarkerText format["Halo %1", Local_PlayerName];
	
	onMapSingleClick {format['%1_Halo', Local_PlayerName] setMarkerPosLocal _pos; true;};
};

Halo_Marker_Remove = 
{
	deleteMarker format["%1_Halo", Local_PlayerName];
	onMapSingleClick "";
};

Halo_Jump_F = {
	private ["_parashute","_haloCost","_HaloHeight","_name","_pos","_cash","_pic"];
	_parashute = "B_parachute";
	_haloCost = 400;
	_HaloHeight = 2000;
	
	// Firstly, checks all conditions 
	if((secondaryWeapon player) !="")exitWith
	{
		_name = getText(configFile >> "cfgWeapons" >> (secondaryWeapon player) >> "displayName");
		_pic = getText(configFile >> "cfgWeapons" >> (secondaryWeapon player) >> "picture");
		[localize "STR_HINT_Warning",localize "STR_HINT_HALO_RemoveSecondaryWeapon" + _name,_pic ,1.0,"error_sound"] call Func_Client_ShowCustomMessage;
	};
	if( ((backpack player)!="" && ((backpack player)!=_parashute)) )exitWith
	{
		_name = getText(configFile >> "cfgVehicles" >> (backpack player) >> "displayName");	
		_pic = if((backpack player)!="")then{getText(configFile >> "cfgVehicles" >> (backpack player)  >> "picture")}else{ "pic\no.paa"};
		[localize "STR_HINT_Warning",localize "STR_HINT_HALO_RemoveBackpack" + _name,_pic,1.0,"error_sound"] call Func_Client_ShowCustomMessage;
	};
	_pos = getMarkerpos format["%1_Halo",( Local_PlayerName)]; 
	if( ((_pos select 0)<=0) &&  ((_pos select 1)<=0) ) exitWith
	{
	[localize "STR_HINT_Warning",localize "STR_HINT_HALO_SelectCoorinate","pic\no.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
	};
	if( (backpack player)==_parashute ) then
	{ 
		_haloCost = _haloCost - (_parashute call Func_Client_GetItemCost);
	}else
	{
		player addBackpack _parashute;
	};
	_cash = [] call Func_Client_GetPlayerFunds;
	if(_cash < _haloCost )exitWith
	{
		[localize "STR_HINT_Warning",localize "STR_HINT_LowFunds","pic\no.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
	};
	
	// YOU CAN
	closedialog 0;
	-_haloCost call Func_Client_ChangePlayerFunds;
	titleText [localize "STR_HINT_HALO_GetReady", "BLACK OUT",2];
	sleep 2.2;
	player setpos [_pos select 0,_pos select 1, _HaloHeight];
	titleText [localize "STR_HINT_HALO_DontForget", "BLACK IN",7];
	[] call Halo_Fall;
};

Halo_Fall = 
{	
	private ["_vehicle"];
	[
	{
		// FREEFALL 
		while { (alive player) && (vehicle player) == player} do 
		{
			sleep 0.2;
		};

		//OPEN PARASHUTE
		_vehicle = vehicle player;
		while { alive player && ((position player) select 2)>2} do 
		{
			sleep 0.2;
		};

		//TOUCH
		while {alive player &&  _vehicle == (vehicle player)}do
		{
			sleep 0.1;
		};
		//delete parachute to avoid explosion
		deleteVehicle _vehicle;
	}
	] call Func_Common_Spawn;
};
