#define ColorYellow [1,0.91,0.196,1]

disableSerialization;
_display = _this select 0;

_idcmainlist=3700;
_idchelplist=3701;

_headers=["STR_H_01T","STR_H_02T","STR_H_03T","STR_H_04T","STR_H_05T","STR_H_06T","STR_H_07T","STR_H_08T","STR_H_09T","STR_H_10T","STR_H_11T","STR_H_12T","STR_H_13T"];
_texts=["STR_H_01C","STR_H_02C","STR_H_03C","STR_H_04C","STR_H_05C","STR_H_06C","STR_H_07C","STR_H_08C","STR_H_09C","STR_H_10C","STR_H_11C","STR_H_12C","STR_H_13C"];

_cnt=count _headers;
for [{_i=0},{_i<_cnt},{_i=_i+1}] do
{
	lnbAddRow[_idcmainlist,[localize (_headers select _i)]];	
	lnbSetColor[_idcmainlist,[_i,0],ColorYellow];
};
lnbSetCurSelRow[_idcmainlist,0];

while {dialog && !Global_GameEnded} do
{
	if (!dialog) exitWith {};
	
	if (Dialog_HelpLbChange) then
	{
		Dialog_HelpLbChange=false;
		(_display displayCtrl _idchelplist) ctrlSetStructuredText parseText format["<t align='justify' size='0.8'>%1</t>",localize (_texts select (lnbCurSelRow _idcmainlist))];
	};
		
	sleep 0.5;
};