//sets message to users which are not in TS
//and remove messages for users in TS

_ts_users_voted_for_map_change = [];
_change_map_in_progress = false;

/**/
_showmessage=
{
	private ["_names", "_units"];

	_names = _this select 0;
	_units = _this select 1;
	_total_ts_users = 0;

	{
		if ((typeName _x)=="OBJECT") then
		{
			_x_name = _x getVariable "playername";
			_is_ts_user = _x_name in _names;
			_x setVariable ["joied_ts", _is_ts_user, true];
			_total_ts_users = _total_ts_users + (if (_is_ts_user) then { 1 } else { 0 });

			if (_is_ts_user) then
			{
				if (_x getVariable ["change_map", false]) then
				{
					if !(_x in _ts_users_voted_for_map_change) then
					{
						_ts_users_voted_for_map_change = _ts_users_voted_for_map_change + [_x];
						systemChat format ["Player %1 wants to change the map. %2/%3", _x_name, count _ts_users_voted_for_map_change, _total_ts_users];						
					};
				};
			};
		};
	} forEach _units;

	if !(_change_map_in_progress) then
	{
		if (count _ts_users_voted_for_map_change > (_total_ts_users / 2)) then
		{
			_change_map_in_progress = true;
			Global_GameEnded=true; "Global_GameEnded" call Func_Common_PublicVariable;
		};
	};
};

//removes messages for everybody
_removemessage=
{
	{
		if ((typeName _x)=="OBJECT") then
		{
			_x setVariable ["joied_ts",true,true];			
		};
	} forEach _this;
};

_escapeString = 
{
	private ["_result", "_quote_sym"];
	
	_result = [];
	_quote_sym = (toArray """") select 0;
	
	{
		_result set [count _result, _x];
		
		if (_x == _quote_sym) then
		{
			_result set [count _result, _x];
		};
	} forEach toArray _this;
	
	toString _result
};

_ts_info_version = "ts-info" callExtension "version";

if (_ts_info_version == "1.3") then
{
	Public_TeamSpeakInfo="ts-info" callExtension "get-server-info";
	[] call Func_Common_TeamSpeakInfo;
	"Public_TeamSpeakInfo" call Func_Common_PublicVariable;

	while {!(Global_GameEnded)} do
	{
		//data array structure
		//['ARMA3-HIA3','name #1','name #2']

		_player_info = [];
		
		{
			private ["_name", "_side"];
			
			_name = _x getVariable "playername";
			_side = _x getVariable "ft2_wf_side";
			
			if (!(isNil "_name") && !(isNil "_side")) then
			{
				_name = _name call _escapeString;
				_side = if (_side == EAST) then { 0 } else { 1 };
				
				_player_info set [count _player_info, [_name, _side]];
			};
		} forEach allUnits;
		
		_external_data = "ts-info" callExtension (format ["get-player-list %1", _player_info]);

		_data=call compile _external_data;

		//check data validity
		if (typeName _data=="ARRAY") then
		{
			if ((count _data)>0) then
			{
				//check signature
				if ((_data select 0)=='ARMA3-HIA3') then
				{				
					//set messages for players not in ts
					[_data, allUnits] call _showmessage;
				}
				else
				{
					diag_log format ["ts-info: %1", _data];
				};
			}
			else
			{
				//remove messages for everybody
				allUnits call _removemessage;
			};
		}
		else
		{
			//remove messages for everybody
			allUnits call _removemessage;
		};
		sleep 5;
	};
}
else
{
	Public_TeamSpeakInfo="";
	[] call Func_Common_TeamSpeakInfo;
	"Public_TeamSpeakInfo" call Func_Common_PublicVariable;
};
