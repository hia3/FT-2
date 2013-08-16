
class RscHelp {
	movingEnable = 1;
	idd = -1;
	onLoad = "[Func_Dialog_HandleHelpDialog, _this] call Func_Common_Spawn";
	
	class controlsBackground {
		class Mainback : RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.015;
			y = 0.17;
			w = 0.9;
			h = 0.7;
		};
	};
	class controls {
		class Label: RscText_ext {
			idc = 13001;
			text = $STR_WF_Help;
			x = 0.04;
			y = 0.20;
		};		
		class CA_Close : RscShortcutButton {
			idc = 13005;
			default = 0;
			x = 0.685;
			y = 0.730;
			text = $STR_WF_Close;
			action = "closedialog 0";
		};
		class CA_MainList : RscListBoxA_ext {
			idc = 3700;
			columns[] = {0.01};
			drawSideArrows = 0;
			idcRight = -1;
			idcLeft = -1;
			x = 0.05;
			y = 0.26;
			w = 0.28;
			h = 0.46;
			
			onLBSelChanged = "Dialog_HelpLbChange=true";
			onLBDblClick = "";
		};
		class CA_HelpList : RscStructuredText_ext {
			IDC = 3701;
			x = 0.343;
			y = 0.2495;
			w = 0.553;
			h = 0.486;
		};
	};
};
