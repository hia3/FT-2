/* Controls Definitions. */

#define WFBE_SoundEscape "\A3\ui_f\data\sound\RscButton\soundEscape"
#define WFBE_SoundEnter "\A3\ui_f\data\sound\RscButton\soundEnter"
#define WFBE_SoundClick "\A3\ui_f\data\sound\RscButton\soundClick"
#define WFBE_SoundPush "\A3\ui_f\data\sound\RscButton\soundPush"

class RscPicture_ext {
	type = 0;
	idc = -1;
	style = 48;
	colorText[] = {0.75, 0.75, 0.75, 1};
	colorBackground[] = {0, 0, 0, 0};
	font = "PuristaMedium";
	sizeEx = 0.025;
	soundClick[] = {WFBE_SoundClick, 0.2, 1};
	soundEnter[] = {WFBE_SoundEnter, 0.2, 1};
	soundEscape[] = {WFBE_SoundEscape, 0.2, 1};
	soundPush[] = {WFBE_SoundPush, 0.2, 1};
	w = 0.275;
	h = 0.04;
	text = "";
};
class RscButtonMenu_ext: RscButtonMenu {
	w = 0.4;
	h = 0.1;
	color[] = {0.543, 0.5742, 0.4102, 1.0};
	colorDisabled[] = {1, 1, 1, 0.25};
	
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	
	class ShortcutPos {
		left = 0.0204;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	
	class TextPos {
		left = 0.06;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	textureNoShortcut = "";
	period = 0.5;
	font = "PuristaMedium";
	size = 0.03921;
	sizeEx = 0.03921;
	text = "";
	soundEnter[] = {WFBE_SoundEnter, 0.09, 1};
	soundPush[] = {WFBE_SoundPush, 0.09, 1};
	soundClick[] = {WFBE_SoundClick, 0.07, 1};
	soundEscape[] = {WFBE_SoundEscape, 0.09, 1};
	action = "";
	
	class Attributes {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	
	class AttributesImage {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "false";
	};
};
class RscListBox_ext : RscListBox {
	colorText[] = {1, 1, 1, 0.75};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.95, 0.95, 0.95, 1};
	colorSelect2[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0.6, 0.8392, 0.4706, 1.0};
	colorSelectBackground2[] = {0.6, 0.8392, 0.4706, 1.0};
	colorBackground[] = {0, 0, 0, 1};
	period = 0;
};
class RscListBoxA_ext : RscListBox_ext {
	type = 102;
	lineSpacing = 1;
	sizeEx = 0.029;
	rowHeight = 0.03;
	colorDisabled[] = {0.5,0.5,0.5,0};
};
class RscText_ext {
	idc = -1;
	type = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 256;
	font = "PuristaMedium";
	text = "";
	SizeEx = 0.03921;
	colorText[] = {0.543, 0.5742, 0.4102, 1.0};
	colorBackground[] = {0, 0, 0, 0};
};
class RscStructuredText_ext {
	type = 13;
	idc = -1;
	style = 0;
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = 0.03421;
	colorText[] = {0.7,1,0.7,1};
	
	class Attributes {
		font = "PuristaMedium";
		color = "#b3ffb3";
		align = "left";
		shadow = true;
	};
};
class RscStructuredTextB_ext {
	type=13;
	idc=-1;
	style = 0;
	sizeEx=0.028;
	size=0.02;
	lineSpacing=1;
	colorbackground[]={0,0,0,0};
	colorText[]={1,1,1,1};
	text="";
	x=-1;
	y=-1;
	w=0;
	h=0;
	class Attributes
	{
		font="PuristaMedium";
		color="#ffffff";
		align="left";
		shadow=false;
	};
};
class RscXSliderH_ext {
	idc = -1;
	type = 43;
	style = 0x400  + 0x10;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	color[] = {1, 1, 1, 0.4};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.2};	
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
};
class RscCombo_ext : RscCombo {
	style = 1;

