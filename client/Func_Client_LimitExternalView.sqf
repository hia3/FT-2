//3rd view limitation
//see Params.hpp


if (difficultyEnabled "3rdPersonView") then
{
	switch (Local_Param_ExternalView) do
	{
		case 1://vehicles only
		{
			while {(!Global_GameEnded)} do
			{
				waitUntil{(alive player) || Global_GameEnded};
				if (Global_GameEnded) exitWith{};
					
				if (cameraView == "External") then
				{
					if (Local_PlayerVehicle == player) then
					{
						(vehicle player) switchCamera "Internal";
					}
					else
					{						
						if (!(Local_PlayerVehicle isKindOf "plane")) then
						{
							if ((player==gunner Local_PlayerVehicle) || (player==commander Local_PlayerVehicle) || ("Turret"==((assignedVehicleRole player) select 0))) then
							{
								(vehicle player) switchCamera "Internal";
							};
						};						
					};
				};
				sleep 0.1;
			};
		};
		case 2://infantry only
		{
			while {(!Global_GameEnded)} do
			{
				waitUntil{(alive player) || Global_GameEnded};
				if (Global_GameEnded) exitWith{};
					
				if (cameraView == "External") then
				{
					if (Local_PlayerVehicle != player) then
					{
						if (!(Local_PlayerVehicle isKindOf "plane")) then
						{
							(vehicle player) switchCamera "Internal";
						};
					};
				};
				sleep 0.1;
			};
		};
		case 3://disabled
		{
			while {(!Global_GameEnded)} do
			{
				waitUntil{(alive player) || Global_GameEnded};
				if (Global_GameEnded) exitWith{};

				if (cameraView == "External") then
				{
					if (Local_PlayerVehicle == cameraOn) then
					{
						if (!(Local_PlayerVehicle isKindOf "plane")) then
						{
							(vehicle player) switchCamera "Internal";
						};
					};
				};
				sleep 0.1;
			};
		};
	};
};
