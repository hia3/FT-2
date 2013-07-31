
_msg = _this select 0;
_arg = _this select 1;
_tgt = _this select 2;

[[_msg, _arg], "Func_Client_ReadRemoteMessages", _tgt, false] spawn BIS_fnc_MP;
