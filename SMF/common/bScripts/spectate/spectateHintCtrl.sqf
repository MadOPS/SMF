#include "defines.inc"

disableSerialization;
_display = _this select 0;
_ctrl = _display displayCtrl SPECOVERLAY_HINT_IDC;

_ctrl ctrlSetText specHintMsg;
_ctrl ctrlCommit 0;
