
class RscOptions {
	movingEnable = 1;
	idd = -1;
	onLoad = "[Func_Dialog_HandleOptionsDialog, _this] call Func_Common_Spawn";
	
	class controlsBackground {
		class Mainback : RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.016;
			y = 0.17;
			w = 0.75;
			h = 0.6;
		};
	};
	class controls {
		class Label: RscText_ext {
			idc = -1;
			text = $STR_WF_Options;
			x = 0.04;
			y = 0.205;
		};
		class CA_VD_Label: RscText_ext {
			idc = 13002;
			text = $STR_WF_ViewDistanceP;
			x = 0.04;
			y = 0.25;
			sizeEx = 0.03;
		};
		class CA_VD_Slider : RscXSliderH_ext {
			idc = 13003;
			x = 0.04;
			y = 0.285;
			w = 0.28;
		};
		class CA_SMD_Label: RscText_ext {
			idc = 13004;
			text = $STR_WF_SMDistance;
			x = 0.04;
			y = 0.315;
			sizeEx = 0.03;
		};
		class CA_SMD_Slider : RscXSliderH_ext {
			idc = 13005;
			x = 0.04;
			y = 0.35;
			w = 0.28;
		};
		class CA_SMT_Label: RscText_ext {
			idc = -1;
			text = $STR_WF_SMType;
			x = 0.04;
			y = 0.385;
			sizeEx = 0.03;
		};
		class CA_SMT_Combo: RscCombo_ext {
			idc = 13007;
			x = 0.04;
			w = 0.28;
			y = 0.42;
		};
		class CA_MMP_Label: RscText_ext {
			idc = -1;
			text = $STR_WF_MMPlayers;
			x = 0.35;
			y = 0.25;
			w = 0.3 + 0.13;
			sizeEx = 0.03;
		};
		class CA_MMP_Combo: RscCombo_ext {
			idc = 13009;
			x = 0.35;
			w = 0.28 + 0.13;
			y = 0.285;
		};
		class CA_MMV_Label: RscText_ext {
			idc = -1;
			text = $STR_WF_MMVehicles;
			x = 0.35;
			y = 0.315;
			w = 0.3 + 0.13;
			sizeEx = 0.03;
		};
		class CA_MMV_Combo: RscCombo_ext {
			idc = 13011;
			x = 0.35;
			w = 0.28 + 0.13;
			y = 0.35;
		};
		class CA_MMS_Label: RscText_ext {
			idc = -1;
			text = $STR_WF_MMObjects;
			x = 0.35;
			y = 0.385;
			w = 0.3 + 0.13;
			sizeEx = 0.03;
		};
		class CA_MMS_Combo: RscCombo_ext {
			idc = 13013;
			x = 0.35;
			w = 0.28 + 0.13;
			y = 0.42;
		};
		// Gui style lable
		class CA_GS_Label: RscText_ext {
			idc = -1;
			text = $STR_WF_GUIStyle;
			x = 0.35;
			y = 0.455;
			w = 0.3 + 0.13;
			sizeEx = 0.03;
		};
		class CA_GS_Combo: RscCombo_ext {
			idc = 13006;
			x = 0.35;
			w = 0.28 + 0.13;
			y = 0.49;
		};

		// Gui color.
		class CA_GC_Label: RscText_ext {
			idc = -1;
			text = $STR_WF_GUIColor;
			x = 0.35;
			y = 0.525;
			w = 0.3 + 0.13;
			sizeEx = 0.03;
		};
		// Gui color combobox.
		class CA_GC_Combo: RscCombo_ext {
			idc = 13017;
			x = 0.35;
			y = 0.560;
			w = 0.28 + 0.13;
		};

		// Auto save weapon lable
		class CA_ASW_Label: RscText_ext {
			idc = -1;
			text = $STR_WF_Autosave;
			x = 0.35;
			y = 0.595;
			w = 0.3 + 0.13;
			sizeEx = 0.03;
		};
		class CA_ASW_Combo: RscCombo_ext {
			idc = 13008;
			x = 0.35;
			w = 0.28 + 0.13;
			y = 0.63;
		};
		class CA_SepHL: RscPicture_ext{
			idc = -1;
			x = 0.04;
			y = 0.475;
			w = 0.28;
			h=0.0025;		
			text = "#(argb,8,8,3)color(0.85,0.85,0.85,0.7)";	
		};		
		class CA_SepV: RscPicture_ext{
			idc = -1;
			x = 0.335;
			y = 0.285;
			w = 0.0025;
			h = 0.338825;		
			text = "#(argb,8,8,3)color(0.85,0.85,0.85,0.7)";	
		};

		//transfere money lable 
		class CA_TM_Label: RscText_ext {
			idc = 13014;
			text = $STR_WF_Transfer;
			x = 0.04;
			y = 0.485;
			sizeEx = 0.03;
		};
		class CA_TM_Slider : RscXSliderH_ext {
			idc = 13015;
			x = 0.04;
			y = 0.52;
			w = 0.28;
		};		
		// "names".. transfer money to players combobox
		class CA_TM_Combo: RscCombo_ext {
			idc = 13016;
			x = 0.04;
			w = 0.28;
			y = 0.56;
		};
		class CA_TM_Button : RscShortcutButton {
			idc = -1;
			x = 0.04;
			y = 0.62;
			w = 0.28;
			text = $STR_WF_TransferBtn;
			action = "Dialog_MenuAction = 1";
		};
		class CA_FL_Button : RscShortcutButton {
			idc = -1;
			x = 0.04;
			y = 0.7;
			w = 0.38;
			text = $STR_WF_FlipBtn;
			action = "Dialog_MenuAction = 2";
		};		
		// close buton
		class CA_Close : RscShortcutButton {
			idc = -1;
			default = 0;
			x = 0.445 + 0.13;
			y = 0.7;
			text = $STR_WF_Close;
			action = "closeDialog 0";
		};				
	
	};
};
