/**/
_duration=_this select 0;

sleep 0.2;

_time=player getVariable "deafness";

if (_time > time) exitWith
{
	player setVariable ["deafness",_time+_duration];
};

player setVariable ["deafness",time+_duration];

0 fadeSound 0;
0 fadeRadio 0;

while {(alive player) && ((player getVariable "deafness")>time)} do
{
	sleep 1;
};

4 fadeSound 1;
4 fadeRadio 1;

playSound "deafness";


