//script is called by publicVariableEventhandler "Public_UnitHealed"
//see client`s precompile.sqf

if ((_this select 1)!=player) exitWith {Public_UnitHealed=objNull;};

/*if player was injured by enemy and healer has medic backpack - award healer*/
_a1="Medikit" in (items (_this select 2));
_a2="Medikit" in (items player);

//award only in case if injured player has no medpack and can not heal himself
//player sideChat format["b1:%1 || b2:%2 || a1:%3 || a2:%4",_b1,_b2,_a1,_a2];
if (_a1 && !_a2) then
{
	if (Local_InjuredByEnemy) then
	{
		_fundsname=format["FT2_WF_Funds_%1",_this select 0];
		_funds = FT2_WF_Logic getVariable _fundsname;
		_award=round(Config_AwardKillPlayerValue)/2;
		FT2_WF_Logic setVariable [_fundsname,_funds+_award,true];
		(_this select 2) setVariable ["message_healedteammate",_award,true]
	};
};
/*end*/

player playMove "amovppnemstpsraswrfldnon_healed";
Local_InjuredByEnemy=false;

[_this select 0,localize "STR_HINT_Healed","\A3\ui_f\data\map\vehicleicons\pictureHeal_ca.paa",1.0] call Func_Client_ShowCustomMessage;