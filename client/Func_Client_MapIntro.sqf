	/*disableUserInput true;*/	
	//create camera to block player movements while intro is passing

	//showHUD false;
	Local_OriginalFog = fog;

	Local_MultiUseString="";
	setViewDistance Local_ViewDistance;

	//Preparing camera
	_position = getPos player;
	enableEnvironment false;
//	enableRadio false;
	showcinemaborder false;

if (Localshowintro) then
    {

	if (Local_OriginalFog > 0.6) then
	    {
		0 setFog 0.2;
	    };

	Local_Camera="camera" camCreate [_position select 0,_position select 1,3000];
	Local_Camera cameraEffect ["internal","top"];

    //starting intro

	playMusic ["IntroM", 0];
    };

	sleep 1.0;
	Local_MultiUseString="<t align='center' size='1.2' color='#787878'>Loading Mission. Please Wait...</t>";
	titleRsc ["loading","plain"];
	sleep 2.6;
	titleFadeOut 0.3;

if (Localshowintro) then
    {
	//setting camera
	Local_Camera camSetTarget _position;
	Local_Camera camSetRelPos [0.0, -0.1, 3000];
	Local_camera camCommitPrepared 0;

	//setting effects
	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [ 0.7, 1, 0.001, [-2.08, -1.55, -1.9, 0.013],[1.69, 0.21, 0.79, 1.64],[-0.21, -1.08, 0.91, -0.09]];
	"colorCorrections" ppEffectCommit 0;
	
	//continuing intro

	sleep 1.7;	

	Local_MultiUseString="<t align='center' size='3.0' color='#dddddd'>Hi,A3 Project Presents</t>";
	titleRsc ["credits","plain"];

	Local_MultiUseString="<t align='center' size='3.0' color='#FF0000'>Hi,A3 Project Presents</t>";
	CutRsc ["credits_r","black"];
	sleep 0.1;
	Local_MultiUseString="<t align='center' size='3.0' color='#0000FF'>Hi,A3 Project Presents</t>";
	CutRsc ["credits_b","black"];
	sleep 0.1;

	cutRsc ["BackBlack","plain"];

	Local_MultiUseString="<t align='center' size='3.0' color='#66FFCC'>Hi,A3 Project Presents</t>";
	titleRsc ["credits","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='center' size='3.0' color='#dddddd'>Hi,A3 Project Presents</t>";
	titleRsc ["credits","plain"];
	sleep 0.3;

	Local_MultiUseString="<t align='center' size='3.0' color='#66FFCC'>Hi,A3 Project Presents</t>";
	titleRsc ["credits","plain"];
	sleep 0.2;
	Local_MultiUseString="<t align='center' size='3.0' color='#dddddd'>Hi,A3 Project Presents</t>";
	titleRsc ["credits","plain"];
	sleep 0.3;

	Local_MultiUseString="<t align='center' size='3.0' color='#0000FF'>Hi,A3 Project Presents</t>";
	CutRsc ["credits_bl","black"];
	sleep 0.1;
	Local_MultiUseString="<t align='center' size='3.0' color='#FF0000'>Hi,A3 Project Presents</t>";
	CutRsc ["credits_rr","black"];
	sleep 0.1;

	cutRsc ["BackBlack","plain"];

	titleFadeOut 0.1;

	sleep 1.3;

	Local_Camera camSetRelPos [0.0, -0.1, 1900];
	Local_camera camCommitPrepared 0;
	Local_Camera camSetRelPos [0.0, -0.1, 1600];
	Local_camera camCommitPrepared 0.1;

	titleCut ["","black in",0.1];

	sleep 0.1;
	Local_Camera camSetRelPos [0.0, -0.1, 2];
	Local_camera camCommitPrepared 17.67;

	sleep 0.6;

	"chromAberration" ppEffectAdjust [0.1,0.1,true]; 
	"chromAberration" ppEffectCommit 0;
	"chromAberration" ppEffectEnable true;

	"radialBlur" ppEffectAdjust [0.02,0.02,0.35,0.35];
	"radialBlur" ppEffectCommit 0;
	"radialBlur" ppEffectEnable true;
	sleep 0.1;
	"radialBlur" ppEffectEnable false;
	sleep 0.1;
	"radialBlur" ppEffectEnable true;
	sleep 0.1;
	"radialBlur" ppEffectEnable false;
	sleep 0.1;
	"radialBlur" ppEffectEnable true;
	sleep 0.1;
	"radialBlur" ppEffectEnable false;
	sleep 0.1;
	"radialBlur" ppEffectEnable true;
	sleep 0.1;

	"radialBlur" ppEffectEnable false;
	"chromAberration" ppEffectEnable false;

	"dynamicBlur" ppEffectAdjust [0]; 
	"dynamicBlur" ppEffectCommit 0;
	"dynamicBlur" ppEffectEnable true;

	sleep 1.25;

	Local_Camera camSetRelPos [0.0, -0.1, 1250];
	Local_camera camCommitPrepared 0;
	Local_Camera camSetRelPos [0.0, -0.1, 2];
	Local_camera camCommitPrepared 16.5;

	"dynamicBlur" ppEffectAdjust [0.8]; 
	"dynamicBlur" ppEffectCommit 0;

	sleep 0.1;

	Local_MultiUseString="<t align='right' size='1.9' color='#484848'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_split_t","plain"];
	Local_MultiUseString="<t align='right' size='1.9' color='#5d5d5d'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_b","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'><t shadow='1' shadowColor='#565656'>The Enhanced Capture and Hold mode</t></t>";
	titleRsc ["about_end","plain"];
	sleep 0.1;

	Local_MultiUseString="<t align='right' size='1.9' color='#484848'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_split_t","plain"];
	Local_MultiUseString="<t align='right' size='1.9' color='#5d5d5d'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_b","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'><t shadow='1' shadowColor='#565656'>The Enhanced Capture and Hold mode</t></t>";
	titleRsc ["about_end","plain"];
	sleep 0.1;

	Local_MultiUseString="<t align='right' size='1.9' color='#484848'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_split_t","plain"];
	Local_MultiUseString="<t align='right' size='1.9' color='#5d5d5d'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_b","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'><t shadow='1' shadowColor='#565656'>The Enhanced Capture and Hold mode</t></t>";
	titleRsc ["about_end","plain"];
	sleep 0.1;

	Local_MultiUseString="<t align='right' size='1.9' color='#484848'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_split_t","plain"];
	Local_MultiUseString="<t align='right' size='1.9' color='#5d5d5d'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_b","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'><t shadow='1' shadowColor='#565656'>The Enhanced Capture and Hold mode</t></t>";
	titleRsc ["about_end","plain"];
	sleep 0.1;

	Local_MultiUseString="<t align='right' size='1.9' color='#484848'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_split_t","plain"];
	Local_MultiUseString="<t align='right' size='1.9' color='#5d5d5d'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_b","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'><t shadow='1' shadowColor='#565656'>The Enhanced Capture and Hold mode</t></t>";
	titleRsc ["about_end","plain"];
	sleep 0.1;

	Local_MultiUseString="<t align='right' size='1.9' color='#484848'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_split_t","plain"];
	Local_MultiUseString="<t align='right' size='1.9' color='#5d5d5d'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_b","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'><t shadow='1' shadowColor='#565656'>The Enhanced Capture and Hold mode</t></t>";
	titleRsc ["about_end","plain"];

	"dynamicBlur" ppEffectAdjust [0]; 
	"dynamicBlur" ppEffectCommit 0;

	sleep 2.0;

	"dynamicBlur" ppEffectAdjust [0.8]; 
	"dynamicBlur" ppEffectCommit 0;

	Local_MultiUseString="<t align='right' size='1.9' color='#484848'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_split_3t","plain"];
	Local_MultiUseString="<t align='right' size='1.9' color='#5d5d5d'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_3b","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'><t shadow='1' shadowColor='#565656'>The Enhanced Capture and Hold mode</t></t>";
	titleRsc ["about_end","plain"];
	sleep 0.1;

	Local_MultiUseString="<t align='right' size='1.9' color='#484848'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_split_3t","plain"];
	Local_MultiUseString="<t align='right' size='1.9' color='#5d5d5d'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_3b","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'><t shadow='1' shadowColor='#565656'>The Enhanced Capture and Hold mode</t></t>";
	titleRsc ["about_end","plain"];
	sleep 0.1;

	Local_MultiUseString="<t align='right' size='1.9' color='#484848'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_split_t","plain"];
	Local_MultiUseString="<t align='right' size='1.9' color='#5d5d5d'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_b","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#000000'>The Enhanced Capture and Hold mode</t>";
	titleRsc ["about_end","plain"];

	Local_MultiUseString="<t align='right' size='1.9' color='#0000FF'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_lb","plain"];
	sleep 0.1;
	Local_MultiUseString="<t align='right' size='1.9' color='#FF0000'>The Enhanced Capture and Hold mode</t>";
	CutRsc ["about_split_rr","plain"];

	sleep 0.1;

	titleFadeOut 0.1;

	"dynamicBlur" ppEffectAdjust [0]; 
	"dynamicBlur" ppEffectCommit 0;

	sleep 1.5;

	"colorCorrections" ppEffectEnable false;
	Local_Camera camSetRelPos [0.0, -0.1, 840];
	Local_camera camCommitPrepared 0;

	Local_MultiUseString="<t align='left' size='1.8' color='#000000'><t shadow='1' shadowColor='#565656'>Based on Valhalla gamemode sources</t></t><br/><t align='left' size='1.6' color='#000000'><t shadow='1' shadowColor='#565656'>Originally made by WINSE and Roman.Val</t></t>";
	titleRsc ["copyright","plain"];

	"colorCorrections" ppEffectEnable true;
	Local_Camera camSetRelPos [0.0, -0.1, 800];
	Local_camera camCommitPrepared 0;
	sleep 0.1;
	"colorCorrections" ppEffectEnable false;
	Local_Camera camSetRelPos [0.0, -0.1, 760];
	Local_camera camCommitPrepared 0;
	sleep 0.1;
	"colorCorrections" ppEffectEnable true;
	Local_Camera camSetRelPos [0.0, -0.1, 720];
	Local_camera camCommitPrepared 0;
	sleep 0.1;
	"colorCorrections" ppEffectEnable false;
	Local_Camera camSetRelPos [0.0, -0.1, 680];
	Local_camera camCommitPrepared 0;
	sleep 0.1;
	"colorCorrections" ppEffectEnable true;
	Local_Camera camSetRelPos [0.0, -0.1, 640];
	Local_camera camCommitPrepared 0;
	sleep 0.1;
	"colorCorrections" ppEffectEnable false;
	Local_Camera camSetRelPos [0.0, -0.1, 690];
	Local_camera camCommitPrepared 0;

	"colorCorrections" ppEffectEnable true;

	Local_Camera camSetRelPos [0.0, -0.1, 2];
	Local_camera camCommitPrepared 10.7;

	sleep 0.4;

	Local_Camera camSetRelPos [0.0, -0.1, 640];
	Local_camera camCommitPrepared 0;
	"colorCorrections" ppEffectEnable false;
	sleep 0.2;

	Local_Camera camSetRelPos [0.0, -0.1, 600];
	Local_camera camCommitPrepared 0;

	Local_Camera camSetRelPos [0.0, -0.1, 2];
	Local_camera camCommitPrepared 9.0;
	"colorCorrections" ppEffectEnable true;

	sleep 2.0;

	"radialBlur" ppEffectAdjust [0.01,0.01,0.0,0.0];
	"radialBlur" ppEffectCommit 4.3;
	"radialBlur" ppEffectEnable true;

	Local_Camera camSetRelPos [0.0, -0.1, 250];
	Local_camera camCommitPrepared 0.3;

	titleFadeOut 0.1;

	sleep 0.3;
	Local_Camera camSetRelPos [0.0, -0.1, 2];
	Local_camera camCommitPrepared 8.6;

	sleep 1.15;

	Local_MultiUseString="<t align='center'><t size='10.0' color='#ffffff'><img image='pic\ft2.paa'></t><br/><t size='8.0' color='#000000'><t shadow='1' shadowColor='#565656'> </t></t></t>";
	titleRsc ["Logo","plain"];

	sleep 0.65;

	Local_MultiUseString="<t align='center'><t size='10.0' color='#ffffff'><img image='pic\ft2.paa'></t><br/><t size='8.0' color='#000000'><t shadow='1' shadowColor='#565656'>"+Config_MissionName+"</t></t></t>";
	titleRsc ["Logo","plain"];

	sleep 2.8;


	sleep 1.0;

	"dynamicBlur" ppEffectEnable false;
	titleFadeOut 0.1;

	sleep 1.4;

	titleCut["","black out", 0.7];

    //End of Intro

    };

	sleep 1.0;
	camDestroy Local_Camera;
	Local_Camera="camera" camCreate [0,0,0];
	Local_Camera cameraEffect ["internal","back"];

	titleCut["","black in", 1.4];


	[Func_Client_PlayerRespawn, [player]] call Func_Common_Spawn;

	"radialBlur" ppEffectEnable false;
	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [ 0.44, 1, 0, [-2.32, 0.17, 0.71, 0],[1.09, 0.91, 0.66, 0.27],[-1.24, 3.03, 0.37, -1.69]] ;
	"colorCorrections" ppEffectCommit 0;

	Local_MultiUseString=format ["<t align='center' shadow='true' size='1.5'  color='#dddddd'>%1</t>",localize "STR_NAME_BattleOver"];
