_veh = _this;

_veh addMPEventHandler ['MPKilled', Func_Common_DestroyUnitAward];
_veh addMPEventHandler ['MPHit',    Func_Common_HandleDamage];
