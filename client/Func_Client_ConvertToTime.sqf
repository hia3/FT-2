	//converts mission time from seconds
	//to h:mm:ss
	// see Func_Client_UpdateGUI

	_v=_this select 0;	
	_full=_this select 1;
	
	_v=_v max 0;	
	
	_h=floor(_v/3600);
	_v=_v-(_h*3600);
	_m=floor(_v/60);
	_s=floor(_v-(_m*60));
	_h=_h mod 24;
	
	_h1="";
	_m1="";
	_s1="";
	
	if (_full) then
	{
		_h1=format["%1",_h];
	};
	
	if(_m<10)then
	{
		_m1=format["0%1",_m];
	}
	else
	{
		_m1=format["%1",_m];
	};
	if(_s<10)then
	{
		_s1=format["0%1",_s];
	}
	else
	{
		_s1=format["%1",_s];
	};
	
	if (_full) then
	{
		_v=format ["%1:%2:%3",_h1,_m1,_s1];
	}
	else
	{
		_v=format ["%1:%2",_m1,_s1];
	};
		
	_v
	