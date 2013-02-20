#include "\ca\editor\Data\Scripts\dikCodes.h"

#include "defines.inc"


_type = _this select 0;
_speed = 0.5;

_handled = false;

if (_type == "mouse" && !spectateHelpVisible) then
{
    _params = _this select 1;
    _ctrl = _params select 0;
    _x = _params select 1;
    _y = _params select 2;
    
    /*
    for "_i" from 0 to (count _params) - 1 do
    {
        player sidechat format["i: %1", _params select _i];
    };
    */

    _distMod = 0.5 * _speed;
    
    // player sidechat format["mouse move x: %1, y: %2", _x, _y];

    if (spectate_follow && spectate_view_type_own) then
    {
        _phi   =  (specFollowTrackball select 1);
        _phi   = _phi - _x * _distMod;
        _theta =  (specFollowTrackball select 2);
        _theta = _theta + _y * 2.0 * _distMod;
        
        _theta = _theta min 85;
        _theta = _theta max 5;

        specFollowTrackball set [1, _phi];
        specFollowTrackball set [2, _theta];
    };
    
    if (!spectate_follow) then
    {
        spectate_freelook_trackball set [3, _x];
        spectate_freelook_trackball set [4, _y];
    };
};

if (_type == "mouseDown" && !spectateHelpVisible) then
{
	_params = _this select 1;
    
	_ctrl   = _params select 0;
    _button = _params select 1;
	_x      = _params select 2;
	_y      = _params select 3;
    
    /*
    _i = 0;
    for "_i" from 0 to (count _params) - 1 do
    {
        player sidechat format["i: %1", _params select _i];
    };
    */

    if (_button == 0) then
    {
        if (spectate_follow) then
        {
            if (spectate_view_type_own) then
            {
                [] call follow_object;
            }
            else
            {
                [] call follow_object_own;
            };
        };
    };
    
    _handled = true;
};

if (_type == "mouseWheel" && !spectateHelpVisible) then
{
	_params = _this select 1;
	_dir = _params select 1;
	//player sideChat format["wheel: %1, %2", _params, _dir];

	_distMod = 1.0 * _speed;

	if (spectate_follow && spectate_view_type_own) then
    {
        _radius = specFollowTrackball select 0;
        _radius = _radius + _distMod * _dir;
        _radius = _radius max 0.5;
        specFollowTrackball set [0, _radius];
	};
    
    _handled = true;
};

_handled;