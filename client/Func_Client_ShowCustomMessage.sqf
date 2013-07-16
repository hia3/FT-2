//variuos hint messages

private ["_sound_name"];

_sound_name = if ((count _this) > 4) then { _this select 4 } else { "" };

if (_sound_name != "") then
{
	playSound _sound_name;
};

hintSilent composeText [parseText format ["<t align='left' size='%4'><img image='%3'></t>" +"<t align='center' size='1.25' shadow='true'>%1</t><t align='right' size='%4'><img image='%3'></t>" +"<br/>" +"<t align='center' size='1.0' shadow='true'>%2</t>",_this select 0,_this select 1,_this select 2,_this select 3]];
