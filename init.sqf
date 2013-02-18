// ============================================================================================
// Stinky Mission Frame Werk  - A Skunked up Way to Build Missions-
// Credits: For Usage please Visit (http://wiki.skunkwerksmods.com/index.php/Main_Page)

// ============================================================================================


setViewDistance 2000;
setTerrainGrid 50;
SMF_Mission_Version = 1.0;
SMF_QuickTest = false;
SMF_isServer = ((isDedicated) && (isServer));

#define __isServer ((isDedicated) && (isServer))


if (SMF_QuickTest) exitWith
{
     onMapSingleClick "vehicle player setPos _pos";
};

startLoadingScreen ["Initializing...", "RscDisplayStart"];

script = [] execVM "briefing.sqf";
waitUntil {scriptDone _script};












