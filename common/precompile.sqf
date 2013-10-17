MISSION_ROOT = call
{
    private "_arr";
    _arr = toArray str missionConfigFile;
    _arr resize (count _arr - 15);
    toString _arr
};

Global_GameEnded=false;

Func_Common_AddHandlers       = compile preprocessFile ("common\Func_Common_AddHandlers.sqf");
Func_Common_HandleDamage      = compile preprocessFile ("common\Func_Common_HandleDamage.sqf");
Func_Common_DestroyUnitAward  = compile preprocessFile ("common\Func_Common_DestroyUnitAward.sqf");
Func_Common_PublicVariable    = compile preprocessFile ("common\Func_Common_PublicVariable.sqf");
Func_Common_SendRemoteCommand = compile preprocessFile ("common\Func_Common_SendRemoteCommand.sqf");

Func_Common_Spawn             = compile preprocessFile ("common\Func_Common_Spawn.sqf");



SMS_Func = {player globalChat str _this};
