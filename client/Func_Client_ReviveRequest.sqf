//player==_this means we are trying to revive somebody
//player!=_this means somebody is trying to revive us

_timing=
{
	_limit=time+30;
	while {Dialog_RespawnState=='reviving'} do
	{
		_value=round(_limit-time);
		ctrlSetText[4901,format["%1..",_value]];
		if (_value < 0) then {closeDialog 0};
		sleep 0.5;
	};	
};

if (player==_this) then
{
	_pos=getposATL _this;
	_unit=nearestObject [[(_pos select 0)+1.5*sin(getDir _this), (_pos select 1)+1.5*cos(getDir _this), _pos select 2],"Man"];
	
	if (!(isNull _unit) && (_unit!=_this) && !(alive _unit)) then
	{
		if (getNumber(configFile>>'CfgVehicles'>>typeOf _unit>>'side')==getNumber(configFile>>'CfgVehicles'>>typeOf _this>>'side')) then
		{
			_this playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep 5;			
			
			if (alive _this) then
			{
				Public_ReviveRequest=[player,_unit];
				publicVariable "Public_ReviveRequest";
			};
		}
		else
		{
			[localize "STR_WF_Revive",localize "STR_HINT_ReviveEnemy","\A3\ui_f\data\map\vehicleicons\pictureHeal_ca.paa",1.0,"error_sound"] call Func_Client_ShowCustomMessage;
		};
	};
}
else
{	
	if (Dialog_RespawnState!='reviving') then
	{
		Dialog_RespawnState='reviving';
		
		Local_ReviverUnit=_this;
		
		waitUntil{alive player};
		
		sleep ((Dialog_RespawnDeathTime-time+15) max 0);
		
		createDialog "RscReviveRequest";
		ctrlSetText[4900,format[localize "STR_WF_Revive_Text",Local_ReviverUnit getVariable "playername"]];
		[] spawn _timing;
	};
};