
Func_Common_AddHandlers      = compile preprocessFile ("common\Func_Common_AddHandlers.sqf");
Func_Common_HandleDamage     = compile preprocessFile ("common\Func_Common_HandleDamage.sqf");
Func_Common_DestroyUnitAward = compile preprocessFile ("common\Func_Common_DestroyUnitAward.sqf");
Func_Common_PublicVariable   = compile preprocessFile ("common\Func_Common_PublicVariable.sqf");

SMS_Func = {player globalChat str _this};
