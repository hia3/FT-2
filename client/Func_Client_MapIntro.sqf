	/*disableUserInput true;*/	
	//create camera to block player movements while intro is passing

	enableEnvironment false;
	setViewDistance Local_ViewDistance;
	_position = getPos player;

	//Preparing camera
	Local_OriginalFog = fog;

if (Local_OriginalFog > 0.6) then
    {
	0 setFog 0.2;
    };

	Local_Camera="camera" camCreate [_position select 0,_position select 1,3000];
	Local_Camera cameraEffect ["internal","top"];
	sleep 0.4;
	Local_MultiUseString="<t align='center' size='1.2' color='#787878'>Loading Mission. Please Wait...</t>";
	titleRsc ["pauseg","plain",1];
	sleep 2.8;
	titleFadeOut 0.3;
	sleep 1.0;

if (Localshowintro) then
    {
    //starting intro

	Local_MultiUseString="<t align='center' size='1.2' color='#787878'>Loading Mission. Please Wait...</t>";
	titleRsc ["pauseg","plain",1];
	sleep 2.8;
	titleFadeOut 0.3;
	playMusic ["IntroM",0];

	//setting camera
	Local_Camera camSetTarget _position;
	Local_Camera camSetRelPos [0.0, -0.1, 3000];
	Local_camera camCommitPrepared 0;
	Local_Camera camSetRelPos [0.0, -0.1, 2];
	Local_camera camCommitPrepared 34.67;

	//setting effects
	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [ 0.7, 1, 0.001, [-2.08, -1.55, -1.9, 0.013],[1.69, 0.21, 0.79, 1.64],[-0.21, -1.08, 0.91, -0.09]];
	"colorCorrections" ppEffectCommit 0;
	
	//continuing intro
	sleep 8.4;	
	Local_MultiUseString="<t align='center' size='3.0' color='#dddddd'>Hi,A3 Project Presents</t>";
	titleRsc ["credits","plain",7];
	sleep 5.9;
	titleFadeOut 0.2;
	sleep 2.1;
	titleCut ["","black in",0.2];

	"dynamicBlur" ppEffectEnable true; 
	"dynamicBlur" ppEffectAdjust [0.0]; 
	"dynamicBlur" ppEffectCommit 0;

	sleep 2.5;

	"dynamicBlur" ppEffectAdjust [1.0]; 
	"dynamicBlur" ppEffectCommit 3.8;

	sleep 1.6;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'><t shadow='1' shadowColor='#565656'>The Enhanced Capture and Hold Map</t></t>";
	titleRsc ["about","plain",2];
	sleep 3.3;
	titleFadeOut 0.2;
	sleep 0.9;
	Local_MultiUseString="<t align='left' size='1.8' color='#000000'><t shadow='1' shadowColor='#565656'>Based on Valhalla gamemode sources</t></t><br/><t align='left' size='1.6' color='#000000'><t shadow='1' shadowColor='#565656'>Originally made by WINSE and Roman.Val</t></t>";
	titleRsc ["copyright","plain",2];
	sleep 3.3;
	titleFadeOut 0.2;
	sleep 0.7;
	Local_MultiUseString="<t align='center'><t size='10.0' color='#ffffff'><img image='pic\ft2.paa'></t><br/><t size='8.0' color='#000000'><t shadow='1' shadowColor='#565656'>"+Config_MissionName+"</t></t></t>";
	titleRsc ["Logo","plain",1.8];

	"radialBlur" ppEffectAdjust [0.01,0.01,0.0,0.0];
	"radialBlur" ppEffectCommit 4.3;
	"radialBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [0.0]; 
	"dynamicBlur" ppEffectCommit 4.3;

	sleep 4.2;

	"dynamicBlur" ppEffectEnable false;
	titleFadeOut 0.3;
	sleep 0.7;
	titleCut["","black out",1.0];


    //End of Intro

    };

	sleep 1.0;
	camDestroy Local_Camera;
	Local_Camera="camera" camCreate [0,0,0];
	Local_Camera cameraEffect ["internal","back"];
	sleep 0.3;
	titleCut["","black in",4.0];

	[player] spawn Func_Client_PlayerRespawn;

	"radialBlur" ppEffectEnable false;
	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [ 0.44, 1, 0, [-2.32, 0.17, 0.71, 0],[1.09, 0.91, 0.66, 0.27],[-1.24, 3.03, 0.37, -1.69]] ;
	"colorCorrections" ppEffectCommit 0;

	Local_MultiUseString=format ["<t align='center' shadow='true' size='1.5'  color='#dddddd'>%1</t>",localize "STR_NAME_BattleOver"];
