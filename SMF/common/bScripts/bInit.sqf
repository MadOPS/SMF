if (!(isNull player) || (!isServer && isNull player)) then {
    // TODO: check if this is correct, if there is no respawn, this may have to be called here, since with no respawn,
    // for JIPers player may never become non-null

    while {isNull player} do { sleep 1.0; };

    _handle = [1000, 0.3, 0.5] execVM "bScripts\spectate\setupSpectate.sqf";
    waitUntil { ScriptDone _handle };
};