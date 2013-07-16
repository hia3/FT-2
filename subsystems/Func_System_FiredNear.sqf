#define _rpgdistance 10
#define _gundistance 50

/*start script*/

_hearer=_this select 0;
_shooter=_this select 1;
_distance=_this select 2;
_weapon=_this select 3;
//_muzzle=_this select 4;

if ((_hearer!=(vehicle _hearer)) || !(isNull Local_Camera)) exitWith {};

if (_shooter isKindOf "man") then
{
	if ((_weapon==secondaryWeapon _shooter) && (_distance < _rpgdistance)) then
	{
		[0] spawn Func_System_Deafness;		
	};
}else{
	_reloadTime=getNumber(configFile>>"CfgWeapons">>_weapon>>"reloadTime");
	//if ((_shooter isKindOf "Tank") && (_reloadTime>2) && (_distance < _gundistance)) then
	if ((_reloadTime>2) && (_distance < _gundistance)) then
	{
		[random 5] spawn Func_System_Deafness;	
	};
};
