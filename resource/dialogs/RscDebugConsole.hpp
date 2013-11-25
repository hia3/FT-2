
class RscDebugConsole  {

	movingEnable = 1;
	idd = -1;
	onLoad = "";

	class controlsBackground
	{
		class Mainback : IGUIBack
		{
			x = 0;
			y = 0.2;
			w = 1;
			h = 0.6;

			colorbackground[] = {0.3, 0.4, 0.5, 0.85};
		};
	};

	class controls {
		class Console: RscTextBox_ext {
			idc = 10001;
			style = 16;
			x = 0;
			y = 0.2;
			w = 1;
			h = 0.3;
			lineSpacing = 2.5;
			htmlControl = 1;
			color[] = {0, 0, 0, 1};
			colorSelection[] = {0.3,0.3,0.3,0.8};
			colorText[] = {0.9, 0.9, 0.9, 1.0};
			text = "";
			autocomplete = "scripting";
		};
		class Output: RscTextBox_ext {
			idc = 10002;
			style = 16;
			x = 0;
			y = 0.5;
			w = 1;
			h = 0.3;
			lineSpacing = 2.5;
			htmlControl = 1;
			color[] = {0, 0, 0, 1};
			colorSelection[] = {0.3,0.3,0.3,0.8};
			colorText[] = {0.9, 0.9, 0.9, 1.0};
			text = "";
			autocomplete = true;

		};
		class CA_Execute: RscShortcutButton {
			idc = -1;
			default = 0;
			x = 0.0;
			y = 0.85;
			w = 1;
			text = "Execute";
			action = "ctrlSetText [10002, str (call compile (ctrlText 10001))];";
		};
	};
};
