/**/

while {!Global_GameEnded} do
{
	private ["_estimated_time_left"];

	_estimated_time_left = if (Param_RoundDuration < time) then { 5 } else { Param_RoundDuration-time };
	estimatedTimeLeft _estimated_time_left;
	sleep 60;
};

sleep Config_GameEndDelay;

endMission "End1";
