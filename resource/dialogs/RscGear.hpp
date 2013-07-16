#include "RscGear_defines.hpp"

//#define GUI_ORIG_OFFSET_X 0.2
//#define GUI_ORIG_OFFSET_Y (-0.1)

#define GUI_ORIG_OFFSET_X (7.98 * GUI_GRID_W)
#define GUI_ORIG_OFFSET_Y (-3.5 * GUI_GRID_H)

class GroundLoad: RscProgress
{
    texture = "";
    textureExt = "";
    colorBar[] = {0.9,0.9,0.9,0.9};
    colorExtBar[] = {1,1,1,1};
    colorFrame[] = {1,1,1,1};
};

class RscWeaponsListBox: RscListBox
{
    type = CT_LISTNBOX;
    style = LB_TEXTURES;

    drawSideArrows = 0;
    idcRight = -1;
    idcLeft = -1;

    columns[] = {-0.01,0.81};

    rowHeight = 0.1;
    sizeEx = 0.028;
};

class RscObvesListBox: RscWeaponsListBox
{
    colorBackground[] = {0, 1, 0, 0.5}; 
    color[] = {1, 1, 1, 1}; 
    colorScrollbar[] = {0.95, 0.95, 0.95, 0.5}; 
    colorSelect[] = {0.95, 0.95, 0.95, 0.5}; 
    colorSelect2[] = {0.95, 0.95, 0.95, 0.5}; 
    colorSelectBackground[] = {0, 0, 1, 0.5}; 
    colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 0.5}; 

    onLBDrag = "['onAnyLBDrag', _this] call Func_Dialog_HandleGearDialog";
    canDrag = 1;

    columns[] = {-0.01,0.83};

    rowHeight = 0.045;
    sizeEx = 0.02;
};

class RscGear
{
    idd = -1;
    movingEnable = true;
    objects[] = {};

    onLoad            = "Local_ShowRespawnDialogOnUnload = (Dialog_RespawnState=='changeloadout'); ['RscGear_onLoad', _this] call Func_Dialog_HandleGearDialog;";
    onUnload          = "Local_RscGear_Running = false; if (Local_ShowRespawnDialogOnUnload) then {[] spawn Func_Dialog_CreateRespawnDialog}";
    onMouseButtonDown = "['RscGear_onMouseButtonDown', _this] call Func_Dialog_HandleGearDialog;";
    onMouseButtonUp   = "['RscGear_onMouseButtonUp',   _this] call Func_Dialog_HandleGearDialog;";

    class controlsBackground
    {
        class Mainback : IGUIBack
        {
            x = "safezoneX";
            y = "safezoneY";
            w = "safezoneW";
            h = "safezoneH";

            colorbackground[] = {0.3, 0.4, 0.5, 0.85};
        };
    };

