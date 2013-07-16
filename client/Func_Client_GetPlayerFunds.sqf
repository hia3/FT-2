	//return player`s funds
	//if u need u can request them directly
	//using getVariable

	Private ["_funds"];

	_funds = FT2_WF_Logic getVariable (format["FT2_WF_Funds_%1",Local_PlayerName]);

	_funds
	