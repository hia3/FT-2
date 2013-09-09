_v = [];
_c = [];
_t = [];

_add_car_class = 
{
	_vehicle_class = _this select 0;
	_vehicle_cost  = _this select 1;
	_vehicle_time  = _this select 2;

	_this_vehicle_allowed = if (isNil "Config_AllowedVehicles") then { true } else { _vehicle_class in Config_AllowedVehicles };

	_this_vehicle_exists = isClass(configFile >> "CfgVehicles" >> _vehicle_class);

	if (_this_vehicle_exists && _this_vehicle_allowed) then
	{
		_v = _v + [_vehicle_class];
		_c = _c + [_vehicle_cost];
		_t = _t + [_vehicle_time];
	};
};


	if (!isServer || local player) then {
			
		_pa6=0;
		if (ismultiplayer) then {_pa6 = paramsArray select 6;};
		if (((side player == WEST) && (_pa6==0)) || ((side player == EAST) && (_pa6==1))) then {			

			_v = [];
			_c = [];
			_t = [];

			['C_Offroad_01_F',         100, 1200] call _add_car_class;

			['C_Hatchback_01_F',       150, 1200] call _add_car_class;
			['C_Hatchback_01_sport_F', 200, 1200] call _add_car_class;
			['I_G_Offroad_01_F',       300, 1200] call _add_car_class;
			['I_G_Offroad_01_armed_F', 600, 1200] call _add_car_class;
			['C_SUV_01_F',             350, 1200] call _add_car_class;

			['B_Quadbike_01_F',   70, 1200] call _add_car_class;

			['B_MRAP_01_F',      700, 1200] call _add_car_class;
			['B_MRAP_01_gmg_F', 1000, 1200] call _add_car_class;
			['B_MRAP_01_hmg_F', 1000, 1200] call _add_car_class;

			['I_MRAP_03_F',     1000, 1200] call _add_car_class;
			['I_MRAP_03_gmg_F', 1300, 1200] call _add_car_class;
			['I_MRAP_03_hmg_F', 1300, 1200] call _add_car_class;
			
			['I_APC_Wheeled_03_cannon_F', 4000, 1200] call _add_car_class;
			
			['B_APC_Wheeled_01_cannon_F', 3000, 1200] call _add_car_class;
			['B_Truck_01_transport_F',     250, 1200] call _add_car_class;
			['B_Truck_01_covered_F',       300, 1200] call _add_car_class;

			['MMT_USMC', 50, 300] call _add_car_class;
			['M1030', 60, 300] call _add_car_class;
			['ATV_US_EP1', 70, 300] call _add_car_class;
			['HMMWV', 100, 300] call _add_car_class;
			['HMMWV_M2', 150, 1200] call _add_car_class;
			['HMMWV_Armored', 150, 1200] call _add_car_class;
			['BAF_Jackal2_L2A1_W', 300, 1200] call _add_car_class;
			['BAF_Jackal2_GMG_W', 600, 1200] call _add_car_class;
			['HMMWV_MK19', 500, 1200] call _add_car_class;
			['HMMWV_M998A2_SOV_DES_EP1', 500, 1200] call _add_car_class;
			['HMMWV_M998_crows_M2_DES_EP1', 650, 1200] call _add_car_class;
			['HMMWV_M998_crows_MK19_DES_EP1', 800, 1200] call _add_car_class;
			['HMMWV_TOW', 1300, 1200] call _add_car_class;
			['HMMWV_Avenger', 2000, 1200] call _add_car_class;


			if !(isNil 'Config_WestAdditionalCars') then
			{
				for "_i" from 0 to (count Config_WestAdditionalCars)-1 do
				{
					_car_desc=Config_WestAdditionalCars select _i;
					_car_type=_car_desc select 0;
					_car_price=_car_desc select 1;

					_v = _v + [_car_type];
					_c = _c + [_car_price];
					_t = _t + [600];
				};
			};

			_p = [];
			_d = [];
			_s = [];

			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['carVehicleClasses',_v];
			FT2_WF_Logic setVariable ['carVehicleCosts',_c];
			FT2_WF_Logic setVariable ['carVehiclePictures',_p];
			FT2_WF_Logic setVariable ['carVehicleNames',_d];
			FT2_WF_Logic setVariable ['carVehicleTexts',_s];
			FT2_WF_Logic setVariable ['carVehicleTimes',_t];

			_v = [];
			_c = [];
			_t = [];

			['B_Truck_01_mover_F',   350, 1800] call _add_car_class;
			['B_Truck_01_box_F',     400, 1800] call _add_car_class;
			['B_Truck_01_Repair_F',  500, 1800] call _add_car_class;
			['B_Truck_01_ammo_F',    600, 1800] call _add_car_class;
			['B_Truck_01_fuel_F',    300, 1800] call _add_car_class;
			['B_Truck_01_medical_F', 400, 1800] call _add_car_class;

			['HMMWV_Ambulance', 150, 1800] call _add_car_class;
			['MtvrRepair', 700, 1800] call _add_car_class;
			['MtvrReammo', 700, 1800] call _add_car_class;
			['HMMWV_Terminal_EP1', 1800, 1800] call _add_car_class;
			['MQ9PredatorB', 1500, 3600] call _add_car_class;
			['AH6X_EP1', 2000, 3600] call _add_car_class;

			_p = [];
			_d = [];
			_s = [];
			
			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['supportVehicleClasses',_v];
			FT2_WF_Logic setVariable ['supportVehicleCosts',_c];
			FT2_WF_Logic setVariable ['supportVehiclePictures',_p];
			FT2_WF_Logic setVariable ['supportVehicleNames',_d];
			FT2_WF_Logic setVariable ['supportVehicleTexts',_s];
			FT2_WF_Logic setVariable ['supportVehicleTimes',_t];

//
			_v = [];
			_c = [];
			_t = [];

			['B_APC_Tracked_01_rcws_F', 2800, 1200] call _add_car_class;
			['B_APC_Tracked_01_CRV_F',  1500, 1200] call _add_car_class;
			['B_APC_Tracked_01_AA_F',   6000, 1200] call _add_car_class;
			['B_MBT_01_cannon_F',      10000, 1200] call _add_car_class;
			['B_MBT_01_arty_F',        13000, 1200] call _add_car_class;
			['B_MBT_01_mlrs_F',        13000, 1200] call _add_car_class;

			['M1126_ICV_M2_EP1', 1100, 1200] call _add_car_class;
			['M1126_ICV_mk19_EP1', 1400, 1200] call _add_car_class;
			['M1135_ATGMV_EP1', 1800, 1200] call _add_car_class;
			['M1128_MGS_EP1', 3500, 1200] call _add_car_class;
			['AAV', 1400, 1200] call _add_car_class;
			['LAV25', 2000, 1200] call _add_car_class;
			['M2A2_EP1', 3250, 1200] call _add_car_class;
			['M2A3_EP1', 3500, 1200] call _add_car_class;
			['M6_EP1', 3500, 1200] call _add_car_class;
			['M1A1', 7900, 1200] call _add_car_class;
			['M1A2_TUSK_MG', 10500, 1200] call _add_car_class;
			['BAF_FV510_W', 4250, 1200] call _add_car_class;
			['MRLS', 22000, 1200] call _add_car_class;
			
			_p = [];
			_d = [];
			_s = [];
			
			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['armorVehicleClasses',_v];
			FT2_WF_Logic setVariable ['armorVehicleCosts',_c];
			FT2_WF_Logic setVariable ['armorVehiclePictures',_p];
			FT2_WF_Logic setVariable ['armorVehicleNames',_d];
			FT2_WF_Logic setVariable ['armorVehicleTexts',_s];
			FT2_WF_Logic setVariable ['armorVehicleTimes',_t];

//
	
			_v = [];
			_c = [];
			_t = [];

			['B_Heli_Light_01_F',       1000, 1200] call _add_car_class;
			['B_Heli_Light_01_armed_F', 5000, 1200] call _add_car_class;
			
			['B_Heli_Attack_01_F',     18000, 1200] call _add_car_class;
			['B_Heli_Transport_01_F',   1100, 1200] call _add_car_class;

			['I_Heli_Transport_02_F',   1500, 1200] call _add_car_class;

			['MH6J_EP1', 500, 1200] call _add_car_class;
			['AH6J_EP1', 4500, 1200] call _add_car_class;
			['MH60S', 800, 1200] call _add_car_class;
			['UH60M_MEV_EP1', 800, 1200] call _add_car_class;
			['UH60M_EP1', 900, 1200] call _add_car_class;
			['CH_47F_EP1', 900, 1200] call _add_car_class;
			['BAF_Merlin_HC3_D', 900, 1200] call _add_car_class;
			['UH1Y', 6000, 1200] call _add_car_class;
			['AW159_Lynx_BAF', 8000, 1200] call _add_car_class;
			['AH64D', 18000, 1200] call _add_car_class;
			['BAF_Apache_AH1_D', 20000, 1200] call _add_car_class;
			['AH64D_Sidewinders', 12000, 1200] call _add_car_class;
			['AH1Z', 19000, 1200] call _add_car_class;
			
			_p = [];
			_d = [];
			_s = [];
			
			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['heliVehicleClasses',_v];
			FT2_WF_Logic setVariable ['heliVehicleCosts',_c];
			FT2_WF_Logic setVariable ['heliVehiclePictures',_p];
			FT2_WF_Logic setVariable ['heliVehicleNames',_d];
			FT2_WF_Logic setVariable ['heliVehicleTexts',_s];
			FT2_WF_Logic setVariable ['heliVehicleTimes',_t];

//	
			_v = [];
			_c = [];
			_t = [];

			['I_Plane_Fighter_03_CAS_F', 18000, 1200] call _add_car_class;
			['I_Plane_Fighter_03_AA_F',  17000, 1200] call _add_car_class;

			['MV22', 800, 1200] call _add_car_class;
			['C130J', 1000, 1200] call _add_car_class;
			['F35B', 10000, 1200] call _add_car_class;
			['AV8B', 10000, 1200] call _add_car_class;
			['AV8B2', 19000, 1200] call _add_car_class;
			['A10', 21000, 1200] call _add_car_class;
			
			_p = [];
			_d = [];
			_s = [];
			
			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['airVehicleClasses',_v];
			FT2_WF_Logic setVariable ['airVehicleCosts',_c];
			FT2_WF_Logic setVariable ['airVehiclePictures',_p];
			FT2_WF_Logic setVariable ['airVehicleNames',_d];
			FT2_WF_Logic setVariable ['airVehicleTexts',_s];
			FT2_WF_Logic setVariable ['airVehicleTimes',_t];
		};
		
		if (((side player == EAST) && (_pa6==0)) || ((side player == WEST) && (_pa6==1))) then {

			_v = [];
			_c = [];
			_t = [];

			['C_Offroad_01_F',         100, 1200] call _add_car_class;

			['C_Hatchback_01_F',       150, 1200] call _add_car_class;
			['C_Hatchback_01_sport_F', 200, 1200] call _add_car_class;
			['I_G_Offroad_01_F',       300, 1200] call _add_car_class;
			['I_G_Offroad_01_armed_F', 600, 1200] call _add_car_class;
			['C_SUV_01_F',             350, 1200] call _add_car_class;

			['O_Quadbike_01_F',   70, 1200] call _add_car_class;

			['O_MRAP_02_F',      700, 1200] call _add_car_class;
			['O_MRAP_02_hmg_F', 1000, 1200] call _add_car_class;
			['O_MRAP_02_gmg_F', 1000, 1200] call _add_car_class;

			['I_MRAP_03_F',     1000, 1200] call _add_car_class;
			['I_MRAP_03_gmg_F', 1300, 1200] call _add_car_class;
			['I_MRAP_03_hmg_F', 1300, 1200] call _add_car_class;
			
			['I_APC_Wheeled_03_cannon_F', 4000, 1200] call _add_car_class;
			
			['O_Truck_02_covered_F',     300, 1200] call _add_car_class;
			['O_Truck_02_transport_F',   250, 1200] call _add_car_class;
			['O_APC_Wheeled_02_rcws_F', 2000, 1200] call _add_car_class;

			['MMT_Civ', 50, 300] call _add_car_class;
			['TT650_Ins', 60, 300] call _add_car_class;
			['UAZ_RU', 80, 300] call _add_car_class;
			['UAZ_MG_INS', 100, 1200] call _add_car_class;
			['UAZ_AGS30_RU', 400, 1200] call _add_car_class;
			['UAZ_SPG9_INS', 800, 1200] call _add_car_class;
			['Ural_ZU23_INS', 500, 1200] call _add_car_class;
			['BTR40_MG_TK_GUE_EP1', 300, 1200] call _add_car_class;
			['GAZ_Vodnik', 300, 1200] call _add_car_class;
			['GAZ_Vodnik_HMG', 1500, 1200] call _add_car_class;
			['GRAD_RU', 22000, 1200] call _add_car_class;

			if !(isNil 'Config_EastAdditionalCars') then
			{
				for "_i" from 0 to (count Config_EastAdditionalCars)-1 do
				{
					_car_desc=Config_EastAdditionalCars select _i;
					_car_type=_car_desc select 0;
					_car_price=_car_desc select 1;

					_v = _v + [_car_type];
					_c = _c + [_car_price];
					_t = _t + [600];
				};
			};
			
			_p = [];
			_d = [];
			_s = [];

			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['carVehicleClasses',_v];
			FT2_WF_Logic setVariable ['carVehicleCosts',_c];
			FT2_WF_Logic setVariable ['carVehiclePictures',_p];
			FT2_WF_Logic setVariable ['carVehicleNames',_d];
			FT2_WF_Logic setVariable ['carVehicleTexts',_s];
			FT2_WF_Logic setVariable ['carVehicleTimes',_t];

//
			_v = [];
			_c = [];
			_t = [];

			['O_Truck_02_box_F',     400, 1800] call _add_car_class;
			['O_Truck_02_Ammo_F',    600, 1800] call _add_car_class;
			['O_Truck_02_fuel_F',    300, 1800] call _add_car_class;
			['O_Truck_02_medical_F', 400, 1800] call _add_car_class;

			['GAZ_Vodnik_MedEvac', 150, 1800] call _add_car_class;
			['KamazRepair', 700, 1800] call _add_car_class;
			['KamazReammo', 700, 1800] call _add_car_class;
			['BRDM2_HQ_TK_GUE_EP1', 2200, 1800] call _add_car_class;
			['Pchela1T', 2000, 3600] call _add_car_class;
			['Ka137_PMC', 2000, 3600] call _add_car_class;
			
			_p = [];
			_d = [];
			_s = [];
			
			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['supportVehicleClasses',_v];
			FT2_WF_Logic setVariable ['supportVehicleCosts',_c];
			FT2_WF_Logic setVariable ['supportVehiclePictures',_p];
			FT2_WF_Logic setVariable ['supportVehicleNames',_d];
			FT2_WF_Logic setVariable ['supportVehicleTexts',_s];
			FT2_WF_Logic setVariable ['supportVehicleTimes',_t];


//
			_v = [];
			_c = [];
			_t = [];

			['O_APC_Tracked_02_cannon_F', 4000, 1200] call _add_car_class;
			['O_APC_Tracked_02_AA_F',     6000, 1200] call _add_car_class;
			['O_MBT_02_cannon_F',        10000, 1200] call _add_car_class;
			['O_MBT_02_arty_F',          13000, 1200] call _add_car_class;

			['BRDM2_INS', 900, 1200] call _add_car_class;
			['BRDM2_ATGM_INS', 1800, 1200] call _add_car_class;
			['T34_TK_EP1', 1800, 1200] call _add_car_class;
			['T55_TK_EP1', 2800, 1200] call _add_car_class;
			['BTR60_TK_EP1', 900, 1200] call _add_car_class;
			['BMP2_INS', 2300, 1200] call _add_car_class;
			['BMP3', 3500, 1200] call _add_car_class;
			['BTR90', 3500, 1200] call _add_car_class;
			['ZSU_INS', 3400, 1200] call _add_car_class;
			['T72_RU', 6000, 1200] call _add_car_class;
			['T90', 9500, 1200] call _add_car_class;
			['2S6M_Tunguska', 9200, 1200] call _add_car_class;
			
			_p = [];
			_d = [];
			_s = [];
			
			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['armorVehicleClasses',_v];
			FT2_WF_Logic setVariable ['armorVehicleCosts',_c];
			FT2_WF_Logic setVariable ['armorVehiclePictures',_p];
			FT2_WF_Logic setVariable ['armorVehicleNames',_d];
			FT2_WF_Logic setVariable ['armorVehicleTexts',_s];
			FT2_WF_Logic setVariable ['armorVehicleTimes',_t];
//

									
			_v = [];
			_c = [];
			_t = [];

			['O_Heli_Light_02_unarmed_F',  1000, 1200] call _add_car_class;
			['O_Heli_Light_02_F',         10000, 1200] call _add_car_class;
			
			['O_Heli_Attack_02_F',        15000, 1200] call _add_car_class;
			['O_Heli_Attack_02_black_F',  15500, 1200] call _add_car_class;

			['I_Heli_Transport_02_F',      1500, 1200] call _add_car_class;

			['Mi17_Ins', 800, 1200] call _add_car_class;
			['Mi17_medevac_Ins', 800, 1200] call _add_car_class;
			['Ka60_PMC', 7900, 1200] call _add_car_class;
			['Ka60_GL_PMC', 8000, 1200] call _add_car_class;
			['Mi17_rockets_RU', 11000, 1200] call _add_car_class;
			['Mi24_V', 14000, 1200] call _add_car_class;
			['Mi24_P', 14000, 1200] call _add_car_class;
			['Ka52', 20000, 1200] call _add_car_class;
			['Ka52Black', 20000, 1200] call _add_car_class;

			_p = [];
			_d = [];
			_s = [];
			
			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['heliVehicleClasses',_v];
			FT2_WF_Logic setVariable ['heliVehicleCosts',_c];
			FT2_WF_Logic setVariable ['heliVehiclePictures',_p];
			FT2_WF_Logic setVariable ['heliVehicleNames',_d];
			FT2_WF_Logic setVariable ['heliVehicleTexts',_s];
			FT2_WF_Logic setVariable ['heliVehicleTimes',_t];

//
			_v = [];
			_c = [];
			_t = [];

			['I_Plane_Fighter_03_CAS_F', 18000, 1200] call _add_car_class;
			['I_Plane_Fighter_03_AA_F',  17000, 1200] call _add_car_class;

			['An2_TK_EP1', 800, 1200] call _add_car_class;
			['L39_TK_EP1', 9000, 1200] call _add_car_class;
			['Su25_Ins', 19000, 1200] call _add_car_class;
			['Su39', 20700, 1200] call _add_car_class;
			['Su34', 22000, 1200] call _add_car_class;
			
			_p = [];
			_d = [];
			_s = [];
			
			{
				_p = _p + [getText(configFile >> 'CfgVehicles' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgVehicles' >> _x >> 'displayName')];
			} forEach _v;

			FT2_WF_Logic setVariable ['airVehicleClasses',_v];
			FT2_WF_Logic setVariable ['airVehicleCosts',_c];
			FT2_WF_Logic setVariable ['airVehiclePictures',_p];
			FT2_WF_Logic setVariable ['airVehicleNames',_d];
			FT2_WF_Logic setVariable ['airVehicleTexts',_s];
			FT2_WF_Logic setVariable ['airVehicleTimes',_t];
//
		};
	};