    controls[]=
    {
        Preset_0_button,
        Preset_1_button,
        Preset_2_button,
        Preset_3_button,
        Preset_4_button,
        Preset_5_button,

        Clear_button,
        Save_button,

        OK_button,
        Cancel_button,

        //Debug_button,

        Goggles_button,
        Backpacks_button,
        Clothing_button,
        Items_button,
        Explosives_button,
        Sidearms_button,
        Secondary_button,
        Primary_button,
        Obves3_list,
        Obves2_list,
        Obves1_list,
        Magazines_list,
        Weapons_list,

        Cash_text,
        Cost_text,

        CA_PlayerBackground,
        TitleBackground,
        PlayersName,
        RankBackground,
        RankPicture,
        ButtonBack,
        BackgroundSlotPrimary,
        BackgroundSlotPrimaryMuzzle,
        BackgroundSlotPrimaryFlashlight,
        BackgroundSlotPrimaryOptics,
        BackgroundSlotPrimaryMagazine,
        BackgroundSlotSecondary,
        BackgroundSlotSecondaryMuzzle,
        BackgroundSlotSecondaryFlashlight,
        BackgroundSlotSecondaryOptics,
        BackgroundSlotSecondaryMagazine,
        BackgroundSlotHandgun,
        BackgroundSlotHandgunMuzzle,
        BackgroundSlotHandgunFlashlight,
        BackgroundSlotHandgunOptics,
        BackgroundSlotHandgunMagazine,
        BackgroundSlotHeadgear,
        BackgroundSlotGoggles,
        BackgroundSlotHMD,
        BackgroundSlotBinoculars,
        BackgroundSlotMap,
        BackgroundSlotGPS,
        BackgroundSlotCompass,
        BackgroundSlotRadio,
        BackgroundSlotWatch,
        PlayerContainerBackground,
        SlotPrimary,
        SlotPrimaryMuzzle,
        SlotPrimaryGrip,
        SlotPrimaryFlashlight,
        SlotPrimaryOptics,
        SlotPrimaryMagazine,
        SlotSecondary,
        SlotSecondaryMuzzle,
        SlotSecondaryGrip,
        SlotSecondaryFlashlight,
        SlotSecondaryOptics,
        SlotSecondaryMagazine,
        SlotHandgun,
        SlotHandgunMuzzle,
        SlotHandgunGrip,
        SlotHandgunFlashlight,
        SlotHandgunOptics,
        SlotHandgunMagazine,
        SlotHeadgear,
        SlotGoggles,
        SlotHMD,
        SlotBinoculars,
        SlotMap,
        SlotGPS,
        SlotCompass,
        SlotRadio,
        SlotWatch,
        UniformTab,
        UniformSlot,
        UniformLoad,
        UniformLoadPicture,
        UniformContainer,
        VestTab,
        VestSlot,
        VestLoad,
        VestLoadPicture,
        VestContainer,
        BackpackTab,
        BackpackSlot,
        BackpackLoad,
        BackpackLoadPicture,
        BackpackContainer,
        TotalLoad,
        TotalLoadPicture
    };

    class Preset_0_button: RscActiveText
    {
        idc = IDC_Preset_0_button;
        shortcuts[] = {};
        style = 48;
        color[] = {1, 1, 1, 1};
        colorActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 1};
        text = "\A3\ui_f\data\igui\cfg\mptable\infantry_ca.paa";
        x = 11.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 27 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y - 0.01;
	w = 1.3 * GUI_GRID_H;
	h = 1.1 * GUI_GRID_H + 0.02;
        tooltip = $STR_WF_Tooltips_GearReload;

