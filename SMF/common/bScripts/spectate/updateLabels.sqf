_labels = [];

if (!spectate_show_tags) exitWith {
    _labels;
};

// update the labels positions

_tolerance = spectateTolerance;
_maxDistance = spectateDistance;

_objectLabels = _this select 0;

_i = 0;
_shownObjects = 0;
_objCount = count _objectLabels;
_cam_position = positionCameraToWorld [0, 0, 0];

// for every friendly object in _distanceMax distance, check how
// much the player is looking at it

while { (_shownObjects < spectateMax) && (_i < _objCount) } do
{
    _objLabel = _objectLabels select _i;
    _obj = _objLabel select 0;
    _objPos = getPos _obj;

    _bb = boundingBox _obj;

    // move the z ordinate to the middle of the BB
    // but 1m at most, so the position of tags is in
    // the object's center or lower
    _bbZMin = (_bb select 0) select 2;
    _bbZMax = (_bb select 1) select 2;
    _bbZDiff = (_bbZMax - _bbZMin) / 2.0;

    _bbZDiff = 1 min _bbZDiff;
    
    _objPos set [2, (_objPos select 2) + _bbZDiff];
    _scrPos = worldToScreen _objPos;

    if (count _scrPos == 2) then
    {
        _scrX = _scrPos select 0;
        _scrY = _scrPos select 1;
        if (_scrX < SafeZoneW && _scrX > SafeZoneX && _scrY < SafeZoneH && _scrY > SafeZoneY) then
        {
            // non-linear scale modulator
            _objDist = _cam_position distance _obj;
            _normalized_dist = (_objDist / _maxDistance);
            _objDistMod = 1 min ((1 - _normalized_dist) * (1 - _normalized_dist) + 0.2);

                _objLabel set [2, _scrPos];
                _objLabel set [4, _objDistMod];
                _labels set [_shownObjects, _objLabel];
                _shownObjects = _shownObjects + 1;
        };
    };
    _i = _i + 1;
};

 _labels;