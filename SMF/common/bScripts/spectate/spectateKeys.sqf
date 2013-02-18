spectate_handled_keys = [];

[DIK_F1, [false, false, false],
{
    if (!spectateHelpVisible) then {
        createDialog "spectateHelpRsc";
    }
    else {
        closeDialog 0;
    };
    true
}, "keydown", "Spec_help_dialog"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_help_dialog"];

[DIK_F2, [false, false, false],
{
    if (spectate_allow_quit) then
    {
        [] call spectate_end_mode;
    };
    true
}, "keydown", "Spec_end"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_end"];

[DIK_T, [false, false, false],
{
    spectate_show_tags = !spectate_show_tags;
    if (spectate_show_tags) then {
        //titleRsc ["spectateOverlayRsc", "PLAIN"];
        specHintMsg = "Tags enabled.";
        spectateUpdateNow = true;
    };
    if (!spectate_show_tags) then {
        //titleRsc ["Default", "PLAIN"];
        specHintMsg = "Tags disabled.";
    };
    3 cutRsc["spectateHintRsc", "PLAIN"];
    true
}, "keydown", "Spec_tags"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_tags"];

[DIK_PRIOR, [false, false, false],
{
    //player sideChat "prior";
    specCamFov = specCamFov + 0.05;
    if (specCamFov > 1.8) then { specCamFov = 1.8; };
    specCam camSetFov specCamFov;
    specCam camCommit 0;

    //specHintMsg = format["FOV: %1", specCamFov];
    //2 cutRsc["spectateHintRsc", "PLAIN"];
    2 cutText [format["FOV: %1", specCamFov], "PLAIN DOWN", 1.0];
    2 cutFadeOut 5.0;
    true
}, "keydown", "Spec_fov_up"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_fov_up"];

[DIK_NEXT, [false, false, false],
{
    specCamFov = specCamFov - 0.05;
    if (specCamFov < 0.2) then { specCamFov = 0.2; };
    specCam camSetFov specCamFov;

    2 cutText [format["FOV: %1", specCamFov], "PLAIN DOWN", 1.0];
    2 cutFadeOut 5.0;
    true
}, "keydown", "Spec_fov_down"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_fov_down"];

[DIK_SPACE, [false, false, false],
{
    if (!spectate_follow) then
    {
        if (!(isNull spectate_object)) then
        {
            [spectate_object] call spectate_enter_follow_mode;
        };
    }
    else
    {
        [] call spectate_leave_follow_mode;
    };
    true
}, "keydown", "Spec_switch_follow"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_switch_follow"];

[DIK_M, [false, false, false],
{
    if (!spectateHelpVisible) then
    {
        createDialog "FullScreenMapCtrl";
    }
    else
    {
        closeDialog 0;
    };

    true
}, "keydown", "Spec_fullmap"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_fullmap"];

[DIK_RIGHT, [false, false, false],
{
    _unit_list = [] call get_all_alive_players;
    
    _spectate_follow_index = ((_unit_list find spectate_object) + 1) % (count _unit_list);
    _new_spec_object = _unit_list select _spectate_follow_index;
    
    [_new_spec_object] call spectate_enter_follow_mode;

    true
}, "keydown", "Spec_next_player"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_next_player"];

[DIK_LEFT, [false, false, false],
{
    _unit_list = [] call get_all_alive_players;
    
    _spectate_follow_index = (_unit_list find spectate_object) - 1;
    
    if (_spectate_follow_index < 0) then
    {
        _spectate_follow_index = (count _unit_list) - 1;
    };
    
    [_unit_list select _spectate_follow_index] call spectate_enter_follow_mode;

    true
}, "keydown", "Spec_previous_player"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_previous_player"];

[DIK_V, [false, false, false],
{
    if (!spectate_follow) then
    {
        _unit = [getPos specCam] call get_closest_unit;
        
        if (!(isNull _unit)) then
        {
            [_unit] call spectate_enter_follow_mode;
        };
    }
    else
    {
        [] call spectate_leave_follow_mode;
    };

    true
}, "keydown", "Spec_closest_player"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["Spec_previous_player"];



/*********** Camera control *******/

/*********** forward **************/

[DIK_S, [false, false, false], {
    spectate_acceleration set [0, 0];
    spectate_speed        set [0, 0];
    true
}, "keyup", "SU"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["SU"];

[DIK_W, [false, false, false],
{
    spectate_acceleration set [0, 0];
    spectate_speed        set [0, 0];
    true
}, "keyup", "WU"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["WU"];

[DIK_S, [false, false, false],
{
    if (spectate_acceleration select 0 > -Spectate_acceleration_amount || spectate_acceleration select 0 < -Spectate_acceleration_amount) then
    {
        spectate_acceleration set [0, -Spectate_acceleration_amount];
        spectate_speed        set [0, -speed_magnitude];
        spectate_current_max_speed = Spectate_normal_max_speed;
    };
    true
}, "keydown", "SD"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["SD"];

[DIK_W, [false, false, false],
{
    if (spectate_acceleration select 0 < Spectate_acceleration_amount || spectate_acceleration select 0 > Spectate_acceleration_amount) then
    {
        spectate_acceleration set [0, Spectate_acceleration_amount];
        spectate_speed        set [0, speed_magnitude];
        spectate_current_max_speed = Spectate_normal_max_speed;
    };
    true
}, "keydown", "WD"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["WD"];

/*********** right **************/

[DIK_A, [false, false, false], {
    spectate_acceleration set [1, 0];
    spectate_speed        set [1, 0];
    true
}, "keyup", "AU"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["AU"];

[DIK_D, [false, false, false], {
    spectate_acceleration set [1, 0];
    spectate_speed        set [1, 0];
    true
}, "keyup", "DU"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["DU"];

[DIK_A, [false, false, false], {
    if (spectate_acceleration select 1 > -Spectate_acceleration_amount || spectate_acceleration select 0 < -Spectate_acceleration_amount) then
    {
        spectate_acceleration set [1, -Spectate_acceleration_amount];
        spectate_speed        set [1, -speed_magnitude];
        spectate_current_max_speed = Spectate_normal_max_speed;
    };
    true
}, "keydown", "AD"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["AD"];

[DIK_D, [false, false, false], {
    if (spectate_acceleration select 1 < Spectate_acceleration_amount || spectate_acceleration select 0 > Spectate_acceleration_amount) then
    {
        spectate_acceleration set [1, Spectate_acceleration_amount];
        spectate_speed        set [1, speed_magnitude];
        spectate_current_max_speed = Spectate_normal_max_speed;
    };
    true
}, "keydown", "DD"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["DD"];

/*********** up **************/

[DIK_Y, [false, false, false], {
    spectate_acceleration set [2, 0];
    spectate_speed        set [2, 0];
    true
}, "keyup", "YU"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["YU"];

[DIK_Z, [false, false, false], {
    spectate_acceleration set [2, 0];
    spectate_speed        set [2, 0];
    true
}, "keyup", "ZU"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["ZU"];

[DIK_Q, [false, false, false], {
    spectate_acceleration set [2, 0];
    spectate_speed        set [2, 0];
    true
}, "keyup", "QU"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["QU"];

[DIK_Y, [false, false, false], {
    if (spectate_acceleration select 2 > -Spectate_acceleration_amount || spectate_acceleration select 0 < -Spectate_acceleration_amount) then
    {
        spectate_acceleration set [2, -Spectate_acceleration_amount];
        spectate_speed        set [2, -speed_magnitude];
        spectate_current_max_speed = Spectate_normal_max_speed;
    };
    true
}, "keydown", "YD"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["YD"];

[DIK_Z, [false, false, false], {
    if (spectate_acceleration select 2 > -Spectate_acceleration_amount || spectate_acceleration select 0 < -Spectate_acceleration_amount) then
    {
        spectate_acceleration set [2, -Spectate_acceleration_amount];
        spectate_speed        set [2, -speed_magnitude];
        spectate_current_max_speed = Spectate_normal_max_speed;
    };
    true
}, "keydown", "ZD"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["ZD"];

[DIK_Q, [false, false, false], {
    if (spectate_acceleration select 2 < Spectate_acceleration_amount || spectate_acceleration select 0 > Spectate_acceleration_amount) then
    {
        spectate_acceleration set [2, Spectate_acceleration_amount];
        spectate_speed        set [2, speed_magnitude];
        spectate_current_max_speed = Spectate_normal_max_speed;
    };
    true
}, "keydown", "QD"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["QD"];

/************* SHIFT *************/

/*********** forward **************/

[DIK_S, [true, false, false], {
    spectate_acceleration set [0, 0];
    spectate_speed        set [0, 0];
    true
}, "keyup", "SUS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["SUS"];

[DIK_W, [true, false, false],
{
    spectate_acceleration set [0, 0];
    spectate_speed        set [0, 0];
    true
}, "keyup", "WUS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["WUS"];

[DIK_S, [true, false, false],
{
    if (spectate_acceleration select 0 > -Spectate_fast_acceleration_amount) then
    {
        spectate_acceleration set [0, -Spectate_fast_acceleration_amount];
        spectate_speed        set [0, -speed_magnitude];
        spectate_current_max_speed = Spectate_fast_max_speed;
    };
    true
}, "keydown", "SDS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["SDS"];

[DIK_W, [true, false, false],
{
    if (spectate_acceleration select 0 < Spectate_fast_acceleration_amount) then
    {
        spectate_acceleration set [0, Spectate_fast_acceleration_amount];
        spectate_speed        set [0, speed_magnitude];
        spectate_current_max_speed = Spectate_fast_max_speed;
    };
    true
}, "keydown", "WDS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["WDS"];

/*********** right **************/

[DIK_A, [true, false, false], {
    spectate_acceleration set [1, 0];
    spectate_speed        set [1, 0];
    true
}, "keyup", "AUS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["AUS"];

[DIK_D, [true, false, false], {
    spectate_acceleration set [1, 0];
    spectate_speed        set [1, 0];
    true
}, "keyup", "DUS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["DUS"];

[DIK_A, [true, false, false], {
    if (spectate_acceleration select 1 > -Spectate_fast_acceleration_amount) then
    {
        spectate_acceleration set [1, -Spectate_fast_acceleration_amount];
        spectate_speed        set [1, -speed_magnitude];
        spectate_current_max_speed = Spectate_fast_max_speed;
    };
    true
}, "keydown", "ADS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["ADS"];

[DIK_D, [true, false, false], {
    if (spectate_acceleration select 1 < Spectate_fast_acceleration_amount) then
    {
        spectate_acceleration set [1, Spectate_fast_acceleration_amount];
        spectate_speed        set [1, speed_magnitude];
        spectate_current_max_speed = Spectate_fast_max_speed;
    };
    true
}, "keydown", "DDS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["DDS"];

/*********** up **************/

[DIK_Y, [true, false, false], {
    spectate_acceleration set [2, 0];
    spectate_speed        set [2, 0];
    true
}, "keyup", "YUS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["YUS"];

[DIK_Z, [true, false, false], {
    spectate_acceleration set [2, 0];
    spectate_speed        set [2, 0];
    true
}, "keyup", "ZUS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["ZUS"];

[DIK_Q, [true, false, false], {
    spectate_acceleration set [2, 0];
    spectate_speed        set [2, 0];
    true
}, "keyup", "QUS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["QUS"];

[DIK_Y, [true, false, false], {
    if (spectate_acceleration select 2 > -Spectate_fast_acceleration_amount) then
    {
        spectate_acceleration set [2, -Spectate_fast_acceleration_amount];
        spectate_speed        set [2, -speed_magnitude];
        spectate_current_max_speed = Spectate_fast_max_speed;
    };
    true
}, "keydown", "YDS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["YDS"];

[DIK_Z, [true, false, false], {
    if (spectate_acceleration select 2 > -Spectate_fast_acceleration_amount) then
    {
        spectate_acceleration set [2, -Spectate_fast_acceleration_amount];
        spectate_speed        set [2, -speed_magnitude];
        spectate_current_max_speed = Spectate_fast_max_speed;
    };
    true
}, "keydown", "ZDS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["ZDS"];

[DIK_Q, [true, false, false], {
    if (spectate_acceleration select 2 < Spectate_fast_acceleration_amount) then
    {
        spectate_acceleration set [2, Spectate_fast_acceleration_amount];
        spectate_speed        set [2, speed_magnitude];
        spectate_current_max_speed = Spectate_fast_max_speed;
    };
    true
}, "keydown", "QDS"] call CBA_fnc_addKeyHandler;

spectate_handled_keys = spectate_handled_keys + ["QDS"];



/*
acceleration_keys = [
[DIK_W, 0,  1, "Forwards"],
[DIK_S, 0, -1, "Backwards"],
[DIK_D, 1,  1, "Right"],
[DIK_A, 1, -1, "Left"],
[DIK_Q, 2,  1, "Up"],
[DIK_Y, 2, -1, "Down"]];
    
for "_i" from 0 to (count _acceleration_keys) do
{   
    _entry = (_acceleration_keys select _i);
    _key  = _entry select 0;
    _axis = _entry select 1;
    _dir  = _entry select 2;
    _name = _entry select 3;
    
    [_key, [false, false, false], {
        player sidechat _name;
        spectate_acceleration set [_axis, 0];
        spectate_speed        set [_axis, 0];
        true
    }, "keyup", _name + "Up"] call CBA_fnc_addKeyHandler;

    [_key, [false, false, false], {
        if (spectate_forward_acceleration > -1) then
        {
            player sidechat _name;
            spectate_acceleration set [_axis, 10 * _dir];
            spectate_speed        set [_axis, speed_magnitude * _dir];
        };
        true
    }, "keydown", _name + "Down"] call CBA_fnc_addKeyHandler;
};
*/