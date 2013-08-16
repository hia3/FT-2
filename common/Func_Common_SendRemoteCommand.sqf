
_msg = _this select 0;
_arg = _this select 1;
_tgt = _this select 2;

[BIS_fnc_MP, [[_msg, _arg], "Func_Client_ReadRemoteMessages", _tgt, false]] call Func_Common_Spawn;
