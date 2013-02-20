_objectLabels = [];

if (!spectate_show_tags) exitWith {
    _objectLabels;
};


// gather all objects of all sides which are either non-empty vehicles or persons,
// generate labels for them and return the list of labels

_maxDistance = spectateDistance;

_possibleVehicles = ["Man", "Car", "Tank", "StaticWeapon", "Helicopter", "Plane"];

_worldPos = positionCameraToWorld [0, 0, 0];

// _objects = nearestObjects [_worldPos, _possibleVehicles, _maxDistance];

_objects = _worldPos nearEntities [_possibleVehicles, _maxDistance];

_i = 0;

{
    if (alive _x && count (crew _x) > 0 && ((side _x) in [west, east, resistance, civilian, sideEnemy])) then {
        _objLabel = [_x, 0.5] call spectateLabelText;
        _objectLabels set [_i, _objLabel];
        _i = _i + 1;
    };
} foreach _objects;

_objectLabels;
