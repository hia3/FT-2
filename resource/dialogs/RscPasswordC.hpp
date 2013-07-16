
class RscPasswordC {
	movingEnable = 1;
	idd = -1;
	onLoad = "";
	
	class controlsBackground {
		class Mainback : RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.2;
			y = 0.3;
			w = 0.65;
			h = 0.25;
		};
	};
	
	class controls {
		class Label: RscText_ext {
			idc = -1;
			text = $STR_WF_Password;
			x = 0.225;
			y = 0.325;
		};		
		class CA_Proceed : RscShortcutButton {
			idc = -1;
			default = 0;
			x = 0.645;
			y = 0.465;
			text = $STR_WF_Proceed;
			action = "Dialog_MenuAction = 4";
		};	
		class CA_Close : RscShortcutButton {
			idc = -1;
			default = 0;
			x = 0.225;
			y = 0.465;
			text = $STR_WF_Close;
			action = "closedialog 0";
		};	
		class CA_Password: RscTextBox_ext
		{
			idc = 3701;
			default = 0;
			x = 0.645;
			y = 0.395;
			w = 0.18;
			h = 0.05;
			text = "";
		};
		class CA_Text: RscText_ext
		{
			idc = -1;
			style = 16;
			lineSpacing=1.0;
			default = 0;
			x = 0.225;
			y = 0.385;
			w = 0.4;
			h = 0.07;
			SizeEx = 0.03;
			text = $STR_WF_PwdHint;
		};		
	};
};
