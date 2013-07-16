
class RscParameters {
	movingEnable = 1;
	idd = -1;
	onLoad = "_this spawn Func_Dialog_HandleParameters";
	
	class controlsBackground {
		class Mainback : RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.015;
			y = 0.15;
			w = 0.5;
			h = 0.9;
		};
	};
	
	class controls 
	{
		class Duration: RscText_ext 
		{
			idc = 7000;
			text = "Duration";
			x = 0.04;
			y = 0.3;
		};
		class Daytime: RscText_ext 
		{
			idc = 7001;
			text = "Daytime";
			x = 0.04;
			y = 0.35;
		};
		class Weather: RscText_ext 
		{
			idc = 7002;
			text = "Weather";
			x = 0.04;
			y = 0.4;
		};
		class ViewDistance: RscText_ext 
		{
			idc = 7003;
			text = "ViewDistance";
			x = 0.04;
			y = 0.45;
		};
		class ExternalView: RscText_ext 
		{
			idc = 7004;
			text = "ExternalView";
			x = 0.04;
			y = 0.5;
			w=1;
		};
		class ScreenMarkers: RscText_ext 
		{
			idc = 7005;
			text = "ScreenMarkers";
			x = 0.04;
			y = 0.55;
			w=1;
		};
		class Armaments: RscText_ext 
		{
			idc = 7006;
			text = "Armaments";
			x = 0.04;
			y = 0.6;
		};
		class StartFund: RscText_ext 
		{
			idc = 7007;
			text = "StartFund";
			x = 0.04;
			y = 0.65;
		};		
		class Halo: RscText_ext 
		{
			idc = 7008;
			text = "Halo";
			x = 0.04;
			y = 0.7;
		};	
		class Grass: RscText_ext 
		{
			idc = 7009;
			text = "Grass";
			x = 0.04;
			y = 0.75;
		};
		class BicycleMHQ: RscText_ext 
		{
			idc = 7010;
			text = "Buy bicycle at MHQ";
			x = 0.04;
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
