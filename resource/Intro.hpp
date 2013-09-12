	class BackBlack
	{
		idd=-1;
		movingEnable=0;
		duration=30;
		onLoad="";
		name="overlay";
		fadein=0;
		fadeout=0;
		controls[]={"background","Contents"};
		class background
		{
			idc=-1;
			type=0;
			style=ST_PICTURE;
			colorBackground[]={0,0,0,1};
			colorText[]={1,1,1,1};
			font="PuristaMedium";
			sizeEx=0;
			lineSpacing=0;
			access=ReadAndWrite;
			text="#(argb,8,8,3)color(0,0,0,1)";
			x=-1;
			y=-1;
			w=3;
			h=3;
		};
		class Contents:RscText_ext
		{
			idc=1661;
			duration=8;
			font="PuristaMedium";
			style=ST_RIGHT;
			colorText[]={1,1,1,1};
			sizeex=0.04;
			x=SafeZoneW+safeZoneX-0.30;//0.025
			y=SafeZoneH+SafeZoneY-0.052;//0.094
			w=0.95;
			h=0.04;
			text=$STR_DLG_Loading;
		};
	};
	class loading
	{
		idd=1675;
		duration=10;
		fadein=0;
		fadeout=0;
		name="loading";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1);
			y=0.15;			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class copyright
	{
		idd=1675;
		duration=10;
		fadein=0;
		fadeout=0;
		name="stats";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX/1.1);
			y=0.5;			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class trailer
	{		
		idd=1640;
		movingEnable=0;
		duration=47;
		name="trailer";
		controls[]={"Contents"};
		onload="[Func_Client_CopyrightsAndLinks, _this] call Func_Common_Spawn;";
		class Contents:RscStructuredTextB_ext
		{
			idc=1641;
			style=ST_CENTER+ST_SHADOW;
			sizeex=0.020;
			font="EtelkaMonospaceProBold";
			colorText[]={1,1,1,1};
			text="";
			x=-1;
			y=-1;
			w=SafeZoneW;
			h=0.04;
			fadein=4;
			fadeout=4;
		};
	};
	class stats
	{
		idd=1675;
		duration=10;
		name="stats";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.07;
			x=SafeZoneX;
			y=0.4;			
			w=SafeZoneW;
			h=1-0.635;
			default=true;
		};
	};
	class Logo: Stats
	{	
		duration=10;
		fadein=0;
		fadeout=0;	
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.02;
			x=SafeZoneX;
			y=0.3;	
			w=SafeZoneW;
			h=SafezoneH;
			default=true;
		};
	};
	class credits
	{
		idd=1675;
		duration=10;
		fadein=0;
		fadeout=0;
		name="credits";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=SafeZoneX;
			y=0.635;			
			w=SafeZoneW;
			h=1-0.635;
			default=true;
		};
	};
	class credits_rr
	{
		idd=1675;
		duration=10;
		fadein=0;
		fadeout=0;
		name="credits_bl";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX)+0.005;
			y=0.635;			
			w=SafeZoneW;
			h=1-0.635;
			default=true;
		};
	};
	class credits_bl
	{
		idd=1675;
		duration=10;
		fadein=0;
		fadeout=0;
		name="credits_rr";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX)-0.007;
			y=0.635;			
			w=SafeZoneW;
			h=1-0.635;
			default=true;
		};
	};
	class credits_r
	{
		idd=1675;
		duration=10;
		fadein=0;
		fadeout=0;
		name="credits_r";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=SafeZoneX;
			y=0.630;			
			w=SafeZoneW;
			h=1-0.635;
			default=true;
		};
	};
	class credits_b
	{
		idd=1675;
		duration=10;
		fadein=0;
		fadeout=0;
		name="credits_b";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=SafeZoneX;
			y=0.644;			
			w=SafeZoneW;
			h=1-0.635;
			default=true;
		};
	};
	class final
	{
		idd=1676;
		duration=20;
		name="final";
		controls[]={"txt1","txt2","txt3"};
		onload="[(_this select 0),1672,1673,1674,true] call Func_Client_CompileScoreStatistics";
		class txt1:RscStructuredText_ext
		{
			idc=1672;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=0.3;
			y=0.4;
			w=0.5;
			h=1-0.635;
			default=true;
		};
		class txt2:txt1
		{
			idc=1673;
			w=0.4;
		};
		class txt3:txt1
		{
			idc=1674;
			w=0.3;
		};
	};
	class about_end
	{
		idd=1675;
		duration=10;
		fadein=0;
		fadeout=0;
		name="about_end";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1);
			y=0.15;			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class about_split_t
	{
		idd=1675;
		duration=0.1;
		fadein=0;
		fadeout=0;
		name="about_split_t";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1+0.002);
			y=(0.15-0.002);			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class about_split_b
	{
		idd=1675;
		duration=0.1;
		fadein=0;
		fadeout=0;
		name="about_split_b";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1-0.002);
			y=(0.15+0.002);			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class about_split_3t
	{
		idd=1675;
		duration=0.1;
		fadein=0;
		fadeout=0;
		name="about_split_t";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1+0.001);
			y=(0.15-0.006);			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class about_split_3b
	{
		idd=1675;
		duration=0.1;
		fadein=0;
		fadeout=0;
		name="about_split_b";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1-0.001);
			y=(0.15+0.006);			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class about_split_rr
	{
		idd=1675;
		duration=0.1;
		fadein=0;
		fadeout=0;
		name="about_split_t";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1+0.001);
			y=0.15;			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};
	class about_split_lb
	{
		idd=1675;
		duration=0.1;
		fadein=0;
		fadeout=0;
		name="about_split_b";
		controls[]={"txt"};
		onload="_this call compile 'private [''_control''];disableSerialization; _Control=(_this select 0) displayCtrl 1671; _Control ctrlSetStructuredText parseText Local_MultiUseString;'";
		class txt:RscStructuredText_ext
		{
			idc=1671;
			colorBackground[]={0,0,0,0};
			font="PuristaMedium";
			colorText[]={1,1,1,1};
			size=0.04;
			x=(SafeZoneX*1.1-0.001);
			y=0.15;			
			w=SafeZoneW;
			h=(1-0.635);
			default=true;
		};
	};