spectateDistance = _this select 0;
spectateTolerance = _this select 1;
spectateScale = _this select 2;
spectate_show_tags = false;
spectate_map_alpha = 1.0;
spectate_detailed_label_info = false;
spectateMax = 40; // Don't change, hardcoded resource


convert_decimal_to_hex = compile preprocessFileLineNumbers "bScripts\decimalToHex.sqf";
spectateMouseHandler = compile preprocessFileLineNumbers "bScripts\spectate\spectateMouseHandler.sqf";
spectateOverlayCtrl = compile preprocessFileLineNumbers "bScripts\spectate\spectateOverlayCtrl.sqf";
spectateLabelText = compile preprocessFileLineNumbers "bScripts\spectate\generateLabelText.sqf";
spectateUpdateObjects = compile preprocessFileLineNumbers "bScripts\spectate\updateObjects.sqf";
spectateUpdateLabels = compile preprocessFileLineNumbers "bScripts\spectate\updateLabels.sqf";
spectateHelpCtrl = compile preprocessFileLineNumbers "bScripts\spectate\spectateHelpCtrl.sqf";


spectate_setup_markers =
{
    // player sidechat "Generating map markers";
    spectate_marker_list = [];
    
    camera_marker_name = "CameraMarker";
    _camera_marker_str = createMarkerLocal[camera_marker_name, [(getPos specCam) select 0, (getPos specCam) select 1]];
    camera_marker_name setMarkerShapeLocal "ICON";
    camera_marker_name setMarkerTypeLocal "Arrow";
    camera_marker_name setMarkerColorLocal "ColorRed";
    _markerName setMarkerSizeLocal [1, 1];
    
    spectate_marker_list = spectate_marker_list + ["CameraMarker"];
    
    {
        _markerCol = "ColorWhite";

        if (side _x == west) then
        {
            _markerCol = "ColorBlue";
        };
        if (side _x == east) then
        {
            _markerCol = "ColorRed";
        };
        if (side _x == resistance) then
        {
            _markerCol = "ColorGreen";
        };

        // when units have identical names (seems to happen in different factions), this will create
        // the same marker again and overwrite the old one, usually not very important though
        _markerName = name _x;
        _markerstr = createMarkerLocal[_markerName, [(getPos _x) select 0, (getPos _x) select 1]];
        _markerName setMarkerShapeLocal "ICON";
        _markerName setMarkerTypeLocal "DOT";
        _markerName setMarkerTextLocal _markerName;
        _markerName setMarkerColorLocal _markerCol;
        _markerName setMarkerSizeLocal [1.0, 1.0];
        
        // save all created markers into a list for clean-up at the end
        spectate_marker_list = spectate_marker_list + [_markerName];
        
        _x addEventHandler ["killed", "\
            _unit = (_this select 0);\
            _marker_color = markerColor (name _unit);\
            deleteMarkerLocal (name _unit);\
            _dead_marker_name = name _unit;\
            createMarkerLocal[_dead_marker_name, [(getPos _unit) select 0, (getPos _unit) select 1]];\
            _dead_marker_name setMarkerShapeLocal 'ICON';\
            _dead_marker_name setMarkerTypeLocal 'Destroy';\
            _dead_marker_name setMarkerTextLocal _dead_marker_name;\
            _dead_marker_name setMarkerColorLocal _marker_color;\
            _dead_marker_name setMarkerSizeLocal [0.3, 0.3];\
            "];
    } foreach allUnits;
    
    spectate_map_marker_handler =
    [
        {
            {
                if (!(isNull _x) && alive _x) then
                {
                    _markerName = name _x;
                    _markerName setMarkerPosLocal [(getPos _x) select 0, (getPos _x) select 1];
                }
            } foreach allUnits;

            if (spectate_follow) then
            {
                camera_marker_name setMarkerColorLocal "ColorRed";
                camera_marker_name setMarkerPosLocal [(getPos spectate_object) select 0, (getPos spectate_object) select 1];
            }
            else
            {
                camera_marker_name setMarkerColorLocal "ColorGreen";
                camera_marker_name setMarkerPosLocal [(getPos specCam) select 0, (getPos specCam) select 1];
            };
            _rotation = direction specCam;
            camera_marker_name setMarkerDirLocal _rotation;
        },
        0.1,
        []
    ] call CBA_fnc_addPerFrameHandler;
};


