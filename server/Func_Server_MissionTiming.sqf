/**/
_time=Param_RoundDuration;
while{(_time > 0) && !Global_GameEnded} do
{
	_time=Param_RoundDuration-time;
	estimatedTimeLeft(_time);
	sleep 10;
};

Global_GameEnded=true;
"Global_GameEnded" call Func_Common_PublicVariable;

sleep Config_GameEndDelay;

endMission "End1";
