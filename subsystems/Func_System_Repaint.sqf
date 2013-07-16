if (!local player) exitWith {};

if (isClass(configFile >> 'CfgPatches' >> 'CATextures_FT2')) then
{
	if (getNumber(configFile >> 'CfgPatches' >> 'CAtextures_ft2' >> 'version') >= 2.0) then
	{
		_selections=[];

		if (worldName in ["Chernarus","Utes","ProvingGrounds_PMC"]) then
		{			
			switch (typeOf _this) do
			{
				case "BMP2_INS":
				{
					_selections=["\ca\tracked\data\bmp2_KHK_01_co.paa","\ca\tracked\data\bmp2_KHK_02_co.paa"];
				};	
				case "BRDM2_INS":
				{
					_selections=["\ca\wheeled\data\BDRM2_KHK_01_CO.paa","\ca\wheeled\data\brdm2_02_co.paa"];
				};
				case "BRDM2_ATGM_INS":
				{
					_selections=["\ca\wheeled\data\bdrm2_atgm_khk_01_co.paa","\ca\wheeled\data\brdm2_02_co.paa"];
				};		
				case "BTR60_TK_EP1":
				{
					_selections=["\textures_ft2\btr60\wood\btr60_body_wood.paa","\textures_ft2\btr60\wood\btr60_details_wood.paa"];
				};
				case "Mi17_Ins":
				{
					_selections=["\ca\air\data\mi8_body_g_vsr_co.paa"];
				};
				case "Mi17_medevac_Ins":
				{
					_selections=["\ca\air\data\mi8_body_g_vsr_co.paa"];
				};	
				case "L39_TK_EP1":
				{
					_selections=["\textures_ft2\l39\wood\l-39_body_wood.paa","\textures_ft2\l39\wood\l-39_body_1_wood.paa"];					
				};
				case "ZSU_INS":
				{
					_selections=["\textures_ft2\shilka\wood\zsu_01_co.paa","\textures_ft2\shilka\wood\zsu_02_co.paa","\textures_ft2\shilka\wood\zsu_03_co.paa"];
				};		
				case "UAZ_MG_INS":
				{
					_selections=["\ca\wheeled\data\Uaz_main_CO.paa"];
				};
				case "UAZ_SPG9_INS":
				{
					_selections=["\ca\wheeled\data\Uaz_main_CO.paa"];
				};
				case "Ural_INS":
				{
					_selections=["\textures_ft2\ural\wood\ural_kabina_rus_co.paa","\textures_ft2\ural\wood\ural_plachta_co.paa"];
				};
				case "UralOpen_INS":
				{
					_selections=["\textures_ft2\ural\wood\ural_kabina_rus_co.paa","\textures_ft2\ural\wood\ural_korba_khk_co.paa"];
				};
				case "Ural_ZU23_INS":
				{
					_selections=["\textures_ft2\ural\wood\ural_kabina_rus_co.paa","\textures_ft2\ural\wood\ural_korba_khk_co.paa"];
				};
				case "BTR40_MG_TK_GUE_EP1":
				{
					_selections=["\textures_ft2\btr40\wood\btr40ext_wood.paa"];
				};				
				case "HMMWV_M998A2_SOV_DES_EP1":
				{
					_selections=["\textures_ft2\hmmwv\wood\hmmwv_body_canvas_1_wood.paa","\textures_ft2\hmmwv\wood\hmmwv_hood_canvas_wood.paa","\textures_ft2\hmmwv\wood\hmmwv_regular_2_wood.paa"];
				};
				case "HMMWV_M998A2_SOV_DES_EP1":
				{
					_selections=["\textures_ft2\hmmwv\wood\hmmwv_body_canvas_1_wood.paa","\textures_ft2\hmmwv\wood\hmmwv_hood_canvas_wood.paa","\textures_ft2\hmmwv\wood\hmmwv_regular_2_wood.paa"];
				};
				case "HMMWV_M998_crows_M2_DES_EP1":
				{
					_selections=["\textures_ft2\hmmwv\wood\hmmwv_body_canvas_1_wood.paa","\textures_ft2\hmmwv\wood\hmmwv_hood_canvas_wood.paa","\textures_ft2\hmmwv\wood\hmmwv_regular_2_wood.paa"];
				};
				case "HMMWV_M998_crows_MK19_DES_EP1":
				{
					_selections=["\textures_ft2\hmmwv\wood\hmmwv_body_canvas_1_wood.paa","\textures_ft2\hmmwv\wood\hmmwv_hood_canvas_wood.paa","\textures_ft2\hmmwv\wood\hmmwv_regular_2_wood.paa"];
				};
				case "M1135_ATGMV_EP1":
				{
					_selections=["\textures_ft2\stryker\wood\stryker_body1_des_co.paa","\textures_ft2\stryker\wood\stryker_body2_des_co.paa"];
				};
				case "M1126_ICV_M2_EP1":
				{
					_selections=["\textures_ft2\stryker\wood\stryker_body1_des_co.paa","\textures_ft2\stryker\wood\stryker_body2_des_co.paa"];
				};
				case "M1126_ICV_mk19_EP1":
				{
					_selections=["\textures_ft2\stryker\wood\stryker_body1_des_co.paa","\textures_ft2\stryker\wood\stryker_body2_des_co.paa"];
				};				
				case "M1128_MGS_EP1":
				{
					_selections=["\textures_ft2\stryker\wood\stryker_body1_des_co.paa","\textures_ft2\stryker\wood\stryker_body2_des_co.paa","\textures_ft2\stryker\wood\stryker_mgs_body1_des_co.paa"];
				};				
				case "M2A2_EP1":
				{
					_selections=["\textures_ft2\bradley\wood\base_co.paa","\textures_ft2\bradley\wood\a3_co.paa","\textures_ft2\bradley\wood\ultralp_co.paa","","\textures_ft2\bradley\wood\base_co.paa"];
				};
				case "M2A3_EP1":
				{
					_selections=["\textures_ft2\bradley\wood\base_co.paa","\textures_ft2\bradley\wood\a3_co.paa","\textures_ft2\bradley\wood\ultralp_co.paa","","\textures_ft2\bradley\wood\base_co.paa"];
				};
				case "M6_EP1":
				{
					_selections=["\textures_ft2\bradley\wood\base_co.paa","\textures_ft2\bradley\wood\a3_co.paa","\textures_ft2\bradley\wood\ultralp_co.paa","\textures_ft2\bradley\wood\base_co.paa",""];
				};
			};
		}
		else
		{
			switch (typeOf _this) do
			{
				case "BMP2_INS":
				{
					_selections=["\textures_ft2\bmp2\sand\bmp2_01_tka_co.paa","\textures_ft2\bmp2\sand\bmp2_02_tka_co.paa"];
				};
				case "BMP3":
				{
					_selections=["\textures_ft2\bmp3\sand\bmp3_body1_camo_co.paa","\textures_ft2\bmp3\sand\bmp3_body2_camo_co.paa","\textures_ft2\bmp3\sand\bmp3_wheels_camo_co.paa"];
				};
				case "BRDM2_INS":
				{
					_selections=["\textures_ft2\brdm\sand\brdm2_01_co.paa","\textures_ft2\brdm\sand\brdm2_02_co.paa"];
				};
				case "BRDM2_ATGM_INS":
				{
					_selections=["\textures_ft2\brdm\sand\brdm2_atgm_co.paa","\textures_ft2\brdm\sand\brdm2_02_co.paa"];
				};
				case "BRDM2_HQ_TK_GUE_EP1":
				{
					_selections=["\textures_ft2\brdm\sand\brdm2_01_co.paa"];
				};	
				case "BTR60_TK_EP1":
				{
					_selections=["\textures_ft2\btr60\sand\btr60_body_des.paa"];
				};
				case "BTR90":
				{
					_selections=["\textures_ft2\btr90\sand\body1_camo_co.paa","\textures_ft2\btr90\sand\body2_camo_co.paa"];
				};
				case "BTR90_HQ":
				{
					_selections=["\textures_ft2\btr90\sand\body1_camo_co.paa","\textures_ft2\btr90\sand\body2_camo_co.paa","\textures_ft2\btr90\sand\btr_hq_co.paa"];
				};
				case "Kamaz":
				{
					_selections=["\textures_ft2\kamaz\sand\kamaz_kab_co.paa","\textures_ft2\kamaz\sand\kamaz_kuz_co.paa"];
				};
				case "KamazOpen":
				{
					_selections=["\textures_ft2\kamaz\sand\kamaz_kab_co.paa","\textures_ft2\kamaz\sand\kamaz_kuz_co.paa"];
				};
				case "KamazReammo":
				{
					_selections=["\textures_ft2\kamaz\sand\kamaz_kab_co.paa","\textures_ft2\kamaz\sand\kamaz_kuz_co.paa"];
				};
				case "KamazRepair":
				{
					_selections=["\textures_ft2\kamaz\sand\kamaz_kab_co.paa","\textures_ft2\kamaz\sand\kamaz_repair_co.paa"];
				};			
				case "KamazRefuel":
				{
					_selections=["\textures_ft2\kamaz\sand\kamaz_kab_co.paa","\textures_ft2\kamaz\sand\kamaz_fuel_co.paa"];
				};
				case "LAV25":
				{
					_selections=["\textures_ft2\lav25\sand\lavbody_co.paa","\textures_ft2\lav25\sand\lavbody2_co.paa"];
				};	
				case "AAV":
				{
					_selections=["\textures_ft2\aav\sand\aav_ext_co.paa","\textures_ft2\aav\sand\aav_ext2_co.paa"];
				};
				case "Mi17_rockets_RU":
				{
					_selections=["\textures_ft2\mi8\sand\mi8_body_g_vsr_co.paa"];
				};
				case "Mi17_Ins":
				{
					_selections=["\textures_ft2\mi8\sand\mi8_body_g_vsr_co.paa"];
				};
				case "Mi17_medevac_Ins":
				{
					_selections=["\textures_ft2\mi8\sand\mi8_body_g_vsr_co.paa"];
				};
				case "Mi24_V":
				{
					_selections=["\textures_ft2\mi24\sand\mi24v_001_co.paa","\textures_ft2\mi24\sand\mi24v_002_co.paa"];
				};
				case "Mi24_P":
				{
					_selections=["\textures_ft2\mi24\sand\mi24p_001_co.paa","\textures_ft2\mi24\sand\mi24p_002_co.paa"];
				};
				case "Ka52":
				{
					_selections=["\textures_ft2\ka52\sand\ka52_01_ru_co.paa","\textures_ft2\ka52\sand\ka52_02_ru_co.paa"];
				};
				case "Su39":
				{
					_selections=["\textures_ft2\su25\sand\su25_body1_rus_co.paa","\textures_ft2\su25\sand\su25_body2_rus_co.paa"];
				};
				case "Su25_Ins":
				{
					_selections=["\textures_ft2\su25\sand\su25_body1_rus_co.paa","\textures_ft2\su25\sand\su25_body2_rus_co.paa"];
				};
				case "Su34":
				{
					_selections=["\textures_ft2\Su34\sand\body1_desert_co.paa","\textures_ft2\su34\sand\body2_desert_rus_co.paa"];
				};
				case "An2_TK_EP1":
				{
					_selections=["\textures_ft2\an2\sand\an2_1_des.paa","\textures_ft2\an2\sand\an2_2_des.paa","\textures_ft2\an2\sand\an2_wings_des.paa"];					
				};
				case "L39_TK_EP1":
				{
					_selections=["\textures_ft2\l39\sand\l-39_body_co.paa","\textures_ft2\l39\sand\l-39_body_1_co.paa"];					
				};				
				case "ZSU_INS":
				{
					_selections=["\textures_ft2\shilka\sand\zsu_01_tk_co.paa","\textures_ft2\shilka\sand\zsu_02_tk_co.paa","\textures_ft2\shilka\sand\zsu_03_tk_co.paa"];
				};
				case "T72_RU":
				{
					_selections=["\textures_ft2\t72\sand\t72_1_tk_co.paa","\textures_ft2\t72\sand\t72_2_tk_co.paa","\textures_ft2\t72\sand\t72_3_tk_co.paa"];
				};
				case "T90":
				{
					_selections=["\textures_ft2\t90\sand\body1_camo_co.paa","\textures_ft2\t90\sand\body2_camo_co.paa","\textures_ft2\t90\sand\body3_camo_co.paa"];
				};
				case "2S6M_Tunguska":
				{
					_selections=["\textures_ft2\tunguska\sand\2s6m_tunguska_hull_and_hatches_vsr_co.paa","\ca\tracked2\2s6m_tunguska\data\2s6m_tunguska_hull_and_tracks_vsr_co.paa","\textures_ft2\tunguska\sand\2s6m_tunguska_turret_vsr_co.paa"];
				};
				case "UAZ_RU":
				{
					_selections=["\textures_ft2\uaz\sand\uaz_main_co.paa"];
				};
				case "UAZ_AGS30_RU":
				{
					_selections=["\textures_ft2\uaz\sand\uaz_main_co.paa"];
				};
				case "UAZ_MG_INS":
				{
					_selections=["\textures_ft2\uaz\sand\uaz_main_co.paa"];
				};
				case "UAZ_SPG9_INS":
				{
					_selections=["\textures_ft2\uaz\sand\uaz_main_co.paa"];
				};
				case "Ural_INS":
				{
					_selections=["\textures_ft2\ural\sand\ural_kabina_co.paa","\textures_ft2\ural\sand\ural_plachta_co.paa"];
				};
				case "UralOpen_INS":
				{
					_selections=["\textures_ft2\ural\sand\ural_kabina_co.paa","\textures_ft2\ural\sand\ural_open_co.paa"];
				};
				case "Ural_ZU23_INS":
				{
					_selections=["\textures_ft2\ural\sand\ural_kabina_co.paa","\textures_ft2\ural\sand\ural_open_co.paa"];
				};
				case "BTR40_MG_TK_GUE_EP1":
				{
					_selections=["\textures_ft2\btr40\sand\btr40extcamo_co.paa"];
				};	
				case "HMMWV_M2":
				{
					_selections=["\textures_ft2\hmmwv\sand\hmmwv_body_des.paa"];
				};
				case "HMMWV_Armored":
				{
					_selections=["\textures_ft2\hmmwv\sand\hmmwv_body_des.paa"];
				};
				case "Pchela1T":
				{
					_selections=["\textures_ft2\pchela1t\sand\pchela1t_des.paa"];
				};
			};
		};
		
		if ((count _selections)>0) then
		{
			_i=0;
			{_this setObjectTexture [_i,_x];_i=_i+1} forEach _selections;
		};
	};	
};