follow_object =
{
    2 cutText [format["Internal Follow: %1 (Space or V to quit, LMB to change to external, RMB to toggle scope)", name spectate_object], "PLAIN DOWN", 1.0];
    2 cutFadeOut 8.0;
    // player sidechat "follow_object";
    specCam cameraEffect ["Terminate", "Back"];

    if ((vehicle spectate_object) != spectate_object) then
    {
        // unit is in a vehicle
        (vehicle spectate_object) switchCamera "Internal";
    }
    else
    {
        spectate_object switchCamera "Internal";
    };
    
    spectateUpdateNow = true;
    spectate_follow = true;
    spectate_view_type_own = false;
};

follow_object_own =
{
    2 cutText [format["External Follow: %1 (Space or V to quit, LMB to change to internal)", name spectate_object], "PLAIN DOWN", 1.0];
    2 cutFadeOut 8.0;
    specCamRelPos = [0, -10, 10];
    specCam = 'camera' camCreate (getPos spectate_object);
    specCam cameraEffect ["Internal", "Back"];
    specCam camSetFov specCamFov;
    specCam camCommit 0;
    
    spectateUpdateNow = true;
    spectate_follow = true;
    spectate_view_type_own = true;
};

create_normal_cam =
{
    2 cutText ["Free Camera", "PLAIN DOWN", 1.0];
    2 cutFadeOut 5.0;
    _pos = _this select 0;
    
    if (count _this > 1) then
    {
        _target = _this select 1;
        
        _dir = [_pos, _target] call BIS_fnc_vectorDiff;
        _dir = [_dir, 1] call CBA_fnc_scaleVectTo;
        
        _radius = 1;
        _phi    = (_dir select 1) atan2 (_dir select 0);
        _theta  = acos (_dir select 2);
        
        spectate_freelook_trackball = [
            _radius,
            _phi,
            _theta,
            0, 0];    
    };

    specCam = "camera" camCreate _pos;
    specCam cameraEffect ["Internal", "Back"];
    specCam camSetFov specCamFov;
    specCam camCommit 0;
    
    spectateUpdateNow = true;
    spectate_follow = false;
};

spectate_end_mode =
{
    // end spectate mode, remove all event handlers, resources, markers etc.
    titleRsc ["Default", "PLAIN"];

    terminate spectate_overlay_ctrl_handle;
    [follow_ev_handler]           call CBA_fnc_removePerFrameHandler;
    [spectate_overlay_ev_handler] call CBA_fnc_removePerFrameHandler;
    [spectate_map_marker_handler] call CBA_fnc_removePerFrameHandler;

    {
        [_x] call CBA_fnc_removeKeyHandler;
    } foreach spectate_handled_keys;
    
    {
        deleteMarkerLocal _x;
    } foreach spectate_marker_list;
    
    specCam cameraEffect ["Terminate", "Back"];
    player switchCamera "Internal";
};

get_all_alive_players =
{
    _unit_list = [];
    
    {
        //if (alive _x && isPlayer _x) then
        if (alive _x) then
        {
            _unit_list = _unit_list + [_x];
        };
    } foreach allUnits;
    
    _unit_list;
};

get_closest_unit =
{
    _pos = _this select 0;
    _unit = objNull;
   
    _closest_dist = 100000;
    {
        if (_pos distance _x < _closest_dist) then
        {
            _unit = _x;
            _closest_dist = _pos distance _x;
        };
    } foreach allUnits;
    
    _unit;
};

get_closest_player =
{
    _pos = _this select 0;
    _unit = objNull;
    
    _closest_dist = 100000;
    {
        if (_pos distance _x < _closest_dist) then
        {
            if (isPlayer _x) then
            {
                _unit = _x;
                _closest_dist = _pos distance _x;
            };
        };
    } foreach allUnits;
    
    _unit;
};

follow_closest_unit =
{
    _pos = _this select 0;
    _unit = [_pos] call get_closest_unit;
    
    if (!(isNull _unit)) then
    {
        [_unit] call spectate_enter_follow_mode;
    };
};

spectate_enter_follow_mode = 
{
    _obj = _this select 0;
    spectate_object = _obj;
    
    if (spectate_view_type_own) then
    {
        [] call follow_object_own;
    }
    else
    {
        [] call follow_object;
    };
};

spectate_leave_follow_mode =
{
    _spectate_vehicle = spectate_object;

    if (vehicle spectate_object != _spectate_vehicle) then
    {
        _spectate_vehicle = vehicle spectate_object;
    };
        
    if (spectate_view_type_own) then
    {
        _pos_spec_cam = _spectate_vehicle modelToWorld specCamRelPos;
        [_pos_spec_cam, getPos _spectate_vehicle] call create_normal_cam;
    }
    else
    {
        _pos_behind_object = _spectate_vehicle modelToWorld [0, -5, 2];
        [_pos_behind_object, getPos _spectate_vehicle] call create_normal_cam;
    };  
};