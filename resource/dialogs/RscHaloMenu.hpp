
class RscHaloMenu {
	movingEnable = 1;
	idd = -1;
	onLoad = "_this spawn Halo_Marker_Init";
	onUnload = "[] spawn Halo_Marker_Remove";
	
	class controlsBackground {
		class Mainback : RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.18;
			y = 0.16;
			w = 0.73;
			h = 0.7;
		};
	};
	
	class controls {
		class WF_MiniMap : RscMapControl_ext {
			IDC = 16001;
			ShowCountourInterval = 1;
			x = 0.19;
			y = 0.25;
			w = 0.71;
			h = 0.5;

			onMouseMoving = "FT2_WF_Logic setVariable ['MousePos',[_this Select 1,_this Select 2]]";
			onMouseButtonDown = "FT2_WF_Logic setVariable ['MouseButtonDown',_this select 1]";
			onMouseButtonUp = "FT2_WF_Logic setVariable ['MouseButtonUp',_this select 1]";
		};
		class CA_LabelWhere: RscText_ext {
			idc = -1;
			text = "Halo Cost $400 ";
			x = 0.2;
			w = 0.7;
			y = 0.18;
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
			action = "[] spawn Halo_Jump_F;";
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
