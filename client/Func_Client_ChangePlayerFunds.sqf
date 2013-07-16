Private["_funds"];

_funds = Call Func_Client_GetPlayerFunds;
_funds = _funds + _this;
	
FT2_WF_Logic setVariable [format["FT2_WF_Funds_%1",name player],_funds,true];