        onButtonClick = "['Preset_button', _this] call Func_Dialog_HandleGearDialog";
    };

    class Preset_1_button: Preset_0_button
    {
        idc = IDC_Preset_1_button;

        shortcuts[] = {};

        color[] = {1, 1, 1, 1};
        colorActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 1};
        text = "A3\ui_f\data\gui\rsc\RscDisplayMultiplayerSetup\flag_opfor_empty_ca.paa";
        x = 13.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 27 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
	w = 1.3 * GUI_GRID_H;
	h = 1.1 * GUI_GRID_H;
        tooltip = "";

        onButtonClick = "['Preset_button', _this] call Func_Dialog_HandleGearDialog";
    };

    class Preset_2_button: Preset_1_button
    {
        idc = IDC_Preset_2_button;
        shortcuts[] = {};
        x = 15.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        tooltip = "";
    };

    class Preset_3_button: Preset_1_button
    {
        idc = IDC_Preset_3_button;
        shortcuts[] = {};
        x = 17.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        tooltip = "";
    };

    class Preset_4_button: Preset_1_button
    {
        idc = IDC_Preset_4_button;
        shortcuts[] = {};
        x = 19.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        tooltip = "";
    };

    class Preset_5_button: Preset_1_button
    {
        idc = IDC_Preset_5_button;
        shortcuts[] = {};
        x = 21.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        tooltip = "";
    };



    class Clear_button: RscActiveText
    {
        idc = IDC_Clear_button;
        shortcuts[] = {"512 + 0x31"};
        style = 48;
        color[] = {1, 1, 1, 1};
        colorActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 1};
        text = "\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_clear_ca.paa";
        x = 13.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 25 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
	w = 1.56 * GUI_GRID_W;
	h = 1.3 * GUI_GRID_H;
        tooltip = "$STR_DISP_ARCMAP_CLEAR_first";

        onButtonClick = "['Clear_button', _this] call Func_Dialog_HandleGearDialog";
    };

    class Save_button: Clear_button
    {
        idc = IDC_Save_button;
        shortcuts[] = {"512 + 0x1F"};
        text = "\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_save_ca.paa";
        x = 15.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        tooltip = "$STR_DISP_ARCMAP_SAVE_first";

        onButtonClick = "['Save_button', _this] call Func_Dialog_HandleGearDialog";
    };

    class OK_button: Clear_button
    {
        idc = IDC_OK_button;
        shortcuts[] = {}; // TODO
        color[] = {0, 1, 0, 0.5};
        colorActive[] = {0, 1, 0, 1};
        text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_done_3_ca.paa";
        x = 24.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
	w = 2 * 1.56 * GUI_GRID_W;
	h = 2 * 1.3 * GUI_GRID_H;
        tooltip = $STR_WF_Purchase;

        onButtonClick = "['OK_button', _this] call Func_Dialog_HandleGearDialog";
    };

    class Cancel_button: OK_button
    {
        idc = IDC_Cancel_button;
        shortcuts[] = {}; // TODO
        color[] = {1, 1, 0, 0.5};
        colorActive[] = {1, 1, 0, 1};
        text = "\a3\Ui_f\data\gui\Rsc\RscDisplayArcadeMap\icon_exit_ca.paa";
        x = 28.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        tooltip = $STR_WF_Close;

        onButtonClick = "['Cancel_button', _this] call Func_Dialog_HandleGearDialog";
    };

    class Debug_button: OK_button
    {
        idc = 5593;
        shortcuts[] = {}; // TODO
        color[] = {1, 0, 0, 0.5};
        colorActive[] = {1, 0, 0, 1};
        text = "\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_debug_ca.paa";
        x = 32.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        tooltip = "";

        onButtonClick = "createDialog 'RscDebugConsole';";
    };

    class Goggles_button: RscButton
    {
        idc = IDC_Goggles_button;
        onButtonClick = "['Goggles_button', _this] call Func_Dialog_HandleGearDialog";

        text = "Goggles"; //--- ToDo: Localize;
        x = 22 * GUI_GRID_W + GUI_GRID_X;
        y = -4 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class Backpacks_button: RscButton
    {
        idc = IDC_Backpacks_button;
        onButtonClick = "['Backpacks_button', _this] call Func_Dialog_HandleGearDialog";

        text = "Backpacks"; //--- ToDo: Localize;
        x = 17 * GUI_GRID_W + GUI_GRID_X;
        y = -4 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class Clothing_button: RscButton
    {
        idc = IDC_Clothing_button;
        onButtonClick = "['Clothing_button', _this] call Func_Dialog_HandleGearDialog";

        text = "Clothing"; //--- ToDo: Localize;
        x = 12 * GUI_GRID_W + GUI_GRID_X;
        y = -4 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class Items_button: RscButton
    {
        idc = IDC_Items_button;
        onButtonClick = "['Items_button', _this] call Func_Dialog_HandleGearDialog";

        text = "Items"; //--- ToDo: Localize;
        x = 7 * GUI_GRID_W + GUI_GRID_X;
        y = -4 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class Explosives_button: RscButton
    {
        idc = IDC_Explosives_button;
        onButtonClick = "['Explosives_button', _this] call Func_Dialog_HandleGearDialog";

        text = "Explosives"; //--- ToDo: Localize;
        x = 2 * GUI_GRID_W + GUI_GRID_X;
        y = -4 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class Sidearms_button: RscButton
    {
        idc = IDC_Sidearms_button;
        onButtonClick = "['Sidearms_button', _this] call Func_Dialog_HandleGearDialog";

        text = "Sidearms"; //--- ToDo: Localize;
        x = -3 * GUI_GRID_W + GUI_GRID_X;
        y = -4 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class Secondary_button: RscButton
    {
        idc = IDC_Secondary_button;
        onButtonClick = "['Secondary_button', _this] call Func_Dialog_HandleGearDialog";

        text = "Secondary"; //--- ToDo: Localize;
        x = -8 * GUI_GRID_W + GUI_GRID_X;
        y = -4 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class Primary_button: RscButton
    {
        idc = IDC_Primary_button;
        onButtonClick = "['Primary_button', _this] call Func_Dialog_HandleGearDialog";

        text = "Primary"; //--- ToDo: Localize;
        x = -13 * GUI_GRID_W + GUI_GRID_X;
        y = -4 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class Obves3_list: RscObvesListBox
    {
        idc = IDC_Obves3_list;

        onLBDblClick   = "['Weapons_list_onLBDblClick',   _this] call Func_Dialog_HandleGearDialog";

        text = "Obves3_list"; //--- ToDo: Localize;
        x = 4.5 * GUI_GRID_W + GUI_GRID_X;
        y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 17 * GUI_GRID_W;
        h = 4 * GUI_GRID_H;
        colorBackground[] = {0,1,0,0.5};
    };
    class Obves2_list: RscObvesListBox
    {
        idc = IDC_Obves2_list;

        onLBDblClick   = "['Weapons_list_onLBDblClick',   _this] call Func_Dialog_HandleGearDialog";

        text = "Obves2_list"; //--- ToDo: Localize;
        x = 4.5 * GUI_GRID_W + GUI_GRID_X;
        y = 12 * GUI_GRID_H + GUI_GRID_Y;
        w = 17 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
        colorBackground[] = {0,1,0,0.5};
    };
    class Obves1_list: RscObvesListBox
    {
        idc = IDC_Obves1_list;

        onLBDblClick   = "['Weapons_list_onLBDblClick',   _this] call Func_Dialog_HandleGearDialog";

        text = "Obves1_list"; //--- ToDo: Localize;
        x = 4.5 * GUI_GRID_W + GUI_GRID_X;
        y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 17 * GUI_GRID_W;
        h = 8 * GUI_GRID_H;
        colorBackground[] = {0,1,0,0.5};
    };
    class Magazines_list: RscObvesListBox
    {
        idc = IDC_Magazines_list;

        onLBDblClick   = "['Weapons_list_onLBDblClick',   _this] call Func_Dialog_HandleGearDialog";

        text = "Magazines_list"; //--- ToDo: Localize;
        x = 4.5 * GUI_GRID_W + GUI_GRID_X;
        y = -2.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 17 * GUI_GRID_W;
        h = 5.5 * GUI_GRID_H;
        colorBackground[] = {0,1,0,0.5};
    };
    class Weapons_list: RscWeaponsListBox
    {
        idc = IDC_Weapons_list;

        onLBSelChanged = "['Weapons_list_onLBSelChanged', _this] call Func_Dialog_HandleGearDialog";
        onLBDblClick   = "['Weapons_list_onLBDblClick',   _this] call Func_Dialog_HandleGearDialog";
        onLBDrag       = "['onAnyLBDrag',                 _this] call Func_Dialog_HandleGearDialog";

        canDrag = 1;

        text = "Weapons"; //--- ToDo: Localize;
        x = -14 * GUI_GRID_W + GUI_GRID_X;
        y = -2.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 18 * GUI_GRID_W;
        h = 22 * GUI_GRID_H;
    };
    class Cash_text: RscText
    {
        idc = IDC_Cash_text;
	x = 42 * GUI_GRID_W + GUI_GRID_X;
	y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 10 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
    };
    class Cost_text: RscText
    {
        idc = IDC_Cost_text;
	x = 42 * GUI_GRID_W + GUI_GRID_X;
	y = 21.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 10 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
    };


    class CA_PlayerBackground: RscText
    {
        idc = IDC_CA_PlayerBackground;

        x = 13.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 29.28 * GUI_GRID_W;
        h = 22 * GUI_GRID_H;
        colorBackground[] = {0.05,0.05,0.05,0.7};
    };
    class TitleBackground: RscText
    {
        idc = IDC_TitleBackground;

        x = 13.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 29.28 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
        colorBackground[] = {0.1,0.1,0.1,1};
    };
    class PlayersName: RscText
    {
        idc = IDC_PlayersName;

        text = "";
        x = 14.72 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 23.76 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class RankBackground: RscText
    {
        idc = IDC_RankBackground;

        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 1.25 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 0.72 * GUI_GRID_W;
        h = 0.6 * GUI_GRID_H;
        colorBackground[] = {1,1,1,0.2};
    };
    class RankPicture: RscPicture
    {
        idc = IDC_RankPicture;

        text = "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 1.25 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 0.72 * GUI_GRID_W;
        h = 0.6 * GUI_GRID_H;
    };
    class ButtonBack: RscActiveText
    {
        idc = IDC_ButtonBack;
        style = 48;
        color[] = {1,1,1,0.7};

        text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa"; //--- ToDo: Localize;
        x = 41.6 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 1.2 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
        colorText[] = {1,1,1,0.7};
        colorActive[] = {1,1,1,1};
        tooltip = "Close"; //--- ToDo: Localize;
    };
    class BackgroundSlotPrimary: RscPicture
    {
        idc = IDC_BackgroundSlotPrimary;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 14.28 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
    };
    class BackgroundSlotPrimaryMuzzle: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotPrimaryMuzzle;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 9.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotPrimaryFlashlight: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotPrimaryFlashlight;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 31.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 9.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotPrimaryOptics: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotPrimaryOptics;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 35.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 9.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotPrimaryMagazine: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotPrimaryMagazine;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 38.72 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 9.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotSecondary: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotSecondary;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 11.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 14.28 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
    };
    class BackgroundSlotSecondaryMuzzle: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotSecondaryMuzzle;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 14.6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotSecondaryFlashlight: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotSecondaryFlashlight;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 31.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 14.6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotSecondaryOptics: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotSecondaryOptics;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 35.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 14.6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotSecondaryMagazine: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotSecondaryMagazine;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 38.72 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 14.6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotHandgun: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotHandgun;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 17 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 14.28 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
    };
    class BackgroundSlotHandgunMuzzle: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotHandgunMuzzle;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotHandgunFlashlight: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotHandgunFlashlight;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 31.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotHandgunOptics: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotHandgunOptics;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 35.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotHandgunMagazine: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotHandgunMagazine;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 38.72 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotHeadgear: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotHeadgear;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2.9 * GUI_GRID_H;
    };
    class BackgroundSlotGoggles: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotGoggles;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 31.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2.9 * GUI_GRID_H;
    };
    class BackgroundSlotHMD: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotHMD;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 35.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2.9 * GUI_GRID_H;
    };
    class BackgroundSlotBinoculars: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotBinoculars;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 38.72 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2.9 * GUI_GRID_H;
    };
    class BackgroundSlotMap: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotMap;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.544 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotGPS: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotGPS;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 16.78 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.544 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotCompass: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotCompass;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 22.11 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.544 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotRadio: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotRadio;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 19.45 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.544 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class BackgroundSlotWatch: BackgroundSlotPrimary
    {
        idc = IDC_BackgroundSlotWatch;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 24.78 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.544 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
    };
    class PlayerContainerBackground: RscPicture
    {
        idc = IDC_PlayerContainerBackground;

        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 13.2 * GUI_GRID_W;
        h = 14 * GUI_GRID_H;
        colorText[] = {1,1,1,0.1};
    };
    class SlotPrimary: RscActiveText
    {
        idc = IDC_SlotPrimary;
        style = "0x30 + 0x800";
        color[] = {1,1,1,1};
        colorBackgroundSelected[] = {1,1,1,0.1};
        colorFocused[] = {0,0,0,0};
        soundDoubleClick[] = {"",0.1,1};

        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 14.28 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};

        onLBDrag        = "['Slot_onLBDrag',           _this] call Func_Dialog_HandleGearDialog;";
        onLBDragging    = "['Slot_onLBDragging',       _this] call Func_Dialog_HandleGearDialog;";
        onLBDrop        = "['Slot_onLBDrop',           _this] call Func_Dialog_HandleGearDialog;";
	onMouseButtonUp = "['Slot_onMouseButtonClick', _this] call Func_Dialog_HandleGearDialog;";
        canDrag = 0;
    };
    class SlotPrimaryMuzzle: SlotPrimary
    {
        idc = IDC_SlotPrimaryMuzzle;

        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 9.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotPrimaryGrip: SlotPrimary
    {
        idc = IDC_SlotPrimaryGrip;
        x = 42.8 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 9 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 0 * GUI_GRID_W;
        h = 0 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotPrimaryFlashlight: SlotPrimary
    {
        idc = IDC_SlotPrimaryFlashlight;

        x = 31.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 9.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotPrimaryOptics: SlotPrimary
    {
        idc = IDC_SlotPrimaryOptics;

        x = 35.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 9.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotPrimaryMagazine: SlotPrimary
    {
        idc = IDC_SlotPrimaryMagazine;

        x = 38.72 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 9.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotSecondary: SlotPrimary
    {
        idc = IDC_SlotSecondary;

        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 11.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 14.28 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotSecondaryMuzzle: SlotPrimary
    {
        idc = IDC_SlotSecondaryMuzzle;

        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 14.6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotSecondaryGrip: SlotPrimary
    {
        idc = IDC_SlotSecondaryGrip;
        x = 42.8 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 14.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 0 * GUI_GRID_W;
        h = 0 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotSecondaryFlashlight: SlotPrimary
    {
        idc = IDC_SlotSecondaryFlashlight;

        x = 31.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 14.6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotSecondaryOptics: SlotPrimary
    {
        idc = IDC_SlotSecondaryOptics;

        x = 35.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 14.6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotSecondaryMagazine: SlotPrimary
    {
        idc = IDC_SlotSecondaryMagazine;

        x = 38.72 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 14.6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotHandgun: SlotPrimary
    {
        idc = IDC_SlotHandgun;

        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 17 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 14.28 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotHandgunMuzzle: SlotPrimary
    {
        idc = IDC_SlotHandgunMuzzle;

        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotHandgunGrip: SlotPrimary
    {
        idc = IDC_SlotHandgunGrip;
        x = 42.8 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 0 * GUI_GRID_W;
        h = 0 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotHandgunFlashlight: SlotPrimary
    {
        idc = IDC_SlotHandgunFlashlight;

        x = 31.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotHandgunOptics: SlotPrimary
    {
        idc = IDC_SlotHandgunOptics;

        x = 35.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotHandgunMagazine: SlotPrimary
    {
        idc = IDC_SlotHandgunMagazine;

        x = 38.72 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotHeadgear: SlotPrimary
    {
        idc = IDC_SlotHeadgear;

        x = 27.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2.9 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotGoggles: SlotPrimary
    {
        idc = IDC_SlotGoggles;

        x = 31.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2.9 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotHMD: SlotPrimary
    {
        idc = IDC_SlotHMD;

        x = 35.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2.9 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotBinoculars: SlotPrimary
    {
        idc = IDC_SlotBinoculars;

        x = 38.72 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.48 * GUI_GRID_W;
        h = 2.9 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotMap: SlotPrimary
    {
        idc = IDC_SlotMap;

        x = 14.19 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.4 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotGPS: SlotPrimary
    {
        idc = IDC_SlotGPS;

        x = 16.86 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.4 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotCompass: SlotPrimary
    {
        idc = IDC_SlotCompass;

        x = 22.18 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.4 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotRadio: SlotPrimary
    {
        idc = IDC_SlotRadio;

        x = 19.52 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.4 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class SlotWatch: SlotPrimary
    {
        idc = IDC_SlotWatch;

        x = 24.85 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 20.1 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 2.4 * GUI_GRID_W;
        h = 2 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};
    };
    class UniformTab: RscPicture
    {
        idc = IDC_UniformTab;

        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 4.2 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
        text = "#(argb,8,8,3)color(0.4,0.4,0.4,0.4)";
    };
    class UniformSlot: SlotPrimary
    {
        idc = IDC_UniformSlot;

        x = 14.42 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.6 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};

        onMouseButtonUp = "['ContainerSlot_onMouseButtonClick', _this] call Func_Dialog_HandleGearDialog;";
    };
    class UniformLoad: GroundLoad
    {
        idc = IDC_UniformLoad;

        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 5.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 4.2 * GUI_GRID_W;
        h = 0.5 * GUI_GRID_H;
    };
    class UniformLoadPicture: RscPicture
    {
        idc = IDC_UniformLoadPicture;

        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 5.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 4.2 * GUI_GRID_W;
        h = 0.5 * GUI_GRID_H;

        text = "\a3\Ui_f\data\IGUI\Cfg\CommandBar\unitNameBackground_selected_ca.paa";
    };
    class UniformContainer: RscListBox
    {
        idc = IDC_UniformContainer;

        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 13.2 * GUI_GRID_W;
        h = 14 * GUI_GRID_H;
        colorBackground[] = {0,0,0,0};
        itemBackground[] = {1,1,1,0.1};
        itemSpacing = 0.001;
        sizeEx = 20 * 0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * GUI_GRID_H;
        sizeEx2 = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        rowHeight = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        canDrag = 0;

        onLBDrag     = "['Slot_onLBDrag',     _this] call Func_Dialog_HandleGearDialog;";
        onLBDragging = "['Slot_onLBDragging', _this] call Func_Dialog_HandleGearDialog;";
        onLBDrop     = "['Slot_onLBDrop',     _this] call Func_Dialog_HandleGearDialog;";

	onMouseButtonDblClick = "['ContainerItem_onMouseButtonClick', _this] call Func_Dialog_HandleGearDialog;";
    };
    class VestTab: UniformTab
    {
        idc = IDC_VestTab;

        x = 18.62 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 4.2 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
    };
    class VestSlot: SlotPrimary
    {
        idc = IDC_VestSlot;

        x = 18.92 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.6 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};

        onMouseButtonUp = "['ContainerSlot_onMouseButtonClick', _this] call Func_Dialog_HandleGearDialog;";
    };
    class VestLoad: GroundLoad
    {
        idc = IDC_VestLoad;

        x = 18.62 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 5.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 4.2 * GUI_GRID_W;
        h = 0.5 * GUI_GRID_H;
    };
    class VestLoadPicture: RscPicture
    {
        idc = IDC_VestLoadPicture;

        x = 18.62 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 5.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 4.2 * GUI_GRID_W;
        h = 0.5 * GUI_GRID_H;

        text = "\a3\Ui_f\data\IGUI\Cfg\CommandBar\unitNameBackground_selected_ca.paa";
    };
    class VestContainer: UniformContainer
    {
        idc = IDC_VestContainer;

        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 13.2 * GUI_GRID_W;
        h = 14 * GUI_GRID_H;
        colorBackground[] = {0,0,0,0};
        sizeEx = 20 * 0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * GUI_GRID_H;
    };
    class BackpackTab: UniformTab
    {
        idc = IDC_BackpackTab;

        x = 23.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 4.2 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
    };
    class BackpackSlot: SlotPrimary
    {
        idc = IDC_BackpackSlot;

        x = 23.42 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 3.6 * GUI_GRID_W;
        h = 3 * GUI_GRID_H;
        colorText[] = {0,0,0,0.5};
        colorBackground[] = {1,1,1,0.1};

        onMouseButtonUp = "['ContainerSlot_onMouseButtonClick', _this] call Func_Dialog_HandleGearDialog;";
    };
    class BackpackLoad: GroundLoad
    {
        idc = IDC_BackpackLoad;

        x = 23.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 5.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 4.2 * GUI_GRID_W;
        h = 0.5 * GUI_GRID_H;
    };
    class BackpackLoadPicture: RscPicture
    {
        idc = IDC_BackpackLoadPicture;

        x = 23.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 5.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 4.2 * GUI_GRID_W;
        h = 0.5 * GUI_GRID_H;

        text = "\a3\Ui_f\data\IGUI\Cfg\CommandBar\unitNameBackground_selected_ca.paa";
    };
    class BackpackContainer: UniformContainer
    {
        idc = IDC_BackpackContainer;

        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 6 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 13.2 * GUI_GRID_W;
        h = 14 * GUI_GRID_H;
        colorBackground[] = {0,0,0,0};
        sizeEx = 20 * 0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * GUI_GRID_H;
    };
    class TotalLoad: GroundLoad
    {
        idc = IDC_TotalLoad;

        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 22.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 28.08 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class TotalLoadPicture: RscPicture
    {
        idc = IDC_TotalLoadPicture;

        x = 14.12 * GUI_GRID_W + GUI_GRID_X + GUI_ORIG_OFFSET_X;
        y = 22.5 * GUI_GRID_H + GUI_GRID_Y + GUI_ORIG_OFFSET_Y;
        w = 28.08 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;

        text = "\a3\Ui_f\data\IGUI\Cfg\CommandBar\unitNameBackground_selected_ca.paa";
    };
};
