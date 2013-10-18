
class RscReviveRequest {
	movingEnable = 1;
	idd = 4000;
	onLoad = "Dialog_RespawnState='reviving'";
	onUnLoad = "if (Dialog_RespawnState=='reviving') then {Dialog_RespawnState='idle'}";
	
	class controlsBackground {
		class Mainback : RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.15;
			y = 0.3;
			w = 0.6;
			h = 0.3;
		};
	};
	
	class controls {
		class Label: RscText_ext {
			idc = -1;
			text = $STR_WF_Revive;
			x = 0.225;
			y = 0.325;
		};		
		class CA_Apply : RscShortcutButton {
			idc = -1;
			default = 0;
			x = 0.5;
			y = 0.5;
			text = $STR_WF_Apply;
			action = "closedialog 0; Dialog_RespawnState='revived'";
		};	
		class CA_Deny : RscShortcutButton {
			idc = -1;
			default = 0;
			x = 0.2;
			y = 0.5;
			text = $STR_WF_Deny;
			action = "closedialog 0";
		};			
		class CA_Text: RscText_ext
		{
			idc = 4900;
			style = 16;
			lineSpacing=1.0;
			default = 0;
			x = 0.225;
			y = 0.385;
			w = 0.8;
			h = 0.07;
			SizeEx = 0.03;
			text = "";
		};		
		class CA_Timer: RscText_ext
		{
			idc = 4901;
			style = 16;
			lineSpacing=1.0;
			default = 0;
			x = 0.225;
			y = 0.42;
			w = 0.1;
			h = 0.05;
			SizeEx = 0.04;
			text = "30..";
		};	
	};
};
