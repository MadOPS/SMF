#include "defines.inc"

// init for the spec help dialog

_colorWest = [0.3, 0.5, 0.8, 1.0];
_colorWestPlayer = [0.3, 0.6, 1.0, 1.0];
_colorEast = [0.8, 0.4, 0.4, 1.0];
_colorEastPlayer = [0.9, 0.2, 0.2, 1.0];
_colorResist = [0.5, 0.8, 0.4, 1.0];
_colorResistPlayer = [0.6, 0.9, 0.5, 1.0];
_colorElse = [0.7, 0.7, 0.7, 1.0];
_colorElsePlayer = [1, 1, 1, 1.0];


        
spectateHelpVisible = true;

spectatePlayers = [];

_display = _this select 0;

// slider init

_ctrl = _display displayCtrl SPECTAGSDIST_IDC;
_ctrl sliderSetRange [200, 2000];
_ctrl sliderSetPosition spectateDistance;
_ctrl ctrlCommit 0;

/*
_ctrl = _display displayCtrl SPEC_MAP_ALPHA_IDC;
_ctrl sliderSetRange [0, 1000];
_ctrl sliderSetPosition (spectate_map_alpha * 1000);
_ctrl ctrlCommit 0;

_ctrl = _display displayCtrl SPECFOCUS_IDC;
_ctrl sliderSetRange [-1, 1000];
_ctrl sliderSetPosition specCamFocus;
_ctrl ctrlCommit 0;

_ctrl = _display displayCtrl SPECBLUR_IDC;
_ctrl sliderSetRange [-1, 1000];
_ctrl sliderSetPosition specCamBlur;
_ctrl ctrlCommit 0;
*/

_ctrl = _display displayCtrl SPEC_PLAYERCOMBO_IDC;

// player list combo box: first add all human players, then all AI
{
	if (alive _x && isPlayer _x) then
    {
		_col = _colorElsePlayer;
		if (side _x == west) then
        {
			_col = _colorWestPlayer;
		};
		if (side _x == east) then
        {
			_col = _colorEastPlayer;
		};
		if (side _x == resistance) then
        {
			_col = _colorResistPlayer;
		};
		spectatePlayers set [count spectatePlayers, _x];
		_idx = _ctrl lbAdd (name _x);
		_ctrl lbSetColor [_idx, _col];
	};
} foreach allUnits;

{
	if (alive _x && !(isPlayer _x)) then {
		_col = _colorElse;
		if (side _x == west) then {
			_col = _colorWest;
		};
		if (side _x == east) then {
			_col = _colorEast;
		};
		if (side _x == resistance) then {
			_col = _colorResist;
		};

		spectatePlayers set [count spectatePlayers, _x];
		_idx = _ctrl lbAdd (name _x);
		_ctrl lbSetColor [_idx, _col];
	};
} foreach allUnits;

_ctrl = _display displayCtrl SPEC_MAP_IDC;
_scale = ctrlMapScale _ctrl;
_worldPos = getPos specCam;
_ctrl ctrlMapAnimAdd [0, _scale, _worldPos];
ctrlMapAnimCommit _ctrl;