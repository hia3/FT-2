	//when player dies
	//see Func_Client_PlayerRespawn

	if (Local_OriginalFog > 0.6) then
	    {
		0 setFog 0.3;
	    };

	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [ 0.44, 1, 0, [-2.32, 0.17, 0.71, 0],[1.09, 0.91, 0.66, 0.27],[-1.24, 3.03, 0.37, -1.69]] ;
	"colorCorrections" ppEffectCommit 0;

	enableEnvironment false;
	playMusic ["Track02_SolarPower",0];
	0 fadeMusic 0.12;
	Local_Camera camSetTarget Local_PlayerVehicle;
	Local_Camera camSetRelPos [0.88,0.41,1.17];
	Local_Camera camSetFov 0.7000;
	Local_Camera camCommit 0;
	waitUntil{camCommitted Local_Camera};

	if(Global_GameEnded)exitWith{};
	Local_Camera camSetRelPos [0.1,0.1,10];
	Local_Camera camSetFov 0.7000;
	Local_Camera camCommit 10;
	sleep 6;

	"dynamicBlur" ppEffectEnable true; 
	"dynamicBlur" ppEffectAdjust [2.4]; 
	"dynamicBlur" ppEffectCommit 4;

	sleep 2;
	titleCut["","black out",1.0];
	sleep 2.0;
	2 fadeMusic 0.06;
	titleCut["","black in",3.0];
	"dynamicBlur" ppEffectEnable false; 
