while {!Global_GameEnded} do
{
	{_x setDamage 0} forEach ([] call Config_Hospitals);
	sleep 10;
};