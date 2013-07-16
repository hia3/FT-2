//Script adds and removes actions "Pick cargo" and "Drop cargo" to transport helicopters
/**/
_removepickaction=
{
	private["_action","_veh"];
	_veh=_this;
	
	_action=_veh getVariable "FT2_WF_ACT_Pick";
	if (format["%1",_action]!="<null>") then
	{
		_veh removeAction _action;
	};
};

_actadded = 0;
_cargo = nil;
System_HeliCargoTransportState=0;

while{(Local_PlayerVehicle!=player) && (alive Local_PlayerVehicle) && ((Local_PlayerVehicle emptyPositions "driver")==0) && (player in Local_PlayerVehicle)} do
{
	if ((System_HeliCargoTransportState==0) && (alive player) && (player==(driver Local_PlayerVehicle)) && ((getPosATL Local_PlayerVehicle select 2)>5)) then
 	{
		_vehicle = nearestObject [Local_PlayerVehicle, "LandVehicle"];
		if !(isNull _vehicle) then
 		{
			if ((_vehicle distance Local_PlayerVehicle) > 17) then
 			{
				Local_PlayerVehicle call _removepickaction;
				_actadded = 0;
			}
			else
			{
				if ((_vehicle!=_cargo) && (_actadded == 1)) then
				{
					Local_PlayerVehicle call _removepickaction;
					_actadded = 0;
				};
				if(_actadded==0) then
 				{
					_actadded = 1;
					_cargo = _vehicle;
					_name=gettext(configFile >> "CfgVehicles" >> (typeof _cargo) >> "displayName");
					_action=Local_PlayerVehicle addAction ["<t color='#00FF00'>" + format[localize "STR_ACT_PickCargo",_name] + "</t>","client\Script_Client_Actions.sqf",[13,_cargo],99,false,true,"", ""];
					Local_PlayerVehicle setVariable ["FT2_WF_ACT_Pick",_action];	
				};			
			};		
		};	
	}	
	else	
	{
		Local_PlayerVehicle call _removepickaction;
		_actadded = 0;
	};
	sleep 0.5;
};
Local_PlayerVehicle call _removepickaction;
_actadded = 0;
