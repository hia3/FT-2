
class RscGroups {
	movingEnable = 1;
	idd = -1;
	onLoad = "[Func_Dialog_HandleGroupsDialog, _this] call Func_Common_Spawn";
	
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
			text = $STR_WF_Groups;
			x = 0.04;
			y = 0.20;
		};
		class CA_New : RscShortcutButton {
			idc = 13002;
			default = 0;
			x = 0.05;
			y = 0.8;
			text = $STR_WF_NewGroup;
			action = "Dialog_MenuAction=1";
		};
		class CA_Join : RscShortcutButton {
			idc = 13003;
			default = 0;
			x = 0.25;
			y = 0.8;
			text = $STR_WF_JoinGroup;
			action = "Dialog_MenuAction=2";
		};
		class CA_Leave : RscShortcutButton {
			idc = 13004;
			default = 0;
			x = 0.45;
			y = 0.8;
			text = $STR_WF_LeaveGroup;
			action = "Dialog_MenuAction=3";
		};
		class CA_Close : RscShortcutButton {
			idc = 13005;
			default = 0;
			x = 0.685;
			y = 0.8;
			text = $STR_WF_Close;
			action = "closedialog 0";
		};
		class CA_MainList : RscListBoxA_ext {
			idc = 3700;
			columns[] = {0.01,0.01};
			drawSideArrows = 0;
			idcRight = -1;
			idcLeft = -1;
			x = 0.05;
			y = 0.26;
			w = 0.28;
			h = 0.46;
			
			onLBSelChanged = "Dialog_GroupLbChange=true";
			onLBDblClick = "";
		};
		class WF_MiniMap : RscMapControl_ext {
			IDC = 15001;
			ShowCountourInterval = 1;
			x = 0.343;
			y = 0.2495;
			w = 0.553;
			h = 0.486;

			onMouseMoving = "";
			onMouseButtonDown = "";
			onMouseButtonUp = "";
		};
	};
};
