	sleep(1+random(1));
	while{!Global_GameEnded}do
	{
		sleep 10*60;
		Public_WeatherCode=[time,fog,overcast,rain];
		"Public_WeatherCode" call Func_Common_PublicVariable;
	};