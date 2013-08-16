
class RscRespawnMenu {
	movingEnable = 1;
	idd = -1;
	onLoad = "[Func_Dialog_HandleRespawnDialog, _this] call Func_Common_Spawn";
	onUnload = "[Func_Dialog_RespawnDialogClosed, _this] call Func_Common_Spawn";

	class controlsBackground {
		class Mainback : RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.17;
			y = 0.17;
			w = 0.75;
			h = 0.7;
		};
	};

	class controls {
		class TipText : RscStructuredText
		{
			idc = 15000;
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH / 7;

			colorText[]={1,1,1,1};
			colorBackground[]={0,0,0,0.5};

			size=0.04;

			text="";

			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				align = "center";
				shadow = 1;
			};
		};
		class WF_MiniMap : RscMapControl_ext {
			IDC = 15001;
			ShowCountourInterval = 1;
			x = 0.19;
			y = 0.254;
			w = 0.7;
			h = 0.5;

			onMouseMoving = "FT2_WF_Logic setVariable ['MousePos',[_this Select 1,_this Select 2]]";
			onMouseButtonDown = "FT2_WF_Logic setVariable ['MouseButtonDown',_this select 1]";
			onMouseButtonUp = "FT2_WF_Logic setVariable ['MouseButtonUp',_this select 1]";
		};
		class CA_LabelWhere: RscText_ext {
			idc = 15002;
			text = $STR_DLG_RespawnPoint;
			x = 0.2;
			w = 0.7;
			y = 0.205;
		};
		class CA_LabelTime: RscText_ext {
			idc = 15003;
			text = $STR_DLG_RespawnDelay;
			x = 0.65;
			w = 0.7;
			y = 0.205;
		};
		class CA_LabelFunds: RscText_ext {
			idc = 15004;
			text = $STR_DLG_RespawnFunds;
			SizeEx = 0.030;
			x = 0.2;
			w = 0.7;
			y = 0.775;
		};
		class CA_LabelCost: RscText_ext {
			idc = 15005;
			text = $STR_DLG_RespawnCost;
			SizeEx = 0.030;
			x = 0.2;
			w = 0.7;
			y = 0.805;
		};
		class RespawnButton : RscShortcutButton {
			idc = 3904;
			x = 0.7;
			y = 0.79;
			w = 0.185;
			h = 0.052;
			text = $STR_DLG_RespawnSpawn;
			action = "Dialog_RespawnState='readytospawn'";
		};
		class LoadoutsButton : RscShortcutButton {
			idc = 3905;
			x = 0.5;
			y = 0.79;
			w = 0.185;
			h = 0.052;
			text = $STR_DLG_RespawnLoad;
			action = "Dialog_RespawnState='changeloadout'";
		};
	};
};
