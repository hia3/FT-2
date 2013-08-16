/**/
_carVehicleClasses=FT2_WF_Logic getVariable 'carVehicleClasses';
_carVehicleCosts=FT2_WF_Logic getVariable 'carVehicleCosts';
_carVehiclePictures=FT2_WF_Logic getVariable 'carVehiclePictures';
_carVehicleNames=FT2_WF_Logic getVariable 'carVehicleNames';
_carVehicleTimes=FT2_WF_Logic getVariable 'carVehicleTimes';

_supportVehicleClasses=FT2_WF_Logic getVariable 'supportVehicleClasses';
_supportVehicleCosts=FT2_WF_Logic getVariable 'supportVehicleCosts';
_supportVehiclePictures=FT2_WF_Logic getVariable 'supportVehiclePictures';
_supportVehicleNames=FT2_WF_Logic getVariable 'supportVehicleNames';
_supportVehicleTimes=FT2_WF_Logic getVariable 'supportVehicleTimes';

_armorVehicleClasses=FT2_WF_Logic getVariable 'armorVehicleClasses';
_armorVehicleCosts=FT2_WF_Logic getVariable 'armorVehicleCosts';
_armorVehiclePictures=FT2_WF_Logic getVariable 'armorVehiclePictures';
_armorVehicleNames=FT2_WF_Logic getVariable 'armorVehicleNames';
_armorVehicleTimes=FT2_WF_Logic getVariable 'armorVehicleTimes';

_heliVehicleClasses=FT2_WF_Logic getVariable 'heliVehicleClasses';
_heliVehicleCosts=FT2_WF_Logic getVariable 'heliVehicleCosts';
_heliVehiclePictures=FT2_WF_Logic getVariable 'heliVehiclePictures';
_heliVehicleNames=FT2_WF_Logic getVariable 'heliVehicleNames';
_heliVehicleTimes=FT2_WF_Logic getVariable 'heliVehicleTimes';

_airVehicleClasses=FT2_WF_Logic getVariable 'airVehicleClasses';
_airVehicleCosts=FT2_WF_Logic getVariable 'airVehicleCosts';
_airVehiclePictures=FT2_WF_Logic getVariable 'airVehiclePictures';
_airVehicleNames=FT2_WF_Logic getVariable 'airVehicleNames';
_airVehicleTimes=FT2_WF_Logic getVariable 'airVehicleTimes';

disableSerialization;
_display = _this select 0;

_lb=3708;
_ld=3709;
_fillerIDC = [3700,3701,3702,3703,3704];
_fillerTypes = ["car","armor","heli","air","support"];
_lastFiller = Dialog_VehicleFiller;
_updateFiller=true;

_listClasses = [];
_listCosts = [];
_listNames = [];
_listPictures = [];
_listTimes = [];
_currentItem="";
_currentCost=0;
_currentName="";
_currentPicture="";
_currentTime=0;

_fillList = {
	Private ["_i","_listBox","_listCosts","_listNames","_listPictures","_u"];
	_listCosts = _this select 0;
	_listNames = _this select 1;
	_listPictures = _this select 2;
	_listCosts = _this select 3;
	//_filler = _this select 4;
	_listBox = _this select 5;
	//_listBoxArray = [];
	_u = 0;
	_i = 0;

	{
		lnbAddRow [_listBox,["$"+str (_listCosts Select _u),_x]];
		lnbSetPicture [_listBox,[_i,0],_listPictures select _u];
		lnbSetValue [_listBox,[_i,1],_listCosts select _u];
		lnbSetValue [_listBox,[_i,0],_u];
		_i = _i + 1;
		_u = _u + 1;
	} forEach _listNames;

	lnbSetCurSelRow [_listBox,0]
};

Dialog_VehicleLbChange = false;
Dialog_VehicleActionSE = "";

while {alive player && dialog} do
{
	if (!dialog) exitWith {};

	//--- Something changed since the last time?
	_filler = Dialog_VehicleFiller;
	_changed = Dialog_VehicleLbChange;
	_actionSE = Dialog_VehicleActionSE;

	//--- Filter Changed.
	if (_filler != _lastFiller || _updateFiller) then {
		_updateFiller = false;
		_listClasses = Call Compile Format ["_%1VehicleClasses",_filler];
		_listCosts = Call Compile Format ["_%1VehicleCosts",_filler];
		_listNames = Call Compile Format ["_%1VehicleNames",_filler];
		_listPictures = Call Compile Format ["_%1VehiclePictures",_filler];
		_listTimes = Call Compile Format ["_%1VehicleTimes",_filler];

		lnbClear _lb;
		[_listCosts,_listNames,_listPictures,_listCosts,_filler,_lb] Call _fillList;
		_id = _fillerTypes find _filler;
		{(_display displayCtrl _x) ctrlSetTextColor [1, 1, 1, 1]} forEach _fillerIDC;
		(_display displayCtrl (_fillerIDC select _id)) ctrlSetTextColor [0.7, 1, 0.7, 1];
		//--- Update the list since the filler changed.
		_changed = true;
	};

	//--- List Selection Changed.
	if (_changed) then {
		Dialog_VehicleLbChange=false;
		_currentRow = lnbCurSelRow _lb;
		//_currentData = lnbData[_lb,[_currentRow,0]];
		_currentValue = lnbValue[_lb,[_currentRow,0]];
		_currentCost = lnbValue[_lb,[_currentRow,1]];
		_currentItem = _listClasses select _currentValue;
		_currentItem = if (isNil "_currentItem") then { "" } else { _currentItem };
		_currentName = _listNames select _currentValue;
		_currentPicture = _listPictures select _currentValue;
		_currentTime = _listTimes select _currentValue;

		if (isClass (configFile >> 'CfgVehicles' >> _currentItem >> 'Library')) then
		{
			_txt = getText (configFile >> 'CfgVehicles' >> _currentItem >> 'Library' >> 'libTextDesc');
			(_display displayCtrl 3709) ctrlSetStructuredText (parseText format["<t size='0.65' align='justify'>%1</t>",_txt]);
		}
		else
		{
			(_display displayCtrl 3709) ctrlSetStructuredText (parseText '');
		};
	};

	if (_actionSE=="buy") then
	{
		if (isClass (configFile >> 'CfgVehicles' >> _currentItem)) then
		{
			if (_currentCost <= ([] call Func_Client_GetPlayerFunds)) then
			{
				_vehiclecost = _currentCost;

				[_currentItem,_vehiclecost,_currentTime,12] call Func_Client_CreateCustomVehicle;

				-_currentCost call Func_Client_ChangePlayerFunds;
				[{ ctrlEnable [3710,false]; sleep 1; ctrlEnable [3710,true]; }, []] call Func_Common_Spawn;
				[_currentName,localize "STR_HINT_VehicleBought",_currentPicture,1.35] call Func_Client_ShowCustomMessage;
			}
			else
			{
				[localize "STR_HINT_Vehicles",localize "STR_HINT_LowFunds","pic\icon_funds.paa",1.35,"error_sound"] call Func_Client_ShowCustomMessage;
			};
		};
		Dialog_VehicleActionSE = "";
	};

	//--- Player"s Cash.
	ctrlSetText[3706,Format["%1 $ %2.",localize "STR_WF_CashLabel",Call Func_Client_GetPlayerFunds]];

	_lastFiller = _filler;
	sleep 0.05;
};

Dialog_VehicleLbChange=false;
Dialog_VehicleActionSE="";
