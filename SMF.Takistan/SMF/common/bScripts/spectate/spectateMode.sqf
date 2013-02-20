#include "\ca\editor\Data\Scripts\dikCodes.h"

_initial_camera_object = nullObj;

sleep 1.0;

spectate_allow_quit = false;
if (count _this > 3) then
{
    _args = _this select 3;
    spectate_allow_quit = _args select 0;
    _initial_camera_object = player;
}
else
{
    _initial_camera_object = _this select 0;
    sleep 5.0;
};

enableEndDialog;

showCinemaBorder false;

spectate_object = objNull;
spectate_follow = false;

spectateHelpVisible = false;
spectate_show_tags = true;
specCamFov = 0.7;
specCamBlur = -1;
specCamFocus = -1;
spectateUpdateNow = false;

spectate_view_type_own = false; // spec follow type
specFollowTrackball = [10, 0, 45]; // radius, phi, theta

spectate_freelook_trackball = [1, 0, 90, 0, 0]; // unit radius, phi, theta, (x,y) mouse movement

end_script = false;

#define Spectate_acceleration_amount        5
#define Spectate_fast_acceleration_amount 100
#define Spectate_normal_max_speed  30
#define Spectate_fast_max_speed   300


spectate_current_max_speed = Spectate_normal_max_speed;
speed_magnitude = 0;

spectate_speed        = [0, 0, 0]; // forward, right, up
spectate_acceleration = [0, 0, 0];


(findDisplay 46) displayAddEventHandler ["MouseMoving", "['mouse', _this] call spectateMouseHandler"];
(findDisplay 46) displayAddEventHandler ["MouseZChanged", "['mouseWheel', _this] call spectateMouseHandler"];
(findDisplay 46) displayAddEventHandler ["MouseButtonDown", "['mouseDown', _this] call spectateMouseHandler"];

#include "spectateKeys.sqf"

_cam_pos = _initial_camera_object modelToWorld [0, -6, 2];
[_cam_pos, getPos _initial_camera_object] call create_normal_cam;

[] call spectate_setup_markers;

titleRsc ["spectateOverlayRsc", "PLAIN"];

specHintMsg = "Press F1 for help.";
3 cutRsc["spectateHintRsc", "PLAIN"];

spectate_last_frame = time;


follow_ev_handler = [
    {
        _frame_duration = time - spectate_last_frame;
        spectate_last_frame = time;
        if (spectate_follow && spectate_view_type_own) then
        {
            _radius = specFollowTrackball select 0;
            _phi    = specFollowTrackball select 1;
            _theta  = specFollowTrackball select 2;
            specCamRelPos set [0, _radius * sin _theta * cos _phi];
            specCamRelPos set [1, _radius * sin _theta * sin _phi];
            specCamRelPos set [2, _radius * cos _theta];
        
            if ((vehicle spectate_object) != spectate_object) then
            {
                // unit is in a vehicle
                specCam camSetTarget (vehicle spectate_object);
            }
            else
            {
                specCam camSetTarget spectate_object;
            };
            
            specCam camSetRelPos specCamRelPos;
            specCam camCommit 0;
        };
        
        if (!spectate_follow) then
        {
            acceleration_factor = 2.0;
            
            _max_speed_axis = -1;
            _max_speed      = 0;
            for "_i" from 0 to 2 do
            {
                if (spectate_speed select _i > _max_speed) then
                {
                    _max_speed_axis = _i;
                    _max_speed      = spectate_speed select _i;
                };
            };
            /*
            _current_speed_vector = [
                spectate_accelerate_forward_speed,
                spectate_accelerate_right_speed,
                spectate_accelerate_up_speed];
            _current_speed_vector = [_current_speed_vector, speed_magnitude] call CBA_fnc_scaleVectTo;
        
            spectate_accelerate_forward_speed = _current_speed_vector select 0;
            spectate_accelerate_right_speed   = _current_speed_vector select 1;
            spectate_accelerate_up_speed      = _current_speed_vector select 2;
            */
        
            // apply the acceleration to the current speed
            for "_i" from 0 to 2 do
            {
                spectate_speed set [_i, (spectate_speed select _i) + (spectate_acceleration select _i) * _frame_duration * acceleration_factor];
            };
            
            if (([0,0,0] distance spectate_speed) > spectate_current_max_speed) then
            {
                spectate_speed = [spectate_speed, spectate_current_max_speed] call CBA_fnc_scaleVectTo;
            };

            _current_height = (getPos specCam) select 2;
            
            // calc final motion vector in camera space
            _motion_vector_camera = [
                (spectate_speed select 1) * _frame_duration,
                (spectate_speed select 0) * _frame_duration,
                0];
               
            // transform into world space and move camera
            _new_pos_world = specCam modelToWorld _motion_vector_camera;
            _new_pos_world set [2, _current_height + (spectate_speed select 2) * _frame_duration];
            if (_new_pos_world select 2 < 0) then
            {
                _new_pos_world set [2, 0];
            };
            
            // orientation
            _cam_space_target = [];
            
            _x = (spectate_freelook_trackball select 3);
            _y = (spectate_freelook_trackball select 4);
            
            _phi   = (spectate_freelook_trackball select 1);
            _theta = (spectate_freelook_trackball select 2);
            
            _phi   = _phi   - _x * 40.0 * _frame_duration;
            _theta = _theta + _y * 40.0 * _frame_duration;
            
            _theta = _theta min 175;
            _theta = _theta max 5;

            _cam_space_target set [0, 1 * sin _theta * cos _phi];
            _cam_space_target set [1, 1 * sin _theta * sin _phi];
            _cam_space_target set [2, 1 * cos _theta];

            spectate_freelook_trackball set [1, _phi];
            spectate_freelook_trackball set [2, _theta];

            _world_space_target = [_new_pos_world, _cam_space_target] call BIS_fnc_vectorAdd;
            
            // correct for ASL shit crap
            _asl_target  = getTerrainHeightASL [_world_space_target select 0, _world_space_target select 1];
            _asl_new_pos = getTerrainHeightASL [_new_pos_world      select 0, _new_pos_world      select 1];
            _world_space_target set [2, (_world_space_target select 2) - (_asl_target - _asl_new_pos)];

            specCam camSetPos    _new_pos_world;
            specCam camSetTarget _world_space_target;
            specCam camCommit 0;
            
            
            //player sidechat format["%1 %2 %3", spectate_accelerate_forward, spectate_accelerate_forward_speed, _frame_duration];
            //player sidechat format["%1", _cam_space_target];
            
            speed_magnitude = [0, 0, 0] distance spectate_speed;
        };
    },
    0,
    []
] call CBA_fnc_addPerFrameHandler;
