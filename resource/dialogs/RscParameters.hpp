
class RscParameters {
	movingEnable = 1;
	idd = -1;
	onLoad = "[Func_Dialog_HandleParameters, _this] call Func_Common_Spawn";
	
	class controlsBackground {
		class Mainback : RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.015;
			y = 0.15;
			w = 0.6;
			h = 0.9;
		};
	};
	
	class controls 
	{
		class Duration: RscText_ext 
		{
			idc = 7000;
			x = 0.04;
			y = 0.3;
			w = 0.5;
		};
		class Daytime: Duration 
		{
			idc = 7001;
			y = 0.35;
		};
		class Weather: Duration 
		{
			idc = 7002;
			y = 0.4;
		};
		class ViewDistance: Duration 
		{
			idc = 7003;
			y = 0.45;
		};
		class ExternalView: Duration 
		{
			idc = 7004;
			y = 0.5;
		};
		class ScreenMarkers: Duration 
		{
			idc = 7005;
			y = 0.55;
		};
		class Armaments: Duration 
		{
			idc = 7006;
			y = 0.6;
		};
		class StartFund: Duration 
		{
			idc = 7007;
			y = 0.65;
		};		
		class Halo: Duration 
		{
			idc = 7008;
			y = 0.7;
		};	
		class Grass: Duration 
		{
			idc = 7009;
			y = 0.75;
		};
		class BicycleMHQ: Duration 
		{
			idc = 7010;
			y = 0.8;
		};	
		class CA_Diff_B_Back : RscShortcutButton {
			idc = 11007;
			shortcuts[] = {0x00050000 + 1};
			default = 0;
			x = 0.04;
			y = 0.9;
			text = $STR_WF_Close;
			action = "closeDialog 0;";
		};		
	};
};
