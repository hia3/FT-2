
class RscVehicles {
	movingEnable = 1;
	idd = -1;
	onLoad = "[Func_Dialog_HandleVehiclesDialog, _this] call Func_Common_Spawn";
	onUnload = "";

	class controlsBackground {

		class Mainback: RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;

			x =-6 * GUI_GRID_W + GUI_GRID_X;
			y =-5 * GUI_GRID_H + GUI_GRID_Y;
			w = 52 * GUI_GRID_W;
			h = 35 * GUI_GRID_H;
		};
	};
	class controls {
		//--- ArmA 2 WF Gear Menu Modified.
		class FilterButtonCars : RscClickableText_ext {
			idc = 3700;
			style = 48 + 0x800;

			x = -5.2 * GUI_GRID_W + GUI_GRID_X;
			y = -3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.25 * GUI_GRID_H;

			color[] = {1, 1, 1, 1};
			colorActive[] = {0.7,1,0.7,1};
			text = "\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa";
			action = "Dialog_VehicleFiller='car'";
		};
		class FilterButtonArmor : FilterButtonCars {
			idc = 3701;
			x =-1.6 * GUI_GRID_W + GUI_GRID_X;
			text = "\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa";
			action = "Dialog_VehicleFiller='armor'";
		};
		class FilterButtonHeli : FilterButtonCars {
			idc = 3702;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			text = "\A3\ui_f\data\map\vehicleicons\iconHelicopter_ca.paa";
			action = "Dialog_VehicleFiller='heli'";
		};
		class FilterButtonAir : FilterButtonCars {
			idc = 3703;
			x = 5.6 * GUI_GRID_W + GUI_GRID_X;
			text = "\A3\ui_f\data\map\vehicleicons\iconPlane_ca.paa";
			action = "Dialog_VehicleFiller='air'";
		};
		class FilterButtonShip : FilterButtonCars {
			idc = 3711;
			x = 9.2 * GUI_GRID_W + GUI_GRID_X;
			text = "\A3\ui_f\data\map\vehicleicons\iconShip_ca.paa";
			action = "Dialog_VehicleFiller='ship'";
		};
		class FilterButtonSupport : FilterButtonCars {
			idc = 3704;

			x = 12.8 * GUI_GRID_W + GUI_GRID_X;

			text = "\A3\ui_f\data\map\vehicleicons\pictureRepair_ca.paa";
			action = "Dialog_VehicleFiller='support'";
		};

		class BuyButton : RscShortcutButton {
			idc = 3710;

			x = -5.6 * GUI_GRID_W + GUI_GRID_X;
			y = 28 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;

			text = $STR_WF_Purchase;
			action = "Dialog_VehicleActionSE='buy'";
		};
		class CloseButton : BuyButton {
			idc = 3705;

			x = 12 * GUI_GRID_W + GUI_GRID_X;

			text = $STR_WF_Close;
			action = "closeDialog 0";
		};
		class CA_Money_Value : RscText_ext {
			idc = 3706;

			x = -5.2 * GUI_GRID_W + GUI_GRID_X;
			y = 26.25 * GUI_GRID_H + GUI_GRID_Y;

			SizeEx = 0.04;
			text = "";
			colorText[] = {0.7,1,0.7,1};
		};
		class Gear_Title : CA_Money_Value {
			idc = 3707;

			x = -5.6 * GUI_GRID_W + GUI_GRID_X;
			y = -5 * GUI_GRID_H + GUI_GRID_Y;

			text = $STR_WF_Vehicles_Label;
		};
		class MainList : RscListBoxA_ext {
			idc = 3708;
			columns[] = {0.01, 0.25};
			drawSideArrows = 0;
			idcRight = -1;
			idcLeft = -1;

			x = -6 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 26 * GUI_GRID_W;
			h = 25 * GUI_GRID_H;

			sizeEx = 0.035;

			onLBSelChanged = "Dialog_VehicleLbChange=true";
		};
		class SecondaryList: RscStructuredText_ext {
			idc = 3709;

			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 26 * GUI_GRID_W;
			h = 25 * GUI_GRID_H;

			size = 0.06;
		};
	};
};
