_get_unit_text =
{
    _unit = _this select 0;
    _alpha = _this select 1;
    _group = group _unit;
    _tmpText = "";
        
    /*
    //_alpha_hex = [floor (0.5 * 255)] call convert_decimal_to_hex;
  
    //_alpha = 0.5;
    _alpha_hex = [floor(_alpha * 255)] call convert_decimal_to_hex;
    //_alpha_hex = "7f";
    _alpha_hex = format["%1", _alpha_hex];
    //player sidechat format["_alpha_hex: %1", _alpha_hex];
    
    //_alpha_hex = "";

    // _nameColor = "#" + _alpha_hex + "ffffff";
    _nameColor = format["#%1ffffff", _alpha_hex];
    
    if (side _x == west) then
    {
        //_nameColor = "#" + _alpha_hex + "3b8dd3";
        _nameColor = format["#%13b8dd3", _alpha_hex];
    };
    if (side _x == east) then {
        //_nameColor = "#" + _alpha_hex + "ff0000";
        _nameColor = format["#%1ff0000", _alpha_hex];
    };
    
    //_groupColor = "#" + _alpha_hex + "ffffff";
    _groupColor = format["#%1ffffff", _alpha_hex];
  
    //player sidechat format["_nameColor: %1, _groupColor: %2", _nameColor, _groupColor];
    */
    
    _nameColor = "#ccffffff";
    
    if (side _x == west) then
    {
        _nameColor = "#cc3b8dd3";
    };
    if (side _x == east) then {
        _nameColor = "#ccaa2211";
    };
    if (side _x == resistance) then {
        _nameColor = "#cc22bb11";
    };
    
    _groupColor = "#99ffffff";

    if (spectate_detailed_label_info) then
    {
        _tmpText = _tmpText + format["<t color='%1'>%2</t> <t color='%3'>(%4, Dam: %5)</t>", _nameColor, name _unit, _groupColor, _group, damage _unit];
    }
    else
    {
        _tmpText = _tmpText + "<t color='" + (_nameColor) + "'>" + (name _unit) + "</t>";
    };
    
    _tmpText;
};


_obj = _this select 0;
_alpha = _this select 1;

_lineCount = 0;
_tmpText = "";
_type = vehicle _obj;

// player sidechat format["label start"];

if (_type isKindOf "Car" ||
		_type isKindOf "StaticWeapon" ||
		_type isKindOf "Plane" ||
		_type isKindOf "Helicopter" ||
		_type isKindOf "Tank") then
{
	_vehicle = _obj;
	_name = getText(configFile >> "cfgVehicles" >> (typeOf _vehicle) >> "displayName");
	_tmpText = _tmpText + format["<t color='#ccffffff'>%1:</t><br/>", _name];
	_lineCount = 1;
	{
        if (alive _x) then
        {
            if (gunner _vehicle == _x) then {
                _tmpText = _tmpText + "<t color='#ccffffff'>G:</t> ";
            };
            if (driver _vehicle == _x) then {
                _tmpText = _tmpText + "<t color='#ccffffff'>D:</t> ";
            };
            if (commander _vehicle == _x) then {
                _tmpText = _tmpText + "<t color='#ccffffff'>C:</t> ";
            };

            _tmpText = _tmpText + ([_x, _alpha] call _get_unit_text) + "<br/>";
            _lineCount = _lineCount + 1;
        }
	} foreach (crew _vehicle);
}
else
{
    _tmpText = ([_obj, _alpha] call _get_unit_text);
	_lineCount = 1;
};

// player sidechat format["label end %1", _tmpText];

[_obj, parseText _tmpText, [], _lineCount, 0, false];
