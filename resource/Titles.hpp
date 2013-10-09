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

		controls[]={"log_info","txt_dwn","txt_crw","OptionsIcon0","OptionsIcon1","OptionsIcon2","OptionsIcon3","OptionsIcon4","OptionsIcon5","OptionsIcon6","OptionsIcon7","Players","Score","Funds","ManPic","HeadPic","BodyPic","ArmsPic","LegsPic","TeamSpeak", "gps_map", "gps_background", "gps_background_title", "gps_background_title_dark", "gps_grid", "gps_time", "gps_heading"};

		onload="uiNamespace setVariable['GUI',_this select 0]; [Func_Client_UpdateGUI, []] call Func_Common_Spawn";

		class log_info : RscStructuredText
		{
			idc=6002;
			x=0.2;
			y=SafeZoneY + SafeZoneH;
			w=1;
			h=0.2;

			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};

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
			colortext[] = {1, 1, 1, 0.800000};
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
		class OptionsIcon7: OptionsIcon0
		{
			IDC = 6012;
			y = "0.3+(0.0522876*7)";
		};
		// Text and color is set in script by ctrlSetStructuredText see Func_CLient_UpdateGUI.sqf
		class Players:txt_dwn
		{
			idc=6030;
			x=0.7;
			y=0.9;
			w=0.20;
			h = 0.20;
		};
		class Score:txt_dwn
		{
			idc=6031;
			x=0.7;
			y=0.9;
			w=0.20;
			h = 0.20;
		};
		class Funds:txt_dwn
		{
			idc=6032;
			x=0.7;
			y=0.9;
			w=0.20;
			h = 0.20;
		};
		class ManPic:RscPicture_ext
		{
			idc=6033;
			colorText[]={0.1,1,0.1,0.7};
			text="pic\man.paa";
			x=safeZoneX-2;
			y=SafeZoneY-2;
			w=0.04*1.25;
			h=0.14*1.25;
		};
		class HeadPic:RscPicture_ext
		{
			idc=6034;
			colorText[]={1,0,0,0.8};
			text="";
			x=0.9492;
			y=0.0172;
			w=0.022*1.25;
			h=0.02*1.25;
		};
		class BodyPic:RscPicture_ext
		{
			idc=6035;
			colorText[]={1,0,0,0.8};
			text="";
			x=0.93995;
			y=0.04;
			w=0.04*1.25;
			h=0.044*1.25;
		};
		class ArmsPic:RscPicture_ext
		{
			idc=6036;
			colorText[]={1,0,0,0.8};
			text="";
			x=0.94;
			y=0.052;
			w=0.04*1.25;
			h=0.044*1.25;
		};
		class LegsPic:RscPicture_ext
		{
			idc=6037;
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
			idc=6038;
			x = safeZoneX + SafeZoneW * 0.3;
			y = SafeZoneY;
			w = SafeZoneW * 0.4;
			h = SafeZoneH * 0.3;
		};


		class gps_map : RscMapControl_ext
		{
			idc = 6039;

			ShowCountourInterval = 1;

			default=true;

			x = 100;
			y = 100;
			w = "(profilenamespace getvariable ['IGUI_GRID_GPS_W', (10 * (((safezoneW / safezoneH) min 1.2) / 40))])";
			h = "(profilenamespace getvariable ['IGUI_GRID_GPS_H', (10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};

		class gps_background : RscPicture
		{
			idc = 6040;

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
			idc = 6041;

			colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])", "(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};

		class gps_background_title_dark : RscText
		{
			idc = 6042;

			colorBackground[] = {0, 0, 0, 0.100000};

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};

		class gps_grid : RscText
		{
			idc = 6043;

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
			idc = 6044;

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
			idc = 6045;

			style = 2;
			colorText[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			x = 100;
			y = 100;
			w = 0;
			h = 0;
		};
	};

#include "Intro.hpp"

};