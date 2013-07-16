	_weatherChangePeriod=120;
	_weatherChangeValue=0.1;
	
	while{!Global_GameEnded}do
	{
		_TimeToStayIdle=_weatherChangePeriod+random(_weatherChangePeriod);
		_time=serverTime+_TimeToStayIdle;
		while{_time>serverTime}do
		{
			sleep 10;
		};

		_TimeToStayIdle=_weatherChangePeriod+random(_weatherChangePeriod*2);		
		_ForeCast=(1-_weatherChangeValue)+random(_weatherChangeValue);
		_TimeToStayIdle setOverCast _ForeCast;

		_time=serverTime+_TimeToStayIdle;
		while{_time>serverTime}do
		{
			sleep 10;
		};

		_TimeToStayIdle=_weatherChangePeriod+random(_weatherChangePeriod);
		_time=serverTime+_TimeToStayIdle;
		while{_time>serverTime}do
		{
			sleep 10;
		};
		_TimeToStayIdle=_weatherChangePeriod+random(_weatherChangePeriod*2);
		_ForeCast=random(_weatherChangeValue);
		_TimeToStayIdle setOverCast _ForeCast;		
		_time=serverTime+_TimeToStayIdle;
		while{_time>serverTime}do
		{
			sleep 1;
		};
	};