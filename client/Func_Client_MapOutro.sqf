	//map outro

	closeDialog 0;

	0 fadeMusic 1;
	playMusic ["OutroM",0];
	0 fadeMusic 0.5;

	sleep 6;
	
	/*====================================*/
	//define east and west bonus
	_WestBonus=0;
	_EastBonus=0;	
	/*====================================*/
	
	//define outro end time
	cutText ["","black out",6.4];
	
	removeAllWeapons player;
	(vehicle player) enableSimulation false;
	(vehicle player) addEventHandler ['HandleDamage', {false}];
	
	sleep 2.3;
	titleRsc ["stats","plain",7];
	sleep 4.7;
	
	camDestroy Local_Camera;
	
	_ParsedText="";
	_state="";
	
	//check captured points
	for[{_i=0},{_i<count Config_TotalCheckPointData},{_i=_i+1}] do
	{
		_MarkerTaskColor=markerColor((Config_TotalCheckPointData select _i)select 3);
		//prepare task states according to points captured
		if(_MarkerTaskColor!=Local_FriendlyColor)then
		{
			_ParsedText=localize "STR_NAME_Failed";
			_state="Failed";
		}
		else
		{
			_ParsedText= localize "STR_NAME_Succeeded";
			_state="Succeeded";
		};
		//calculate side bonus, according to points captured
		_bonus=(Config_TotalCheckPointData select _i)select 16;	
		if (_MarkerTaskColor==Config_EastColor) then
		{
			_EastBonus=_EastBonus+_bonus;
		}
		else
		{
			if (_MarkerTaskColor==Config_WestColor) then
			{
				_WestBonus=_WestBonus+_bonus;
			};
		};
		//sideradio captured points, and set task states
		player sideChat format ["%1 %2: %3 - %4",localize "STR_NAME_Task",_i+1,localize ((Config_TotalCheckPointData select _i)select 1),_ParsedText];
		call compile format ["task%1 setTaskState ""%2"";",_i,_state];
	};
	//set variable
	//see Func_Client_CompileScoreStatistics
	Config_EastBaseFlag setVariable ["bonus",_EastBonus];
	Config_WestBaseFlag setVariable ["bonus",_WestBonus];
	
	setViewDistance Local_ViewDistance;
	
	//move player out of his vehicles and place them to respawn point
	player setVelocity [0,0,0];
	player setPos Local_SpawnPos;
	player setDamage 0;
	removeAllWeapons player;
	showCinemaBorder true;
	
	_position=Local_CameraTargets select 0;
	
	_Camera="camera" camCreate [_position select 0,_position select 1,0];
	_Camera camSetPos [_position select 0,_position select 1,100];
	_position=Local_CameraTargets select 1;
	_Camera camSetTarget [_position select 0,_position select 1,0];
	_Camera camSetFov 0.7000;
	_Camera cameraEffect ["internal","back"];
	_Camera camCommit 0;

	//setting effects
	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [ 0.7, 1, 0.001, [-2.08, -1.55, -1.9, 0.013],[1.69, 0.21, 0.79, 1.64],[-0.21, -1.08, 0.91, -0.09]];
	"colorCorrections" ppEffectCommit 0;
	waitUntil{camCommitted _Camera};
	
	sleep 3.2;
	
	_position=Local_CameraTargets select 2;
	
	_Camera camSetPos [_position select 0,_position select 1,100];
	_Camera camCommit 36;
	
	titleText ["","black in",0.6];
	cutText ["","black in",0.6];
	enableEnvironment false;
	
	sleep 3;
	
	//compile scores
	_Flag=Config_EastBaseFlag;
	_EastScore=_Flag getVariable "score";
	_EastPoints=_EastScore+_EastBonus;
	_Flag=Config_WestBaseFlag;
	_WestScore=_Flag getVariable "score";
	_WestPoints=_WestScore+_WestBonus;
	
	_WinnerScore=0;
	_WinnerBonus=0;
	_WinnerPoints=0;
	_ParsedText=localize "STR_NAME_NoWin";
	
	//determine owner and its points
	if(_EastPoints>_WestPoints)then
	{
		_WinnerScore=_EastScore;
		_WinnerBonus=_EastBonus;
		_WinnerPoints=_EastPoints;
		_ParsedText=localize "STR_NAME_EastWin";
	}
	else
	{
		if (_EastPoints<_WestPoints) then
		{
			_WinnerScore=_WestScore;
			_WinnerBonus=_WestBonus;
			_WinnerPoints=_WestPoints;
			_ParsedText=localize "STR_NAME_WestWin";
		};	
	};
	
	if (_ParsedText!=localize "STR_NAME_NoWin")then
	{
		_ParsedText=format ["<t align='center' size='1.2'  color='#000000'><t shadow='1' shadowColor='#565656'>%1</t></t><br/><t align='center' size='1.2'  color='#000000'><t shadow='1' shadowColor='#565656'>%2: %3 (%4 + %5 %6)</t></t>",_ParsedText,localize "STR_NAME_Score",_WinnerPoints,_WinnerScore,_WinnerBonus,localize "STR_NAME_Bonus"];
	};
	
	Local_MultiUseString=format ["<t align='center' size='1.5'  color='#000000'><t shadow='1' shadowColor='#565656'>%1</t></t>",_ParsedText];

	"DynamicBlur" ppEffectAdjust [0.0];
	"DynamicBlur" ppEffectCommit 0;
	"DynamicBlur" ppEffectEnable true;
	"DynamicBlur" ppEffectAdjust [4.0];
	"DynamicBlur" ppEffectCommit 20;
	
	sleep 1.2;		
	
	titleRsc ["final","plain",2];

	sleep 4.1;

	"colorCorrections" ppEffectAdjust [ 1.2, 1, 0.001, [-2.08, -1.55, -1.9, 0.013],[1.69, 0.21, 0.79, 1.64],[-0.21, -1.08, 0.91, -0.09]];
	"colorCorrections" ppEffectCommit 4;
	
	sleep 4.0;

	"colorCorrections" ppEffectAdjust [ 3, 1, 0.001, [-2.08, -1.55, -1.9, 0.013],[1.69, 0.21, 0.79, 1.64],[-0.21, -1.08, 0.91, -0.09]];
	"colorCorrections" ppEffectCommit 11;

	sleep 1.8;

	titleFadeOut 0.1;

	sleep 2.5;
	
	titleRsc ["stats","plain"];
	
	sleep 5;
	titleFadeOut 1.0;
	
	cutText ["","black out",4];

	sleep 4;
		
	setViewDistance Local_ViewDistance;	
	
	enableRadio true;
	
	0 fadeSound 0;
	
	player switchCamera "internal";
	player cameraEffect ["terminate","back"];
	camDestroy _Camera;
    
	endMission "End1";	
	