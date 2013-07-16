
class RscHaloMenu {
	movingEnable = 1;
	idd = -1;
	onLoad = "_this spawn Halo_Marker_LZ";
	onUnload = "[] spawn Halo_Remove_Marker_LZ";
	
	class controlsBackground {
		class Mainback : RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.185;
			y = 0.17;
			w = 1.2549;
			h = 0.836601;
		};
	};
	
	class controls {
		class WF_MiniMap : RscMapControl_ext {
			IDC = 16001;
			ShowCountourInterval = 1;
			x = 0.191;
			y = 0.254;
			w = 0.7133;
			h = 0.509;

			//onMouseMoving = "FT2_WF_Logic setVariable ['MousePos',[_this Select 1,_this Select 2]]";
			//onMouseButtonDown = "FT2_WF_Logic setVariable ['MouseButtonDown',_this select 1]";
			//onMouseButtonUp = "FT2_WF_Logic setVariable ['MouseButtonUp',_this select 1]";
		};
		class CA_LabelWhere: RscText_ext {
			idc = -1;
			text = "Halo Cost $400 ";
			x = 0.2;
			w = 0.7;
			y = 0.205;
		};
		class CA_LabelLocation: RscText_ext {
			idc = -1;
			text = "Set a DropZone";
			SizeEx = 0.030;
			x = 0.2;
			w = 0.7;
			y = 0.805;
		};		
		class JumpButton : RscShortcutButton {
			idc = -1;
			x = 0.7-0.19;
			y = 0.79;
			w = 0.185;
			h = 0.052;
			text = "Jump";
			action = "[] spawn Halo_Jump;";
		};		
		
		class CloseButton : RscShortcutButton {
			idc = -1;
			x = 0.7;
			y = 0.79;
			w = 0.185;
			h = 0.052;
			text = "Close";
			action = "closedialog 0;";
		};
	};
};
