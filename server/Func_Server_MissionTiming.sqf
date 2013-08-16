/**/

while {!Global_GameEnded} do
{
	estimatedTimeLeft (Param_RoundDuration-time);
	sleep 60;
};

sleep Config_GameEndDelay;

endMission "End1";
