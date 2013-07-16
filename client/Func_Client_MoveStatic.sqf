_anims=["aidlpknlmstpslowwrfldnon_player_idlesteady01","aidlpknlmstpslowwrfldnon_player_idlesteady02","aidlpknlmstpslowwrfldnon_player_idlesteady03","aidlpknlmstpslowwrfldnon_player_idlesteady04","aidlpknlmstpslowwrfldnon_player_idlesteady05","amovpknlmstpslowwrfldnon","amovpknlmwlkslowwrfldf","amovpknlmwlkslowwrfldfl","amovpknlmwlkslowwrfldl","amovpknlmwlkslowwrfldbl","amovpknlmwlkslowwrfldb","amovpknlmwlkslowwrfldbr","amovpknlmwlkslowwrfldr","amovpknlmwlkslowwrfldfr","aidlpknlmstpslowwrfldnon_player_0s","amovpercmstpsraswrfldnon_amovpknlmstpslowwrfldnon","amovpercmstpslowwrfldnon_amovpknlmstpslowwrfldnon"];

Local_MovingStatic=true;
_this setVariable ["StaticMover",player,true];
player playMove "amovpknlmstpslowwrfldnon";

_timer=time+3;
waitUntil{((animationState player)=="amovpknlmstpslowwrfldnon") || (_timer < time)};

if (_timer > time) then
{	
	_name=getText (configFile >> "CfgVehicles" >> (typeOf _this) >> "DisplayName");
	_pic=getText (configFile >> "CfgVehicles" >> (typeOf _this) >> "Picture");
	[_name,localize "STR_HINT_MGMove",_pic,1.0] call Func_Client_ShowCustomMessage;
	
	_dir=getDir player;
	_pos_p=getPosATL player;
	_pos=[(_pos_p select 0)+2*sin(_dir),(_pos_p select 1)+2*cos(_dir),_pos_p select 2];
	_this setPosATL _pos;

	_pos=_this modelToWorld [0,0,0];

	_this attachTo[player,[0,2,(_pos select 2)-(_pos_p select 2)]];

	waitUntil{!((animationState player) in _anims) || (({alive _x} count crew _this) > 0) || ((_this distance player)>5) || !(alive _this)};

	detach _this;
	_pos=getPosATL _this;
	_this setPosATL [_pos select 0,_pos select 1,(getPosATL player) select 2];

	[_name,localize "STR_HINT_MGDrop",_pic,1.0] call Func_Client_ShowCustomMessage;	
};

Local_MovingStatic=false;
_this setVariable ["StaticMover",objNull,true];