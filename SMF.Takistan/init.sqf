// ============================================================================================
// Stinky Mission Frame Werk  - A Skunked up Way to Build Missions-
// Credits: For Usage please Visit (http://wiki.skunkwerksmods.com/index.php/Main_Page)
// ============================================================================================

setViewDistance 2000;
setTerrainGrid 50;
SMF_Mission_Version = 1.0;

// ============================================================================================
SMF_QuickTest = false;
SMF_ACRE = false;
SMF_ACE = false;
SMF_Customloadouts = false;

// ============================================================================================
SMF_PlayableFaction_Bluefore = false;
SMF_PlayableFaction_Independant = false;
SMF_PlayableFaction_Opfore = false;
SMF_PlayableFaction_Civilian = false;

// ============================================================================================

SMF_isServer = ((isDedicated) && (isServer));

#define __isServer ((isDedicated) && (isServer))

// ============================================================================================

if (SMF_QuickTest) exitWith
{
     onMapSingleClick "vehicle player setPos _pos";
};

if (SMF_ACRE) exitWith
{
  script = [] execVM "\SMF\common\acrecompile.sqf";   
};

if (SMF_ACE) exitWith
{
  script = [] execVM "\SMF\common\acecompile.sqf";   
};

if (SMF_Customloadouts) exitWith
{
  script = [] execVM "\SMF\common\loadouts.sqf";   
};


// ============================================================================================

if (SMF_PlayableFaction_Bluefore) exitWith
{
  script = [] execVM "\SMF\common\fac\bluefore.sqf";   
};

if (SMF_PlayableFaction_Independant) exitWith
{
  script = [] execVM "\SMF\common\fac\indi.sqf";   
};


if (SMF_PlayableFaction_Opfore) exitWith
{
  script = [] execVM "\SMF\common\fac\opfore.sqf";   
};


if (SMF_PlayableFaction_Civilian) exitWith
{
  script = [] execVM "\SMF\common\fac\civi.sqf";   
};

// ============================================================================================



startLoadingScreen ["Initializing...", "RscDisplayStart"];

script = [] execVM "briefing.sqf";
waitUntil {scriptDone _script};












