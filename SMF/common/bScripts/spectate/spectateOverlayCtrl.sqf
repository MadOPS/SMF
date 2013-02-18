#include "defines.inc"

spectate_overlay_ctrl_handle = [(_this select 0)] spawn
{
	private ['_display', '_ctrl'];
	disableSerialization;
	_display = (_this select 0);

	_ctrls = [];
	_i = 0;
	while { _i < spectateMax } do {
		_ctrls set [_i, _display displayCtrl (SPECOVERLAY_TAG0_IDC + _i)];
		_i = _i + 1;
	};

    spectate_overlay_ctrls = _ctrls;
    spectate_object_labels = [];
    spectate_last_lable_update = -5;
    
    spectate_overlay_ev_handler =
    [
        {
            _overlayWidth = 0.9;
            
            _ctrls = spectate_overlay_ctrls;

            // regenerate the list of objects/labels to display every 5 seconds
            // only, but update the labels' positions at every frame to make it
            // somewhat smooth looking
            
            if (time - spectate_last_lable_update > 5 || spectateUpdateNow) then
            {
                spectate_object_labels = [] call spectateUpdateObjects;
                spectate_last_lable_update = time;
                spectateUpdateNow = false;
            };

            //_objectLabels = [] call spectateUpdateObjects;
            //_spectateUnitsText = [_objectLabels] call spectateUpdateLabels;
            _spectateUnitsText = [spectate_object_labels] call spectateUpdateLabels;
            
            _i = 0;
            _spectateUnitsCount = count _spectateUnitsText;
                  
            while {_i < _spectateUnitsCount} do
            {
                // move backwards through the list because closer units are at the front (painter's algorithm)
                // only necessary when using partially opaque backgrounds
                _unit_index = _spectateUnitsCount - _i - 1;
                
                _spectate_unit = _spectateUnitsText select _unit_index;

                _tmpText   = _spectate_unit select 1;
                _scrPos    = _spectate_unit select 2;
                _lineCount = _spectate_unit select 3;
                _distMod   = _spectate_unit select 4;

                // left corner, must be set so the box will be centered on scrPos.x
                _scrPos set [0, (_scrPos select 0) - _overlayWidth * spectateScale * _distMod / 2.0];
                // overlay box width
                _scrPos set [2, _overlayWidth];
                // overlay box height
                _scrPos set [3, (0.005 + 0.06 * _lineCount)];

                _ctrl = _ctrls select _i;

                _ctrl ctrlSetBackgroundColor [1, 1, 1, 0];
                _ctrl ctrlSetScale (spectateScale * _distMod);
                _ctrl ctrlSetStructuredText _tmpText;
                _ctrl ctrlSetPosition _scrPos;
                _ctrl ctrlCommit 0;
                _ctrl ctrlShow true;
                _i = _i + 1;
            };

            // disable all non-used labels
            while {_i < spectateMax} do
            {
                _ctrl = _ctrls select _i;
                _ctrl ctrlShow false;
                _i = _i + 1;
            };
        },
        0.04,
        []
    ] call CBA_fnc_addPerFrameHandler;
    
};


