class RscTitles
{
	class MyDefault
	{
		idd = 199952;
		duration = 10;
	};

	class RscOverlay
	{
		idd=-1;
		duration=10000;
		name="gps";

		controls[]={"txt_dwn","txt_crw","OptionsIcon0","OptionsIcon1","OptionsIcon2","OptionsIcon3","OptionsIcon4","OptionsIcon5","OptionsIcon6","Players","Score","Funds","ManPic","HeadPic","BodyPic","ArmsPic","LegsPic","TeamSpeak", "gps_map", "gps_background", "gps_background_title", "gps_background_title_dark", "gps_grid", "gps_time", "gps_heading"};

		onload="uiNamespace setVariable['GUI',_this select 0]; [] spawn Func_Client_UpdateGUI";

		class txt_dwn:RscStructuredTextB_ext
		{
			idc=6003;
			w=0.241;
			h=0.03;
			x=-1;
			y=-1;
			colorText[]={1,1,1,0.5};
			colorBackground[]={0,0,0,0};
		};

		class txt_crw:txt_dwn
		{
			idc=6004;
			w=0.25;
			h=0.55;
		};

		class OptionsImageAspectRatio: RscPicture_ext 
		{
			w = 0.078431;
			h = 0.104575;
			style = "0x30+0x800";
		};

		class OptionsIcon0: OptionsImageAspectRatio 
		{
			IDC = 6005;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157)";
			y = 0.3;
			w = 0.039216;
			h = 0.052288;
			colortext[] = {1, 1, 1, 0.400000};
			text = "";
		};

		class OptionsIcon1: OptionsIcon0 
		{
			IDC = 6006;
			y = "0.3+(0.0522876*1)";
		};

		class OptionsIcon2: OptionsIcon0 
		{
			IDC = 6007;
			y = "0.3+(0.0522876*2)";
		};

		class OptionsIcon3: OptionsIcon0 
		{
			IDC = 6008;
			y = "0.3+(0.0522876*3)";
		};

		class OptionsIcon4: OptionsIcon0 
		{
			IDC = 6009;
			y = "0.3+(0.0522876*4)";
		};

		class OptionsIcon5: OptionsIcon0 
		{
			IDC = 6010;
			y = "0.3+(0.0522876*5)";
		};
		class OptionsIcon6: OptionsIcon0 
		{
			IDC = 6011;
			y = "0.3+(0.0522876*6)";
		};
		// Text and color is set in script by ctrlSetStructuredText see Func_CLient_UpdateGUI.sqf
		class Players:txt_dwn
		{
			idc=6012;
			x=0.7;
			y=0.9;
			w=0.20;
			h = 0.20;
		};
		class Score:txt_dwn
		{
			idc=6013;
			x=0.7;
			y=0.9;
			w=0.20;
			h = 0.20;
		};
		class Funds:txt_dwn
		{
			idc=6014;
			x=0.7;
			y=0.9;
			w=0.20;
			h = 0.20;
		};	
		class ManPic:RscPicture_ext
		{	
			idc=6015;		
			colorText[]={0.1,1,0.1,0.7};
			text="pic\man.paa";
			x=safeZoneX-2;
			y=SafeZoneY-2;
			w=0.04*1.25;
			h=0.14*1.25;
		};		
		class HeadPic:RscPicture_ext
		{
			idc=6016;
			colorText[]={1,0,0,0.8};
			text="";
			x=0.9492;
			y=0.0172;
			w=0.022*1.25;
			h=0.02*1.25;
		};
		class BodyPic:RscPicture_ext
		{
			idc=6017;
			colorText[]={1,0,0,0.8};
			text="";
			x=0.93995;
			y=0.04;
			w=0.04*1.25;
			h=0.044*1.25;
		};
		class ArmsPic:RscPicture_ext
		{
			idc=6018;
			colorText[]={1,0,0,0.8};
			text="";
			x=0.94;
			y=0.052;
			w=0.04*1.25;
			h=0.044*1.25;
		};
		class LegsPic:RscPicture_ext
		{
			idc=6019;
			colorText[]={1,0,0,0.8};
			text="";
			x=0.93999;
			y=0.085;
			w=0.04*1.25;//0.04
			h=0.044*1.25;//0.044
		};
		class PlayerNameDisp:RscStructuredText_ext
		{
			x = 0.5;
			y = 0.5;
			w = 0.25;
			h = 0.2;
			sizeEx=0.028;
			size=0.028;
			lineSpacing=1;
			colorText[]={1,1,1,0.5};
			colorBackground[]={0,0,0,0};
			class Attributes
			{
				font=PuristaMedium;
				color="#ffffff";
				align="left";
				shadow=false;
			};
		};
		class TeamSpeak : RscPicture
		{
			idc=6020;
			x = safeZoneX + SafeZoneW * 0.3;
			y = SafeZoneY;
			w = SafeZoneW * 0.4;
			h = SafeZoneH * 0.3;
		};


