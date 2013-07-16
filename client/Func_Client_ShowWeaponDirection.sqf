Local_IndirectFireMode=true;

_weapon=(weapons Local_PlayerVehicle) select 0;

while {!Global_GameEnded && (alive player) && (player==(gunner Local_PlayerVehicle)) && ((currentWeapon Local_PlayerVehicle) in System_IndirectWeaponsTypes) && Local_IndirectFireMode} do
{
	_dir=Local_PlayerVehicle weaponDirection _weapon;
	_h_dir=(_dir select 0) atan2 (_dir select 1);
	_v_dir=asin(_dir select 2);
	
	hintSilent format[localize "STR_HINT_WeapDir",round(_h_dir*100)/100,round(_v_dir*100)/100];
	
	sleep 0.1;
};

Local_IndirectFireMode=false;