	sleep(1+random(1));
	while{!Global_GameEnded}do
	{
		sleep 10*60;
		Public_WeatherCode=[time,fog,overcast,rain];
		publicVariable "Public_WeatherCode";
	};