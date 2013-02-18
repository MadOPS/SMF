_decimal_to_hex_map = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"];

_decimal = _this select 0;
_single = (_decimal < 16);
_hex = "";

_i = 0;
while { _decimal > 0 } do
{
    _h_i = floor (_decimal mod 16);
    _h_i = 0 max _h_i;
    _h_i = 15 min _h_i;
    _decimal = floor ((_decimal - _h_i) / 16);
    _hex = (_decimal_to_hex_map select _h_i) + _hex;
    _i = _i + 1;
};

if (_single) then
{
    _hex = "0" + _hex;
};

_hex;
