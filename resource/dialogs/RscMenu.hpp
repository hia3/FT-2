
class RscMenu {
	movingEnable = 1;
	idd = -1;
	onLoad = "[Func_Dialog_HandleMainMenu, _this] call Func_Common_Spawn";
	
	class controlsBackground {
	
		class BackgroundTop: RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.015;
			y = 0.18;
			w = 0.4;
			h = 0.07;
		};
	};
	class controls {
		class Button_A: RscButtonMenu_ext
		{
			idc = 11001;
			x = 0.015;
			y = 0.255;
			text = $STR_WF_PurchaseGear;
			action = "Dialog_MenuAction = 1";
		};
		class Button_B: RscButtonMenu_ext
		{
			idc = 11002;
			x = 0.015;
			y = 0.360;
			text = $STR_WF_PurchaseVehicles;
			action = "Dialog_MenuAction = 2";
		};
		class Button_C: RscButtonMenu_ext
		{
			idc = 11003;
			x = 0.015;
			y = 0.465;
			text = $STR_WF_Groups;
			action = "Dialog_MenuAction = 3";
		};
		class Button_D: RscButtonMenu_ext
		{
			idc = 11004;
			x = 0.015;
			y = 0.570;
			text = $STR_WF_Options;
			action = "Dialog_MenuAction = 4";
		};
		class Button_E: RscButtonMenu_ext
		{
			idc = 11005;
			x = 0.015;
			y = 0.675;
			text = $STR_WF_Help;
			action = "Dialog_MenuAction = 5";
		};
		class Button_F: RscButtonMenu_ext
		{
			idc = 11007;
			x = 0.015;
			y = 0.780;
			text = $STR_WF_Parameters;
			action = "Dialog_MenuAction = 6";
		};
		class Button_G: RscButtonMenu_ext
		{
			idc = 11008;
			x = 0.015;
			y = 0.885;
			text = $STR_WF_ChangeMap;
			action = "Dialog_MenuAction = 7";
		};
		class Label: RscText_ext 
		{
			idc = 11006;
			text = $STR_WF_Menu_Label;
			x = 0.04;
			y = 0.20;
		};
		class CA_Diff_B_Back : RscShortcutButton {
			idc = 11007;
			shortcuts[] = {0x00050000 + 1};
			default = 0;
			x = 0.23;
			y = 1.05;
			text = $STR_WF_Close;
			action = "closeDialog 0;";
		};
	};
};
