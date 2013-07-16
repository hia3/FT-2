	//script compiles score statistics
	//in outro

	_Bool=str(_this select 4);
	
	//compile check point colors array
	_CheckPointColors=[];
	{
		_CheckPointColors=_CheckPointColors+[markerColor(_x select 3)];
	}forEach Config_TotalCheckPointData;
	
	_String="";
	_Space="";
	
	//compile "total score" section
	_String=_String+"<t size='1.0' color='#000000' shadow='"+_Bool+"'>"+format [localize "STR_NAME_Teams"]+"</t>";
	_String=_String+"<t size='1.0' color='#000000' shadow='"+_Bool+"' align='right'>"+format [localize "STR_NAME_Score"]+"</t><br/>";
	_String=_String+"<t size='0.5' color='#222222'></t>";
	
	
		_Points=(Config_EastBaseFlag getVariable "score")+(Config_EastBaseFlag getVariable "bonus");
		_String=_String+format ["<br/><t shadow='%3' color='#dddddd'><img image='%1' size='0.75'/></t><t shadow='%3' color='#000000'> %2</t>",Config_EastSign,Config_EastFactionName,_Bool];
		_String=_String+format ["<t align='right' shadow='%2' color='#000000'>%1</t>",_Points,_Bool];
		_Points=(Config_WestBaseFlag getVariable "score")+(Config_WestBaseFlag getVariable "bonus");
		_String=_String+format ["<br/><t shadow='%3' color='#dddddd'><img image='%1' size='0.75'/></t><t shadow='%3' color='#000000'> %2</t>",Config_WestSign,Config_WestFactionName,_Bool];
		_String=_String+format ["<t align='right' shadow='%2' color='#000000'>%1</t>",_Points,_Bool];
	
	(_this select 0)displayCtrl(_this select 1)ctrlSetStructuredText parseText _String;
	
	//compile "total players section"
	_String=_Space;
	_String=_String+"<t size='1.0' align='right' shadow='"+_Bool+"' color='#000000'>"+format [localize "STR_NAME_Players"]+"</t><br/>";
	_String=_String+"<t size='0.5' color='#222222'> </t>";
	
	_String=_String+format ["<br/><t align='right' shadow='%2' color='#000000'>%1</t>",playersNumber East,_Bool];	
	_String=_String+format ["<br/><t align='right' shadow='%2' color='#000000'>%1</t>",playersNumber West,_Bool];	
	
	(_this select 0)displayCtrl(_this select 2)ctrlSetStructuredText parseText _String;
	
	//compile "captured points section"
	_String=_Space;
	_String=_String+format ["<t size='1.0' align='right' shadow='%2' color='#000000'>%1</t><br/>",localize "STR_NAME_Tasks",_Bool];
	_String=_String+"<t size='0.5' color='#222222'> </t>";
		
	_String=_String+format ["<br/><t align='right' shadow='%2' color='#000000'>%1</t>",{_x==Config_EastColor}count _CheckPointColors,_Bool];
	_String=_String+format ["<br/><t align='right' shadow='%2' color='#000000'>%1</t>",{_x==Config_WestColor}count _CheckPointColors,_Bool];
	
	(_this select 0)displayCtrl(_this select 3)ctrlSetStructuredText parseText _String;
	