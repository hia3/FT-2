#define ColorYellow [1,0.91,0.196,1]

disableSerialization;

_display=_this select 0;
_map=_display displayCtrl 15001;

_idclist=3700;
_idpass=3701;
_idcbtnnew=13002;
_idcbtnjoin=13003;
_idcbtnleave=13004;
Dialog_GroupLbChange=false;
Dialog_MenuAction=-1;

_newgroup=-1;
_password="";

_filllist=
{
	private["_idclist","_nogroup","_groups","_groupslist","_allunits","_number","_index","_index","_i","_j"];
	
	_idclist=3700;
	_nogroup=[];
	_groups=[];
	_groupslist=[];
	_passwordslist=[];
	_allunits=Local_CurrentPlayers;
	
	_playerindex=0;
    //--prepare lists of groups
	{
		_number=_x getVariable ["groupNumber", -1];
		if (_number==-1) then
		{
			_nogroup set [count _nogroup,_x];
		}
		else
		{
			_index=_groupslist find _number;
			if (_index < 0) then
			{
				_cnt=count _groupslist;				
				_groupslist set [_cnt,_number];
				_passwordslist set [_cnt,_x getVariable "groupPassword"];				
				_groups set [_cnt,[_x]];				
			}
			else
			{
				_group=_groups select _index;
				_group=_group+[_x];
				_groups set [_index,_group];
			};
		};
	} forEach _allunits;

	//--fill the dialog
	lnbClear _idclist;	
	
	//--fill groups
	_i=0;
	_j=0;
	{	
		lnbAddRow[_idclist,[format [localize "STR_WF_GroupName",_groupslist select _i]]];			
		lnbSetColor[_idclist,[_j,0],ColorYellow];
		lnbSetValue[_idclist,[_j,0],_groupslist select _i];
		lnbSetData[_idclist,[_j,0],""];
		lnbSetData[_idclist,[_j,1],_passwordslist select _i];
		{
			_j=_j+1;
			
			_name=_x getVariable "playername";
			if !(isNil "_name") then
			{
				lnbAddRow[_idclist,[_name]];
				lnbSetValue[_idclist,[_j,0],_groupslist select _i];
				lnbSetData[_idclist,[_j,0],format["%1",_x]];
				lnbSetData[_idclist,[_j,1],_passwordslist select _i];
				if (_name==Local_PlayerName) then {_playerindex=_j};
			};
		} forEach _x;
		_j=_j+1;
		_i=_i+1;
	} forEach _groups;

	//--"no group" string
	lnbAddRow[_idclist,[localize "STR_WF_GroupNo"]];
	lnbSetData[_idclist,[_j,0],""];	
	lnbSetValue[_idclist,[_j,0],-1];
	lnbSetColor[_idclist,[_j,0],ColorYellow];
	
	//--fill units without groups
	_j=_j+1;
	{
		_name=_x getVariable "playername";
		lnbAddRow[_idclist,[_name]];
		lnbSetData[_idclist,[_j,0],format["%1",_x]];
		lnbSetValue[_idclist,[_j,0],-1];
		if (_name==Local_PlayerName) then {_playerindex=_j};
		_j=_j+1;
	} forEach _nogroup;
	
	lnbSetCurSelRow [_idclist,_playerindex];
};

_joingroup=
{
	private["_group","_pass"];
	_group=_this select 0;
	_pass=_this select 1;
	
	Local_PlayerGroupNumber=_group;
	Local_PlayerGroupPassword=_pass;
	
	_unit=objNull;
	
	//send group members a message that we joined the group
	{
		if ((_x getVariable "groupnumber")==_group) then
		{
			["message_group", [true, Local_PlayerName], _x] call Func_Common_SendRemoteCommand;
			
			if (isNull _unit) then
			{
				_unit=leader _x;
			};
		};
	} forEach Local_CurrentPlayers;
	
	//join group
	player setVariable["groupNumber",_group,true];
	player setVariable["groupPassword",_pass,true];
	player groupChat format [localize "STR_MES_JoinGroup",_group];
	[player] join _unit;
};

[] call _filllist;

while {dialog && !Global_GameEnded} do
{
	if (!dialog) exitWith {};
	
	if (Dialog_GroupLbChange) then
	{
		Dialog_GroupLbChange=false;		
		_index=lnbCurSelRow _idclist;
		_unit=lnbData [_idclist,[_index,0]];				
		if (_unit!="") then
		{			
			_map ctrlMapAnimAdd [2,0.16,position (call compile _unit)];
			ctrlMapAnimCommit _map;
		};
		
		_group=lnbValue[_idclist,[_index,0]];
		if ((player getVariable "groupnumber")==-1) then
		{
			ctrlEnable[_idcbtnnew,true];
			ctrlEnable[_idcbtnleave,false];
			if (_group==-1) then
			{
				ctrlEnable[_idcbtnjoin,false];
			}
			else
			{
				ctrlEnable[_idcbtnjoin,true];
			};
		}
		else
		{
			ctrlEnable[_idcbtnnew,false];
			ctrlEnable[_idcbtnjoin,false];
			ctrlEnable[_idcbtnleave,true];
		};
	};
	
	if (Dialog_MenuAction!=-1) then
	{
		switch (Dialog_MenuAction) do
		{
			case 1://create a new group
			{			
				Dialog_MenuAction=-1;
				createDialog "RscPasswordC";				
			};
			case 2://join some group
			{
				_index=lnbCurSelRow _idclist;
				_password=lnbData[_idclist,[_index,1]];
				_newgroup=lnbValue[_idclist,[_index,0]];				
				
				if (_password != "") then
				{
					Dialog_MenuAction=-1;
					createDialog "RscPasswordJ";
				}
				else
				{				
					[_newgroup,""] call _joingroup;
				};								
			};
			case 3://leave current group
			{
				_newgroup=player getVariable "groupNumber";
				
				player setVariable["groupNumber",-1,true];
				player groupChat format [localize "STR_MES_LeaveGroup",_newgroup];
				
				Local_PlayerGroupNumber=-1;
				
				if ((count units player) > 1) then
				{
					[player] join grpNull;
				};				
				
				//send group members a message that we joined the group
				{
					if ((_x getVariable "groupnumber")==_newgroup) then
					{
						["message_group", [false, Local_PlayerName], _x] call Func_Common_SendRemoteCommand;
					};
				} forEach Local_CurrentPlayers;
			};
			case 4://Player applied new group creation
			{							
				Local_PlayerGroupNumber=round(random(1000));
				Local_PlayerGroupPassword=ctrlText _idpass;
				
				player setVariable["groupNumber",Local_PlayerGroupNumber,true];
				player setVariable["groupPassword",Local_PlayerGroupPassword,true];
				player groupChat format [localize "STR_MES_NewGroup",Local_PlayerGroupNumber];
				
				closeDialog 0;	
				sleep 0.5;
			};
			case 5://Player joins a group, protected with a password
			{							
				_pass=ctrlText _idpass;
				
				if (_pass==_password) then
				{
					[_newgroup,""] call _joingroup;					
					
					closeDialog 0;	
					sleep 0.5;
				}
				else				
				{
					player commandChat localize "STR_MES_InvalidPassword";
					playSound "error_sound";
				};
			};
		};
		if (Dialog_MenuAction!=1) then
		{
			Dialog_MenuAction=-1;
			[] call _filllist;		
		};	
	};
		
	sleep 0.5;
};