	colorSelect[] = {0.023529, 0, 0.0313725, 1};
	colorText[] = {0.023529, 0, 0.0313725, 1};
	colorBackground[] = {0.95, 0.95, 0.95, 1};
	colorScrollbar[] = {0.023529, 0, 0.0313725, 1};
	colorSelectBackground[] = {0.543, 0.5742, 0.4102, 1.0};
	colorActive[] = {0, 0, 0, 1};
	colorDisabled[] = {0, 0, 0, 0.3};

	sizeEx = 0.031;
};
class RscTextBox_ext {
	idc = -1;
	type = 2;
	style = 0x00;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.4;
	sizeEx = 0.03;
	font = "PuristaMedium";	
	color[] = {0, 0, 0, 0.6};
	colorActive[] = {0, 0, 0, 1};
	colorDisabled[] = {0, 0, 0, 0.3};	
	text = "";
	colorText[] = {0.543, 0.5742, 0.4102, 1.0};
	autocomplete = false;
	colorSelection[] = {0.8,0.8,0.8,0.8};
};
class RscClickableText_ext {
	idc = -1;
	type = 11;
	style = 48 + 0x800;
	color[] = {0.75,0.75,0.75,1};
	colorActive[] = {1,1,1,1};
	colorBackground[] = {0.6, 0.8392, 0.4706, 1.0};
	colorBackgroundSelected[] = {0.6, 0.8392, 0.4706, 1.0};
	colorFocused[] = {0.0, 0.0, 0.0, 0};
	font = "PuristaMedium";
	sizeEx = 0.03921;
	soundClick[] = {WFBE_SoundClick,0.2,1};
	soundDoubleClick[] = {"", 0.1, 1};
	soundEnter[] = {WFBE_SoundEnter,0.2,1};
	soundEscape[] = {WFBE_SoundEscape,0.2,1};
	soundPush[] = {WFBE_SoundPush, 0.2, 1};
	w = 0.275;
	h = 0.04;
	text = "";
};
class RscMapControl_ext {
	type = 101;
	moveOnEdges = 1;
	sizeEx = 0.025;
	style = 48;
	x = 0.2;
	y = 0.2;
	w = 0.2;
	h = 0.2;
	ptsPerSquareSea = 8;
	ptsPerSquareTxt = 10;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = "6.0f";
	ptsPerSquareForEdge = "15.0f";
	ptsPerSquareRoad = "3f";
	ptsPerSquareObj = 15;
	showCountourInterval = "false";
	maxSatelliteAlpha = 0;
	alphaFadeStartScale = 0;
	alphaFadeEndScale = 0;
	colorLevels[] = {0.65, 0.6, 0.45, 1};
	colorSea[] = {0.46, 0.65, 0.74, 0.5};
	colorForest[] = {0.45, 0.64, 0.33, 0.5};
	colorRocks[] = {0, 0, 0, 0.3};
	colorCountlines[] = {0.85, 0.8, 0.65, 1};
	colorMainCountlines[] = {0.45, 0.4, 0.25, 1};
	colorCountlinesWater[] = {0.25, 0.4, 0.5, 0.3};
	colorMainCountlinesWater[] = {0.25, 0.4, 0.5, 0.9};
	colorPowerLines[] = {0.1, 0.1, 0.1, 1};
	colorRailWay[] = {0.8, 0.2, 0, 1};
	colorForestBorder[] = {0, 0, 0, 0};
	colorRocksBorder[] = {0, 0, 0, 0};
	colorNames[] = {0.1, 0.1, 0.1, 0.9};
	colorInactive[] = {1, 1, 1, 0.5};
	colorText[] = {0, 0, 0, 1};
	colorTracks[] = {0.840000, 0.760000, 0.650000, 0.150000};
	colorRoads[] = {0.700000, 0.700000, 0.700000, 1.000000};
	colorMainRoads[] = {0.900000, 0.500000, 0.300000, 1.000000};
	colorTracksFill[] = {0.840000, 0.760000, 0.650000, 1.000000};
	colorRoadsFill[] = {1.000000, 1.000000, 1.000000, 1.000000};
	colorMainRoadsFill[] = {1.000000, 0.600000, 0.400000, 1.000000};
	colorGrid[] = {0.100000, 0.100000, 0.100000, 0.600000};
	colorGridMap[] = {0.100000, 0.100000, 0.100000, 0.600000};
	scaleMin = 0.001000;
	scaleMax = 1.000000;
	scaleDefault = 0.160000;
	colorBackground[] = {0.8, 0.8, 0.8, 1};
	font = "PuristaMedium";
	colorOutside[] = {0, 0, 0, 1};
	fontLabel = "PuristaMedium";
	sizeExLabel = 0.034;
	fontGrid = "PuristaMedium";
	sizeExGrid = 0.03;
	fontUnits = "PuristaMedium";
	sizeExUnits = 0.034;
	fontNames = "PuristaMedium";
	sizeExNames = 0.056;
	fontInfo = "PuristaMedium";
	sizeExInfo = 0.034;
	fontLevel = "PuristaMedium";
	sizeExLevel = 0.024;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	
	class Task {
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "#(argb,8,8,3)color(0,0,0,0)";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		color[] = {0.863, 0.584, 0.0, 1};
		colorCreated[] = {0.95, 0.95, 0.95, 1};
		colorCanceled[] = {0.606, 0.606, 0.606, 1};
		colorDone[] = {0.424, 0.651, 0.247, 1};
		colorFailed[] = {0.706, 0.0745, 0.0196, 1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class CustomMark {
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		color[] = {0.6471, 0.6706, 0.6235, 1.0};
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class Legend {
		x = "SafeZoneX";
		y = "SafeZoneY";
		w = 0.34;
		h = 0.152;
		font = "PuristaMedium";
		sizeEx = 0.03921;
		colorBackground[] = {0.906, 0.901, 0.88, 0};
		color[] = {0, 0, 0, 1};
	};
	
	class Bunker {
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		color[] = {0, 0, 1, 1};
		importance = 1.5 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Bush {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.55, 0.64, 0.43, 1};
		size = 14;
		importance = 0.2 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class BusStop {
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		color[] = {0, 0, 1, 1};
		size = 12;
		importance = 1 * 10 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Command {
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		color[] = {0, 0.9, 0, 1};
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class Cross {
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 0.7 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Fortress {
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Fuelstation {
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.75;
		coefMax = 4;
	};
	
	class Fountain {
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		color[] = {0.2, 0.45, 0.7, 1};
		size = 11;
		importance = 1 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Hospital {
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		color[] = {0.78, 0, 0.05, 1};
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Chapel {
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		color[] = {0, 0, 1, 1};
		size = 16;
		importance = 1 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Church {
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Lighthouse {
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 14;
		color[] = {0, 0.9, 0, 1};
		importance = 3 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Quay {
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Rock {
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		color[] = {0.1, 0.1, 0.1, 0.8};
		size = 12;
		importance = 0.5 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Ruin {
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 1.2 * 16 * 0.05;
		coefMin = 1;
		coefMax = 4;
	};
	
	class SmallTree {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.6 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Stack {
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Tree {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.9 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Tourism {
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		color[] = {0.78, 0, 0.05, 1};
		importance = 1 * 16 * 0.05;
		coefMin = 0.7;
		coefMax = 4;
	};
	
	class Transmitter {
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		color[] = {0, 0.9, 0, 1};
		size = 20;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class ViewTower {
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		color[] = {0, 0.9, 0, 1};
		size = 16;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Watertower {
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		color[] = {0.2, 0.45, 0.7, 1};
		size = 20;
		importance = 1.2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Waypoint {
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 14;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class WaypointCompleted {
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 14;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class ActiveMarker {
		icon = "";
		color[] = {0, 0, 1, 1};
		size = 14;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class PowerSolar {
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.850000;
		coefMax = 1.000000;
		color[] = {1, 1, 1, 1};
	};

	class PowerWave {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.850000;
		coefMax = 1.000000;
		color[] = {1, 1, 1, 1};
	};

	class PowerWind {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.850000;
		coefMax = 1.000000;
		color[] = {1, 1, 1, 1};
	};

	class ShipWreck {
		icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.850000;
		coefMax = 1.000000;
		color[] = {0, 0, 0, 1};
	};
};
