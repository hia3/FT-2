
class RscVehicles {
	movingEnable = 1;
	idd = -1;
	onLoad = "[Func_Dialog_HandleVehiclesDialog, _this] call Func_Common_Spawn";
	onUnload = "";

	class controlsBackground {

		class Mainback: RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.25;
			y = 0.01;
			w = 0.4583;
			h = 0.95;
		};
	};
	class controls {
		//--- ArmA 2 WF Gear Menu Modified.
		class FilterButtonCars : RscClickableText_ext {
			idc = 3700;
			style = 48 + 0x800;
			x = 0.30;
			y = 0.045;
			w = 0.086;
			h = 0.086;
			color[] = {1, 1, 1, 1};
			colorActive[] = {0.7,1,0.7,1};
			text = "\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa";
			action = "Dialog_VehicleFiller='car'";
		};
		class FilterButtonArmor : FilterButtonCars {
			idc = 3701;
			x = 0.37;
			text = "\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa";
			action = "Dialog_VehicleFiller='armor'";
		};
		class FilterButtonHeli : FilterButtonCars {
			idc = 3702;
			x = 0.44;
			text = "\A3\ui_f\data\map\vehicleicons\iconHelicopter_ca.paa";
			action = "Dialog_VehicleFiller='heli'";
		};
		class FilterButtonAir : FilterButtonCars {
			idc = 3703;
			x = 0.51;
			text = "\A3\ui_f\data\map\vehicleicons\iconPlane_ca.paa";
			action = "Dialog_VehicleFiller='air'";
		};
		class FilterButtonSupport : FilterButtonCars {
			idc = 3704;
			x = 0.58;
			text = "\A3\ui_f\data\map\vehicleicons\pictureRepair_ca.paa";
			action = "Dialog_VehicleFiller='support'";
		};
		class BuyButton : RscShortcutButton {
			idc = 3710;
			x = 0.2492;
			y = 0.898;
			w = 0.185;
			h = 0.052;
			text = $STR_WF_Purchase;
			action = "Dialog_VehicleActionSE='buy'";
		};
		class CloseButton : BuyButton {
			idc = 3705;
			x = 0.5245;
			text = $STR_WF_Close;
			action = "closeDialog 0";
		};
		class CA_Money_Value : RscText_ext {
			idc = 3706;
			x = 0.257634;
			y = 0.623;
			SizeEx = 0.03;
			text = "";
			colorText[] = {0.7,1,0.7,1};
		};
		class Gear_Title : CA_Money_Value {
			idc = 3707;
			x = 0.257634;
			y = 0.01;
			text = $STR_WF_Vehicles_Label;
		};
		class MainList : RscListBoxA_ext {
			idc = 3708;
			columns[] = {0.01, 0.30};
			drawSideArrows = 0;
			idcRight = -1;
			idcLeft = -1;
			x = 0.253;
			y = 0.167676;
			w = 0.45;
			h = 0.444;

			onLBSelChanged = "Dialog_VehicleLbChange=true";
		};
		class SecondaryList: RscStructuredText_ext {
			idc = 3709;
			x = 0.253;
			y = 0.663641;
			h = 0.225;
			w = 0.460;
		};
	};
};
