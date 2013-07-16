//sets message to users which are not in TS
//and remove messages for users in TS
/**/
_showmessage=
{
	{
		if ((typeName _x)=="OBJECT") then
		{
			if ((_x getVariable "playername") in (_this select 0)) then
			{
				_x setVariable ["joied_ts",true,true];
			}
			else
			{
				_x setVariable ["joied_ts",false,true];
			};
		};
	} forEach (_this select 1);
};

//removs messages for everybody
_removemessage=
{
	{
		if ((typeName _x)=="OBJECT") then
		{
			_x setVariable ["joied_ts",true,true];			
		};
	} forEach _this;
};

_ts_info_version = "ts-info" callExtension "version";

if (_ts_info_version == "1.1") then
{
Public_TeamSpeakInfo="ts-info" callExtension "get-server-info";
publicVariable "Public_TeamSpeakInfo";

while {!(Global_GameEnded)} do
{
	//data array structure
	//['ARMA2-DAO-VH','name #1','name #2']

	_external_data = "ts-info" callExtension "get-player-list";

	_data=call compile _external_data;

	//check data validity
	if (typeName _data=="ARRAY") then
	{
		if ((count _data)>0) then
		{
			//check signature
			if ((_data select 0)=='ARMA2-DAO-VH') then
			{				
				//set messages for players not in ts
				[_data,[] call Config_EastPlayers] call _showmessage;
				[_data,[] call Config_WestPlayers] call _showmessage;
			}
			else
			{
				diag_log format ["ts-info: %1", _data];
			};
		}
		else
		{
			//remove messages for everybody
			([] call Config_EastPlayers) call _removemessage;
			([] call Config_WestPlayers) call _removemessage;
		};
	}
	else
	{
		//remove messages for everybody
		([] call Config_EastPlayers) call _removemessage;
		([] call Config_WestPlayers) call _removemessage;
	};
	sleep 5;
};

}
else
{
	Public_TeamSpeakInfo="";
	publicVariable "Public_TeamSpeakInfo";
};
