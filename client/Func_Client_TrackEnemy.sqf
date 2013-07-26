//script of tracking enemies
//that have attacked player`s safeZone
//or aproached it

if (((side _this)==Local_PlayerSide) || !(alive _this)) exitWith{};

_tracked=_this getVariable ["istracked", false];

//check if this guy is not allready tracked
if !(_tracked) then
{
	//warning message - "enemy detected"
	player sideChat format[localize "STR_MES_EnemyDetected",mapGridPosition (vehicle _this)];

	//mark the enemy as "allready tracked"
	_this setVariable ["istracked",true,false];
	_marker=format["%1",_this];
	createmarkerLocal[_marker,position _this];
	_marker setMarkerTypeLocal "mil_warning";
	_marker setMarkerSizeLocal [0.7,0.7];
	_marker setMarkerColorLocal Local_EnemyColor;

	//track the enemy
	while {!Global_GameEnded && (alive _this) && ((typeName _this)=="OBJECT") && ((_this getVariable "enemytrack")>time)} do
	{
		_marker setMarkerPosLocal (position (vehicle _this));
		sleep 1;
	};

	//stop tracking
	deleteMarkerLocal _marker;
	_this setVariable ["istracked",false,false];
};