		class gps_map : RscMapControl_ext
		{
			idc = 6021;

			default=true;

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};

		class gps_background : RscPicture 
		{
			idc = 6022;

			colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])", "(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};

			text = "\A3\ui_f\data\igui\rscingameui\rscminimap\gradient_gs.paa";
			colorText[] = {0, 0, 0, 0.100000};

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};

		class gps_background_title : RscText
		{
			idc = 6023;

			colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])", "(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};

		class gps_background_title_dark : RscText
		{
			idc = 6024;

			colorBackground[] = {0, 0, 0, 0.100000};

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};

		class gps_grid : RscText
		{
			idc = 6025;

			style = 0;
			colorText[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};

		class gps_time : RscText
		{
			idc = 6026;

			style = 1;
			colorText[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};

		class gps_heading : RscText
		{
			idc = 6027;

			style = 2;
			colorText[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};
	};
	class trailer
	{		
		idd=1640;
		movingEnable=0;
		duration=47;
		name="trailer";
		controls[]={"Contents"};
		onload="_this spawn Func_Client_CopyrightsAndLinks;";
		class Contents:RscStructuredTextB_ext
		{
			idc=1641;
			style=ST_CENTER+ST_SHADOW;
			sizeex=0.020;
			font="EtelkaMonospaceProBold";
			colorText[]={1,1,1,1};
			text="";
			x=-1;
			y=-1;
			w=SafeZoneW;
			h=0.04;
			fadein=4;
			fadeout=4;
		};
	};
	class BackBlack
	{
		idd=-1;
		movingEnable=0;
		duration=30;
		onLoad="";
		//onLoad="[] spawn compile 'sleep 20.0; titleCut['' '',''black in'',4.0]'";
		name="overlay";
		fadein=0;
		fadeout=0;
		controls[]={"background","Contents"};
		class background
		{
			idc=-1;
			type=0;
			style=ST_PICTURE;
			colorBackground[]={0,0,0,1};
			colorText[]={1,1,1,1};
			font="PuristaMedium";
			sizeEx=0;
			lineSpacing=0;
			access=ReadAndWrite;
			text="#(argb,8,8,3)color(0,0,0,1)";
			x=-1;
			y=-1;
			w=3;
			h=3;
		};
		class Contents:RscText_ext
		{
			idc=1661;
			duration=8;
			font="PuristaMedium";
			style=ST_RIGHT;
			colorText[]={1,1,1,1};
			sizeex=0.04;
			x=SafeZoneW+safeZoneX-0.30;//0.025
			y=SafeZoneH+SafeZoneY-0.052;//0.094
			w=0.95;
			h=0.04;
			text=$STR_DLG_Loading;
		};
	};
	class stats
	{
		idd=1675;
		duration=10;
		name="stats";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.07;
			x=SafeZoneX;
			y=0.4;			
			w=SafeZoneW;
			h=1-0.635;
			default=true;
		};
	};
	class Logo: Stats
	{	
		duration=10;	
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.02;
			x=SafeZoneX;
			y=0.3;	
			w=SafeZoneW;
			h=SafezoneH;
			default=true;
		};
	};
	class credits
	{
		idd=1675;
		duration=10;
		name="stats";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=SafeZoneX;
			y=0.635;			
			w=SafeZoneW;
			h=1-0.635;
			default=true;
		};
	};
	class final
	{
		idd=1676;
		duration=20;
		name="final";
		controls[]={"txt1","txt2","txt3"};
		onload="[(_this select 0),1672,1673,1674,true] call Func_Client_CompileScoreStatistics";
		class txt1:RscStructuredText_ext
		{
			idc=1672;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=0.3;
			y=0.4;
			w=0.5;
			h=1-0.635;
			default=true;
		};
		class txt2:txt1
		{
			idc=1673;
			w=0.4;
		};
		class txt3:txt1
		{
			idc=1674;
			w=0.3;
		};
	};
	class pauseg
	{
		idd=1675;
		duration=10;
		name="stats";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1);
			y=0.15;			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class copyright
	{
		idd=1675;
		duration=10;
		name="stats";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX/1.1);
			y=0.5;			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class about
	{
		idd=1675;
		duration=10;
		name="stats";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1);
			y=0.15;			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
};