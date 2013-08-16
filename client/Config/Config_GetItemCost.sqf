private["_item", "_result", "_i"];

_item = _this;

_string_compare = 
{
	private ["_lefta", "_righta"];

	_lefta  = toLower(_this select 0);
	_righta = toLower(_this select 1);

	if (_lefta == _righta) then
	{
		0
	}
	else
	{
		private ["_left", "_right", "_ll", "_rl", "_i"];
	
		_left  = toArray(_lefta); 
		_right = toArray(_righta);

		_ll = count _left; 
		_rl = count _right; 

		for "_i" from 0 to (_ll max _rl) - 1 do 
		{
			private ["_l", "_r"];
			
			_l = if (_i < _ll) then 
			{
				_left select _i
			} 
			else 
			{
				0
			}; 
	
			_r = if (_i < _rl) then 
			{ 
				_right select _i
			} 
			else 
			{
				0
			}; 
	
			if (_l != _r) exitWith { _l - _r };
		};
	};
}; 

if (isNil "Global_CostMap") then
{
	Global_CostMap = 
	[
		["100Rnd_65x39_caseless_mag",35],
		["100Rnd_65x39_caseless_mag_Tracer",35],
		["150Rnd_762x51_Box",40],
		["150Rnd_762x51_Box_Tracer",40],
		["16Rnd_9x21_Mag",10],
		["1Rnd_HE_Grenade_shell",10],
		["1Rnd_Smoke_Grenade_shell",5],
		["1Rnd_SmokeBlue_Grenade_shell",5],
		["1Rnd_SmokeGreen_Grenade_shell",5],
		["1Rnd_SmokeOrange_Grenade_shell",5],
		["1Rnd_SmokePurple_Grenade_shell",5],
		["1Rnd_SmokeRed_Grenade_shell",5],
		["1Rnd_SmokeYellow_Grenade_shell",5],
		["200Rnd_65x39_cased_Box",50],
		["200Rnd_65x39_cased_Box_Tracer",50],
		["20Rnd_556x45_UW_mag",10],
		["20Rnd_762x51_Mag",18],
		["30Rnd_45ACP_Mag_SMG_01",20],
		["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",20],
		["30Rnd_556x45_Stanag",15],
		["30Rnd_556x45_Stanag_Tracer_Green",15],
		["30Rnd_556x45_Stanag_Tracer_Red",15],
		["30Rnd_556x45_Stanag_Tracer_Yellow",15],
		["30Rnd_65x39_caseless_green",10],
		["30Rnd_65x39_caseless_green_mag_Tracer",10],
		["30Rnd_65x39_caseless_mag",10],
		["30Rnd_65x39_caseless_mag_Tracer",10],
		["30Rnd_9x21_Mag",20],
		["3Rnd_HE_Grenade_shell",50],
		["3Rnd_Smoke_Grenade_shell",15],
		["3Rnd_SmokeBlue_Grenade_shell",15],
		["3Rnd_SmokeGreen_Grenade_shell",15],
		["3Rnd_SmokeOrange_Grenade_shell",15],
		["3Rnd_SmokePurple_Grenade_shell",15],
		["3Rnd_SmokeRed_Grenade_shell",15],
		["3Rnd_SmokeYellow_Grenade_shell",15],
		["3Rnd_UGL_FlareCIR_F",15],
		["3Rnd_UGL_FlareGreen_F",15],
		["3Rnd_UGL_FlareRed_F",15],
		["3Rnd_UGL_FlareWhite_F",15],
		["3Rnd_UGL_FlareYellow_F",15],
		["5Rnd_127x108_Mag",50],
		["7Rnd_408_Mag",50],
		["9Rnd_45ACP_Mag",30],
		["acc_flashlight",5],
		["acc_pointer_IR",5],
		["APERSBoundingMine_Range_Mag",150],
		["APERSMine_Range_Mag",80],
		["APERSTripMine_Wire_Mag",100],
		["arifle_Katiba_C_F",60],
		["arifle_Katiba_F",80],
		["arifle_Katiba_GL_F",120],
		["arifle_Mk20_F",70],
		["arifle_Mk20_GL_F",130],
		["arifle_Mk20_GL_plain_F",130],
		["arifle_Mk20_plain_F",70],
		["arifle_Mk20C_F",50],
		["arifle_Mk20C_plain_F",50],
		["arifle_MX_F",80],
		["arifle_MX_GL_F",150],
		["arifle_MX_SW_F",200],
		["arifle_MXC_F",60],
		["arifle_MXM_F",200],
		["arifle_SDAR_F",60],
		["arifle_TRG20_F",50],
		["arifle_TRG21_F",70],
		["arifle_TRG21_GL_F",130],
		["ATMine_Range_Mag",80],
		["B_AssaultPack_blk",27],
		["B_AssaultPack_cbr",27],
		["B_AssaultPack_dgtl",27],
		["B_AssaultPack_khk",27],
		["B_AssaultPack_mcamo",27],
		["B_AssaultPack_ocamo",27],
		["B_AssaultPack_rgr",27],
		["B_AssaultPack_sgg",27],
		["B_AssaultPackG",31],
		["B_Bergen_blk",42],
		["B_Bergen_mcamo",42],
		["B_Bergen_rgr",42],
		["B_Bergen_sgg",42],
		["B_BergenC_blu",40],
		["B_BergenC_grn",40],
		["B_BergenC_red",40],
		["B_BergenG",50],
		["B_Carryall_cbr",45],
		["B_Carryall_khk",45],
		["B_Carryall_mcamo",45],
		["B_Carryall_ocamo",45],
		["B_Carryall_oli",45],
		["B_Carryall_oucamo",45],
		["B_FieldPack_blk",28],
		["B_FieldPack_cbr",28],
		["B_FieldPack_khk",28],
		["B_FieldPack_ocamo",28],
		["B_FieldPack_oli",28],
		["B_FieldPack_oucamo",28],
		["B_HuntingBackpack",25],
		["B_Kitbag_cbr",33],
		["B_Kitbag_mcamo",33],
		["B_Kitbag_sgg",33],
		["B_OutdoorPack_blk",20],
		["B_OutdoorPack_blu",20],
		["B_OutdoorPack_tan",20],
		["B_Parachute",20],
		["B_TacticalPack_blk",33],
		["B_TacticalPack_mcamo",33],
		["B_TacticalPack_ocamo",33],
		["B_TacticalPack_oli",33],
		["B_TacticalPack_rgr",33],
		["Binocular",10],
		["C_Bergen_blu",28],
		["C_Bergen_grn",28],
		["C_Bergen_red",28],
		["Chemlight_blue",2],
		["Chemlight_green",2],
		["Chemlight_red",2],
		["Chemlight_yellow",2],
		["ClaymoreDirectionalMine_Remote_Mag",100],
		["DemoCharge_Remote_Mag",150],
		["FirstAidKit",50],
		["G_AssaultPack",33],
		["G_Bergen",42],
		["G_Combat",3],
		["G_Diving",3],
		["G_Lowprofile",3],
		["G_Shades_Black",3],
		["G_Shades_Blue",3],
		["G_Shades_Green",3],
		["G_Shades_Red",3],
		["G_Spectacles",3],
		["G_Spectacles_Tinted",3],
		["G_Sport_Blackred",3],
		["G_Sport_BlackWhite",3],
		["G_Sport_Blackyellow",3],
		["G_Sport_Checkered",3],
		["G_Sport_Greenblack",3],
		["G_Sport_Red",3],
		["G_Squares",3],
		["G_Squares_Tinted",3],
		["G_Tactical_Black",3],
		["G_Tactical_Clear",3],
		["H_Beret_ocamo",0],
		["H_Booniehat_khk",0],
		["H_Cap_headphones",0],
		["H_HelmetB",0],
		["H_HelmetB_camo",0],
		["H_HelmetB_light",0],
		["H_HelmetB_paint",0],
		["H_HelmetCrew_B",0],
		["H_HelmetCrew_O",0],
		["H_HelmetO_ocamo",0],
		["H_HelmetSpecB",0],
		["H_HelmetSpecB_paint1",0],
		["H_HelmetSpecB_paint2",0],
		["H_HelmetSpecO_ocamo",0],
		["H_MilCap_mcamo",0],
		["H_MilCap_ocamo",0],
		["H_PilotHelmetHeli_B",0],
		["H_PilotHelmetHeli_O",0],
		["H_Watchcap_camo",0],
		["HandGrenade",10],
		["HandGrenade_Stone",5],
		["hgun_ACPC2_F",30],
		["hgun_P07_F",20],
		["hgun_Rook40_F",20],
		["ItemCompass",5],
		["ItemGPS",10],
		["ItemMap",3],
		["ItemRadio",5],
		["ItemWatch",5],
		["Laserbatteries",5],
		["Laserdesignator",100],
		["launch_B_Titan_F",500],
		["launch_B_Titan_short_F",500],
		["launch_I_Titan_F",500],
		["launch_I_Titan_short_F",500],
		["launch_NLAW_F",400],
		["launch_O_Titan_F",500],
		["launch_O_Titan_short_F",500],
		["launch_RPG32_F",300],
		["launch_Titan_F",500],
		["launch_Titan_short_F",500],
		["LMG_Mk200_F",250],
		["LMG_Zafir_F",300],
		["Medikit",100],
		["MineDetector",20],
		["MiniGrenade",5],
		["muzzle_snds_acp",70],
		["muzzle_snds_B",70],
		["muzzle_snds_H",70],
		["muzzle_snds_H_MG",70],
		["muzzle_snds_L",50],
		["muzzle_snds_M",70],
		["NLAW_F",400],
		["NVGoggles",5],
		["optic_Aco",20],
		["optic_ACO_grn",20],
		["optic_ACO_grn_smg",20],
		["optic_Aco_smg",20],
		["optic_Arco",150],
		["optic_Hamr",150],
		["optic_Holosight",20],
		["optic_Holosight_smg",20],
		["optic_MRCO",150],
		["optic_SOS",300],
		["Rangefinder",20],
		["RPG32_AA_F",500],
		["RPG32_F",300],
		["RPG32_HE_F",300],
		["SatchelCharge_Remote_Mag",200],
		["SLAMDirectionalMine_Wire_Mag",100],
		["SMG_01_F",30],
		["SMG_02_F",35],
		["SmokeShell",5],
		["SmokeShellBlue",5],
		["SmokeShellGreen",5],
		["SmokeShellOrange",5],
		["SmokeShellPurple",5],
		["SmokeShellRed",5],
		["SmokeShellYellow",5],
		["srifle_EBR_F",500],
		["srifle_GM6_F",1000],
		["srifle_LRR_F",1000],
		["Titan_AA",500],
		["Titan_AP",300],
		["Titan_AT",500],
		["ToolKit",100],
		["U_B_CombatUniform_mcam",0],
		["U_B_CombatUniform_mcam_tshirt",0],
		["U_B_CombatUniform_mcam_vest",0],
		["U_B_GhillieSuit",50],
		["U_B_HeliPilotCoveralls",0],
		["U_B_Wetsuit",0],
		["U_BasicBody",0],
		["U_Competitor",0],
		["U_O_CombatUniform_ocamo",0],
		["U_O_GhillieSuit",50],
		["U_O_OfficerUniform_ocamo",0],
		["U_O_PilotCoveralls",0],
		["U_O_SpecopsUniform_ocamo",0],
		["U_O_Wetsuit",0],
		["U_Rangemaster",0],
		["UGL_FlareCIR_F",5],
		["UGL_FlareGreen_F",5],
		["UGL_FlareRed_F",5],
		["UGL_FlareWhite_F",5],
		["UGL_FlareYellow_F",5],
		["V_BandollierB_cbr",0],
		["V_BandollierB_rgr",0],
		["V_Chestrig_khk",0],
		["V_HarnessO_brn",0],
		["V_HarnessOGL_brn",0],
		["V_PlateCarrier1_cbr",0],
		["V_PlateCarrier1_rgr",0],
		["V_PlateCarrier2_cbr",0],
		["V_PlateCarrier2_rgr",0],
		["V_PlateCarrierGL_rgr",0],
		["V_PlateCarrierSpec_rgr",0],
		["V_Rangemaster_belt",0],
		["V_RebreatherB",0],
		["V_RebreatherIR",0],
		["V_TacVest_blk",0],
		["V_TacVest_brn",0],
		["V_TacVest_oli",0]
	];
};


_result = 0;
_known_cost = false;

_interval_begin = 0;
_interval_end   = (count Global_CostMap) - 1;

for "_z" from 0 to 10 do
{
	if (_interval_end == _interval_begin) exitWith { false };

	_middle_index = floor((_interval_end + _interval_begin) / 2);

	_desc = Global_CostMap select _middle_index;
		_desc_item = _desc select 0;
		_desc_cost = _desc select 1;

	_compare_result = [_desc_item, _item] call _string_compare;

	//diag_log ["quick", _z, _interval_begin, _interval_end, _middle_index, _desc, _item, _compare_result];

	if (_compare_result == 0) exitWith
	{
		_result = _desc_cost; _known_cost = true;
	};

	if (_compare_result < 0) then
	{
		_interval_begin = _middle_index;
	}
	else
	{
		_interval_end = _middle_index;
	};
};

if (!_known_cost) then
{
	diag_log format ["Unknown cost: %1", _item];
};

/*
if (_result == 0) then
{
	_result = count Global_CostMap;

	Global_CostMap set [_result, [_item, 1 + _result]];

	diag_log ["cost", _item, 1 + _result];
};
*/
    
_result;
