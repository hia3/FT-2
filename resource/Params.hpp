class Params
{	
	// params array 0
	class Duration	
	{		
		title="$STR_P_Duration";
		values[]={1800,2700,3600,5400,7200,86400};
		texts[]={$STR_P_Duration30,$STR_P_Duration45,$STR_P_Duration60,$STR_P_Duration90,$STR_P_Duration120,$STR_P_Duration1440};
		default=3600;
	};	
	// params array 1
	class Daytime	
	{		
		title="$STR_P_Time";
		values[]={4.5,7.0,12.0,18.5,1.0,99};
		texts[]={$STR_P_Time01,$STR_P_Time02,$STR_P_Time03,$STR_P_Time04,$STR_P_Time05,$STR_P_Time06};
		default=12.0;
	};
	// params array 2
	class Weather	
	{		
	
		// STR_P_Weather01,"Terrible","Ужасная"
		// STR_P_Weather02,"Bad","Плохая"
		// STR_P_Weather03,"Calm","Тихая"
		// STR_P_Weather04,"Perfect","Отличная"
		// STR_P_Weather05,"Changing","Переменчивая"

		title="$STR_P_Weather";
		values[]={1.0, 0.66, 0.33, 0, -1.0};
		texts[]={$STR_P_Weather01, $STR_P_Weather02, $STR_P_Weather03, $STR_P_Weather04, $STR_P_Weather05};
		default=0.33;
	};
	// params array 3
	class ViewDistance
	{		
		title="$STR_P_Distance";
		values[]={500,750,1000,2500,3000,3500,4000,5000,7500,10000};
		texts[]={$STR_P_Distance00,$STR_P_Distance01,$STR_P_Distance02,$STR_P_Distance03,$STR_P_Distance04,$STR_P_Distance05,$STR_P_Distance06,$STR_P_Distance07,$STR_P_Distance08,$STR_P_Distance09};
		default=3000;
	};
	// params array 4
	class ExternalView
	{		
		title="$STR_P_View";

		values[]={0,1,2,3};
		texts[]={$STR_P_View01,$STR_P_View02,$STR_P_View03,$STR_P_View04};
		default=1;
	};	
	// params array 5
	class ScreenMarkers
	{		
		title="$STR_P_Markers";
		values[]={0,1,2};
		texts[]={$STR_WF_SMType00, $STR_WF_SMType01, $STR_WF_SMType02};
		default=2;
	};
	// params array 6
	class Armaments
	{		
		title="$STR_P_Armament";
		values[]={0,1};
		texts[]={$STR_P_Armament01,$STR_P_Armament02};
		default=0;
	};
	// params array 7
	class StartFund
	{		
		title="$STR_P_StartFunds";
		values[]={500,600,700,800,900,1000,3000,5000,7000,10000,20000,1000000};
		texts[]={"$500","$600","$700","$800","$900","$1000","$3000","$5000","$7000","$10000","$20000","$1000000"};
		default=500;
	};
	// params array 8
	class Halo
	{		
		title="$STR_P_Halo";
		values[]={0,1};
		texts[]={$STR_P_Disable,$STR_P_Enable};
		default=1;
	};		
	// params array 9
	class Grass
	{		
		title="$STR_P_Grass";
		values[]={0,1};
		texts[]={$STR_P_Disable,$STR_P_Enable};
		default=1;
	};
	// params array 10
	class BicycleAtMHQ
	{		
		title="$STR_P_BicycleAtMHQ";
		values[]={0,1};
		texts[]={$STR_P_Disable,$STR_P_Enable};
		default=1;
	};
};
