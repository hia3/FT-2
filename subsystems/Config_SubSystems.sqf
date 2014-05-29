
System_AntiAirMissileTypes=[["M_Titan_AA",true],["M_Air_AA",true],["M_Zephyr",true]];
System_AntiAirVehicleTypes=[["Man",0.165],["Helicopter",0],["Plane",0.3]];

System_AntiTankMissileTypes=[["M_Titan_AT",true],["M_PG_AT",true],["M_Scalpel_AT",true]];
System_AntiTankVehicleTypes=[["Man",0.2],["Helicopter",0.3],["Plane",0.4]];

System_ArmoredVehicleTypes=
[
	["O_MRAP_02_F",1],
	["O_MRAP_02_hmg_F",1],
	["O_MRAP_02_gmg_F",1],
	
	["O_APC_Wheeled_02_rcws_F",2],
	
	["B_MRAP_01_F",1],
	["B_MRAP_01_gmg_F",1],
	["B_MRAP_01_hmg_F",1],
	
	["B_APC_Wheeled_01_cannon_F",2],
	
	
	["I_MRAP_03_F",1],
	["I_MRAP_03_gmg_F",1],
	["I_MRAP_03_hmg_F",1],
	
	["O_Boat_Armed_01_hmg_F",2],
	["B_Boat_Armed_01_minigun_F",2],

	["O_APC_Tracked_02_cannon_F",4],
	["B_APC_Tracked_01_rcws_F",4],
	
	["B_APC_Tracked_01_AA_F",4],
	["B_MBT_01_cannon_F",5],
	["B_MBT_01_arty_F",3],
	["B_MBT_01_mlrs_F",4],
	
	["O_APC_Tracked_02_AA_F",4],
	["O_MBT_02_cannon_F",5],
	["O_MBT_02_arty_F",3],
	
	["I_APC_Wheeled_03_cannon_F",2],

	["I_MBT_03_cannon_F",4],
	["I_APC_tracked_03_cannon_F",2]
];

System_AircraftVehicleTypes=
[
	["B_Heli_Light_01_armed_F",2],["B_Heli_Attack_01_F",4],

	["O_Heli_Light_02_F",3],["O_Heli_Attack_02_F",4],["O_Heli_Attack_02_black_F",4],
	
	["I_Plane_Fighter_03_CAS_F",4], ["I_Plane_Fighter_03_AA_F",4], ["B_Plane_CAS_01_F",4], ["O_Plane_CAS_02_F",4],
	
	["I_Heli_light_03_F",3]
];

System_CargoChopperVehicles=[["I_Heli_Transport_02_F",1]];
System_CargoVehicleCatrgories=[["Car",0]];

System_HandGrenadeAmmoTypes=["HandGrenade"];
/*System_ExplosiveMagTypes =["SatchelCharge_Remote_Mag", "DemoCharge_Remote_Mag"];
System_ExplosiveAmmoTypes=["SatchelCharge_Remote_Ammo", "DemoCharge_Remote_Ammo"];*/
System_DisposableRPGTypes=["M136","RPG18"];

System_HaveAARadarVehicleTypes=
[	
	["B_APC_Tracked_01_AA_F", ["autocannon_35mm"], 3000],
	["O_APC_Tracked_02_AA_F", ["autocannon_35mm"], 3000]
];

System_IndirectWeaponsTypes=["AGS30","MK19","AGS17"];
System_LoadableStaticsTypes=[["WarfareBMGNest_M240_base",["100Rnd_762x51_M240","100Rnd_762x54_PK"]],["WarfareBMGNest_PK_base",["100Rnd_762x54_PK","100Rnd_762x51_M240"]]];
System_MovableStaticsTypes=["SPG9_base","AGS_base","DSHKM_base","DSHkM_Mini_TriPod","KORD_high","KORD_Base","MK19_TriPod_base","M2StaticMG_base","M2HD_mini_TriPod_base","Metis_TK_EP1","TOW_Tripod_US_EP1"];
System_TrackedVehicleTypes=["Wheeled_APC_F", "Tank", "Tracked_APC", "Truck"];

System_EastReammoVehicleTypes=["O_Truck_02_Ammo_F", "O_Truck_03_ammo_F"];
System_EastRepairVehicleTypes=["O_Truck_02_box_F",  "O_Truck_03_repair_F"];
System_EastRefuelVehicleTypes=["O_Truck_02_fuel_F", "O_Truck_03_fuel_F"];

System_WestReammoVehicleTypes=["B_Truck_01_ammo_F"];
System_WestRepairVehicleTypes=["B_Truck_01_Repair_F"];
System_WestRefuelVehicleTypes=["B_Truck_01_fuel_F"];
