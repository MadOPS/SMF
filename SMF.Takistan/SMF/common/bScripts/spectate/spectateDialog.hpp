#include "defines.inc"

#define CT_STATIC 0
#define CT_SLIDER 3
#define CT_COMBO 4
#define CT_LISTBOX 5
#define ST_LEFT 0
#define ST_CENTER 2
#define CT_STRUCTURED_TEXT 13
#define FontM "TahomaB"

#define COLOR_BRIGHT { 0.4, 0.55, 0.4, 0.5 }
#define COLOR_DARK { 0.2, 0.26, 0.2, 0.7 }


#define ST_FRAME 64

#define CT_BUTTON 1

// Slider styles
#define SL_DIR 0x400
#define SL_VERT 0
#define SL_HORZ 0x400

#define CT_MAP_MAIN 101
#define ST_PICTURE 48

class RscText {
    idc = -1;
    type = CT_STATIC;
    style = ST_LEFT;
    text = "";
    access = 0;
    font = FontM;
    sizeEx = 0.023;
    size = 0.06;
    color[] = { 1, 1, 1, 1 };
    coloractive[] = { 1, 0, 0, 0.5 };
    colorBackground[] = { 0, 0, 0, 0 };
    colorText[] = {1, 0, 0, 1};

    x = 0;
    y = 0;
    w = 0;
    h = 0;
};

class RscMapControl {
	access = 0;
	idc = -1;
	type = CT_MAP_MAIN;
	style = ST_PICTURE;

	x = 0.10;
	y = 0.10;
	w = 0.80;
	h = 0.60;

	colorBackground[] = {1.00, 1.00, 1.00, 1.0};
	colorText[] = {0.00, 0.00, 0.00, 1.00};
	colorSea[] = {0.56, 0.80, 0.98, 0.50};
	colorForest[] = {0.60, 0.80, 0.20, 0.50};
	colorRocks[] = {0.50, 0.50, 0.50, 0.50};
	colorCountlines[] = {0.65, 0.45, 0.27, 0.50};
	colorMainCountlines[] = {0.65, 0.45, 0.27, 1.00};
	colorCountlinesWater[] = {0.00, 0.53, 1.00, 0.50};
	colorMainCountlinesWater[] = {0.00, 0.53, 1.00, 1.00};
	colorForestBorder[] = {0.40, 0.80, 0.00, 1.00};
	colorRocksBorder[] = {0.50, 0.50, 0.50, 1.00};
	colorPowerLines[] = {0.00, 0.00, 0.00, 1.00};
	colorNames[] = {0.00, 0.00, 0.00, 1.00};
	colorInactive[] = {1.00, 1.00, 1.00, 0.50};
	colorLevels[] = {0.00, 0.00, 0.00, 1.00};

	font = "TahomaB";
	sizeEx = 0.040000;

	fontLabel = "TahomaB";
	sizeExLabel = 0.02;
	fontGrid = "TahomaB";
	sizeExGrid = 0.02;
	fontUnits = "TahomaB";
	sizeExUnits = 0.02;
	fontNames = "TahomaB";
	sizeExNames = 0.05;
	fontInfo = "TahomaB";
	sizeExInfo = 0.02;
	fontLevel = "TahomaB";
	sizeExLevel = 0.02;

	maxSatelliteAlpha = 0;
	alphaFadeStartScale = 0;
	alphaFadeEndScale = 0;

	colorOutside[] = { 0, 0, 0, 0 };
	colorRailway[] = { 0, 0, 0, 0 };
	stickX[] = {0.20, {"Gamma", 1.00, 1.50} };
	stickY[] = {0.20, {"Gamma", 1.00, 1.50} };
	ptsPerSquareSea = 6;
	ptsPerSquareTxt = 8;
	ptsPerSquareCLn = 8;
	ptsPerSquareExp = 8;
	ptsPerSquareCost = 8;
	ptsPerSquareFor = "4.0f";
	ptsPerSquareForEdge = "10.0f";
	ptsPerSquareRoad = 2;
	ptsPerSquareObj = 10;

	text = "\ca\ui\data\map_background2_co.paa";
	showCountourInterval=2;
	scaleDefault = 1.0;
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";


	class ActiveMarker {
		color[] = {0.30, 0.10, 0.90, 1.00};
		size = 50;
	};
	class Bunker {
		icon = "\ca\ui\data\map_bunker_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4.00;
	};
	class Bush {
		icon = "\ca\ui\data\map_bush_ca.paa";
		color[] = {0.55, 0.64, 0.43, 1.00};
		size = 14;
		importance = "0.2 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4.00;
	};
	class BusStop {
		icon = "\ca\ui\data\map_busstop_ca.paa";
		color[] = {0.00, 0.00, 1.00, 1.00};
		size = 10;
		importance = "1 * 10 * 0.05";
		coefMin = 0.25;
		coefMax = 4.00;
	};
	class Command {
		icon = "#(argb,8,8,3)color(1,1,1,1)";
		color[] = {0.00, 0.00, 0.00, 1.00};
		size = 18;
		importance = 1.00;
		coefMin = 1.00;
		coefMax = 1.00;
	};
	class Cross {
		icon = "\ca\ui\data\map_cross_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 16;
		importance = "0.7 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4.00;
	};
	class Fortress {
		icon = "\ca\ui\data\map_bunker_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4.00;
	};
	class Fuelstation {
		icon = "\ca\ui\data\map_fuelstation_ca.paa";
		color[] = {1.00, 0.35, 0.35, 1.00};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.75;
		coefMax = 4.00;
	};
	class Fountain {
		icon = "\ca\ui\data\map_fountain_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 12;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4.00;
	};
	class Hospital {
		icon = "\ca\ui\data\map_hospital_ca.paa";
		color[] = {0.78, 0.00, 0.05, 1.00};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.50;
		coefMax = 4;
	};
	class Chapel {
		icon = "\ca\ui\data\map_chapel_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.90;
		coefMax = 4.00;
	};
	class Church {
		icon = "\ca\ui\data\map_church_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.90;
		coefMax = 4.00;
	};
	class Lighthouse {
		icon = "\ca\ui\data\map_lighthouse_ca.paa";
		color[] = {0.78, 0.00, 0.05, 1.00};
		size = 20;
		importance = "3 * 16 * 0.05";
		coefMin = 0.90;
		coefMax = 4.00;
	};
	class Quay {
		icon = "\ca\ui\data\map_quay_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.50;
		coefMax = 4.00;
	};
	class Rock {
		icon = "\ca\ui\data\map_rock_ca.paa";
		color[] = {0.35, 0.35, 0.35, 1.00};
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4.00;
	};
	class Ruin {
		icon = "\ca\ui\data\map_ruin_ca.paa";
		color[] = {0.78, 0.00, 0.05, 1.00};
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1.00;
		coefMax = 4.00;
	};
	class Stack {
		icon = "\ca\ui\data\map_stack_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.90;
		coefMax = 4.00;
	};
	class Tree {
		icon = "\ca\ui\data\map_tree_ca.paa";
		color[] = {0.55, 0.64, 0.43, 1.00};
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4.00;
	};
	class SmallTree {
		icon = "\ca\ui\data\map_smalltree_ca.paa";
		color[] = {0.55, 0.64, 0.43, 1.00};
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4.00;
	};
	class Tourism {
		icon = "\ca\ui\data\map_tourism_ca.paa";
		color[] = {0.78, 0.00, 0.05, 1.00};
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.70;
		coefMax = 4.00;
	};
	class Transmitter {
		icon = "\ca\ui\data\map_transmitter_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.90;
		coefMax = 4.00;
	};
	class ViewTower {
		icon = "\ca\ui\data\map_viewtower_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.50;
		coefMax = 4.00;
	};
	class Watertower {
		icon = "\ca\ui\data\map_watertower_ca.paa";
		color[] = {0.00, 0.35, 0.70, 1.00};
		size = 32;
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.90;
		coefMax = 4.00;
	};
	class Waypoint {
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		color[] = {0.00, 0.00, 0.00, 1.00};
		size = 24;
		importance = 1.00;
		coefMin = 1.00;
		coefMax = 1.00;
	};
	class WaypointCompleted {
		icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
		color[] = {0.00, 0.00, 0.00, 1.00};
		size = 24;
		importance = 1.00;
		coefMin = 1.00;
		coefMax = 1.00;
	};

	class CustomMark {
		icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
		color[] = {0.00, 0.00, 0.00, 1.00};
		size = 24;
		importance = 1.00;
		coefMin = 1.00;
		coefMax = 1.00;
	};

    class Task {
            icon = "\ca\ui\data\map_waypoint_ca.paa";
            iconCreated = "#(argb,8,8,3)color(1,1,1,1)";
            iconCanceled = "#(argb,8,8,3)color(0,0,1,1)";
            iconDone = "#(argb,8,8,3)color(0,0,0,1)";
            iconFailed = "#(argb,8,8,3)color(1,0,0,1)";
            colorCreated[] = {1,1,1,1};
            colorCanceled[] = {1,1,1,1};
            colorDone[] = {1,1,1,1};
            colorFailed[] = {1,1,1,1};
            size = 20;
            color[] = {0, 0.900000, 0, 1};
            importance = "1.2 * 16 * 0.05";
            coefMin = 0.900000;
            coefMax = 4;
     };
};

class BackgroundHelp {
	idc = -1;   // set to -1, unneeded
	type = CT_STATIC;   // constant
	style = ST_LEFT;   // constant
	text = "";
	font = FontM;
	sizeEx = 0.023;

	colorBackground[] = COLOR_DARK;
	colorText[] = { 0, 0, 0, 1 };

	x = SafeZoneX + 0.1;
	y = SafeZoneY + 0.1;
	w = SafeZoneW - 0.2;
	h = SafeZoneH - 0.2;
};

class SpecText {
	type = CT_STRUCTURED_TEXT;
	style = ST_CENTER;
	text = "";
	access = 0;
	font = FontM;
	sizeEx = 0.023;
	size = 0.06;

	colorBackground[] = { 1, 1, 1, 0.2 };
	colorText[] = { 0, 0, 0, 1 };

	x = 0;
	y = 0;
	w = 0;
	h = 0;

	class Attributes {
		font = "TahomaB";
		color = "#FFFFFF";
		align = "center";
		valign = "middle";
		shadow = 1;
		shadowColor = "#000000"; 
		size = "1";
	};
};

class ListBoxRsc {
	idc = -1;
	type = CT_LISTBOX;
	style = ST_LEFT;

	x = 0.1;
	y = 0.1;
	w = 0.2;
	h = 0.3;

	font = FontM;
	sizeEx = 0.025;

	rowHeight = 0.025;
	wholeHeight = 4 * 0.025; // 3 lines to display + 1 line of the unelapsed control

	color[] = {1,1,1,1};
	colorText[] = {0,0,0,1};
	colorBackground[] = {1,1,1,1};
	colorSelect[] = {1,0,0,1};
	colorSelectBackground[] = {0,1,0,1};

	soundSelect[] = {"", 0.0, 1};
	soundExpand[] = {"", 0.0, 1};
	soundCollapse[] = {"", 0.0, 1};
	scrollBar = true;
	autoScrollRewind = false;
	autoScrollDelay = 0;
	autoScrollSpeed = 0;
	maxHistoryDelay = 1;
};

class FullScreenMapCtrl {
	idd = SPEC_FULLMAP_IDD;
	movingEnable = 1;
	fadein = 1.0;
	fadeout = 5.0;
	duration = 10.0;
	access = 0;
    
    onLoad   = "spectateHelpVisible = true;\
        _ctrl = (_this select 0) displayCtrl SPEC_FULLMAP_IDC;\
        _scale = ctrlMapScale _ctrl;\
        _worldPos = getPos specCam;\
        _ctrl ctrlMapAnimAdd [0, _scale, _worldPos];\
        ctrlMapAnimCommit _ctrl;";
    onUnload = "spectateHelpVisible = false;";

    class objects
    {
	};
    
	class controlsBackground
    {
	};
    
    class controls
    {
        class MapCtrl : RscMapControl
        {
            idc = SPEC_FULLMAP_IDC;
                
            onMouseButtonDblClick = "_x = _this select 2;\
                _y = _this select 3;\
                _control_key = _this select 5;\
                _ctrl = (_this select 0);\
                _wp = _ctrl ctrlMapScreenToWorld [_x, _y];\
                _wp set [2, 20];\
                if (_control_key) then { [_wp] call follow_closest_unit; }\
                else { [_wp] call create_normal_cam; };\
                spectateUpdateNow = true;";
                
            x = SafeZoneX;
            y = SafeZoneY;
            w = SafeZoneW;
            h = SafeZoneH;
        };
    };
};

class MySlider : RscText
{
    idc = -1;
    type = CT_SLIDER;
    style = SL_HORZ;
    w = 0.2;
    h = 0.04;
    color[] = { 1, 1, 1, 1 };
    coloractive[] = { 1, 0, 0, 0.5 };
    colorBackground[] = { 0, 0, 0, 0 };
    sizeEx = 0.03;
};

class spectateHelpRsc
{
    idd = SPEC_HELPDIALOG_IDD;
    movingEnable = 1;
    fadein = 1.0;
    fadeout = 5.0;
    duration = 10.0;
    access = 0;

    onLoad = "[_this select 0] call spectateHelpCtrl;";
    onUnload = "spectateHelpVisible = false;";

    class objects
    {
    };

    class controlsBackground
    {
        class HelpBG : BackgroundHelp { };
    }; 

    class controls {
        class PlayerCombo : ListBoxRsc
        {
            idc = SPEC_PLAYERCOMBO_IDC;
            x = 0.55;
            y = SafeZoneY + 0.15;
            w = 0.3;
            h = 0.65;

            onLBDblClick = "_idx = _this select 1;\
                [spectatePlayers select _idx] call spectate_enter_follow_mode;";
        };
        
        class TagsDistText : RscText
        {
            x = 0.55;
            y = SafeZoneY + 0.15 + 0.7;
            h = 0.05;
            w = 0.3;
            text = "Tag distance (200m-2000m)";
        };
        
        class TagsDistSlider : MySlider
        {
            idc = SPECTAGSDIST_IDC;
            x = 0.55;
            y = SafeZoneY + 0.15 + 0.75;
            w = 0.3;
            h = 0.04;
            onSliderPosChanged = "spectateDistance = (_this select 1);";
        };
        
        class DetailedTagsButton {
            idc = -1;
            type = CT_BUTTON;
            style = ST_CENTER;
            default = false;
            font = FontM;
            sizeEx = 0.03;
            colorText[] = { 0, 0, 0, 1 };
            colorFocused[] = { 1, 0, 0, 1 };   // border color for focused state
            colorDisabled[] = { 0, 0, 1, 0.7 };   // text color for disabled state
            colorBackground[] = { 1, 1, 1, 0.8 };
            colorBackgroundDisabled[] = { 1, 1, 1, 0.5 };   // background color for disabled state
            colorBackgroundActive[] = { 1, 1, 1, 1 };   // background color for active state
            offsetX = 0.003;
            offsetY = 0.003;
            offsetPressedX = 0.002;
            offsetPressedY = 0.002;
            colorShadow[] = { 0, 0, 0, 0.5 };
            colorBorder[] = { 0, 0, 0, 1 };
            borderSize = 0;
            soundEnter[] = { "", 0, 1 };  // no sound
            soundPush[] = { "", 0.1, 1 };
            soundClick[] = { "", 0, 1 };  // no sound
            soundEscape[] = { "", 0, 1 };  // no sound
            x = 0.55;
            y = SafeZoneY + 0.15 + 0.8;
            w = 0.3;
            h = 0.05;
            text = "Toggle Detailed Tags";
            action = "spectate_detailed_label_info = !spectate_detailed_label_info; spectateUpdateNow = true;";
        };
         
        /*
        class MapAlphaText : RscText
        {
            x = 0.7;
            y = 0.9;
            h = 0.05;
            w = 0.3;
            text = "Map BG Alpha";
        };
               
        class MapAlphaSlider : MySlider
        {
            idc = SPEC_MAP_ALPHA_IDC;
            x = 0.7;
            y = 0.95;
            w = 0.2;
            h = 0.04;
            onSliderPosChanged = "\
                disableSerialization;\
                spectate_map_alpha = (_this select 1) / 1000;\
                _ctrl = (findDisplay SPEC_FULLMAP_IDD) displayCtrl SPEC_FULLMAP_IDC;\
                player sidechat format['alpha: %1, dsp: %2, _ctrl: %3', spectate_map_alpha, (findDisplay SPEC_FULLMAP_IDD), _ctrl];\
                player sidechat format['46: %1', (findDisplay 46)];\
                _ctrl ctrlSetBackgroundColor [1, 1, 1, spectate_map_alpha];\
                _ctrl ctrlCommit 0;\
                _ctrl = (findDisplay SPEC_HELPDIALOG_IDD) displayCtrl SPEC_MAP_IDC;\
                _ctrl ctrlSetBackgroundColor [1, 0, 0, spectate_map_alpha];\
                _ctrl ctrlCommit 0;\
                ";
        };

        class FocusSlider : RscText
        {
            idc = SPECFOCUS_IDC;
            type = CT_SLIDER;
            style = SL_HORZ;
            x = 0.7;
            y = 1.0;
            w = 0.2;
            h = 0.04;
            color[] = { 1, 1, 1, 1 };
            coloractive[] = { 1, 0, 0, 0.5 };
            colorBackground[] = { 0, 0, 0, 0 };
            sizeEx = 0.03;

            onSliderPosChanged = "\
                specCamFocus = (_this select 1);\
                player sidechat format['Focus: %1', specCamFocus];\
                if (specCamFocus < 0) then {\
                    specCamFocus = -1;\
                    specCam camSetFocus [-1, -1];\
                }\
                else\
                {\
                    specCam camSetFocus [(specCamFocus / 30.0) * (specCamFocus / 30.0), specCamBlur / 100.0];\
                };\
                specCam camCommit 0;";
        };
        
        class BlurSlider : RscText
        {
            idc = SPECBLUR_IDC;
            type = CT_SLIDER;
            style = SL_HORZ;
            x = 0.7;
            y = 1.1;
            w = 0.2;
            h = 0.04;
            color[] = { 1, 1, 1, 1 };
            coloractive[] = { 1, 0, 0, 0.5 };
            colorBackground[] = { 0, 0, 0, 0 };
            sizeEx = 0.03;

            onSliderPosChanged = "\
                specCamBlur = (_this select 1);\
                player sidechat format['specCamBlur: %1', specCamBlur];\
                if (specCamBlur < 0) then {\
                    specCamBlur = -1;\
                    specCam camSetFocus [-1, -1];\
                }\
                else\
                {\
                    specCam camSetFocus [(specCamFocus / 30.0) * (specCamFocus / 30.0), specCamBlur / 100.0];\
                };\
                specCam camCommit 0;";
        };
        */


        class HelpText : SpecText
        {
            idc = -1;
            style = ST_LEFT;
            size = 0.025;
            text = "Controls:<br/>\
- You can move around using normal movement controls (WASD) and the mouse.<br/><br/>\
- Q/Y (or Z) increase/decrease your height.<br/><br/>\
- Holding shift while moving speeds you up.<br/><br/>\
- T toggles player tags.<br/><br/>\
- Following players:<br/>\
  a) Double-click on the names to the right to follow the player.<br/>\
  b) Control + double-click on a player on the map to follow him.<br/>\
  c) V: follow the closest player.<br/>\
  d) Space: Jump to last followed player.<br/>\
  <br/>\
- Follow mode:<br/>\
  Space or V: End follow mode<br/>\
  Left Click: Toggle internal/external view<br/>\
  Right Click in internal: Toggle scope/view<br/>\
  Arrow Left/Right: Jump to the next player<br/><br/>\
- Page Up/Down: change the field of view (FOV, default: 0.7)<br/><br/>\
- Double-click on the map to jump to that location.<br/>";
            x = 0.9;
            y = SafeZoneY + 0.15;
            w = (SafeZoneW + SafeZoneX) - 0.15 - 0.9;
            //w = 0.2;
            h = (SafeZoneH - 0.15) - (SafeZoneY + 0.15);

            colorBackground[] = { 1, 1, 1, 0.0 };

            class Attributes {
                font = "TahomaB";
                color = "#FFFFFF";
                align = "left";
                valign = "middle";
                shadow = 1;
                shadowColor = "#000000"; 
                size = "1";
            };
        };

        class MapCtrl : RscMapControl
        {
            idc = SPEC_MAP_IDC;
            
            onMouseButtonDblClick = "_x = _this select 2;\
                _y = _this select 3;\
                _control_key = _this select 5;\
                _ctrl = (_this select 0);\
                _wp = _ctrl ctrlMapScreenToWorld [_x, _y];\
                _wp set [2, 20];\
                if (_control_key) then { [_wp] call follow_closest_unit; }\
                else { [_wp] call create_normal_cam; };\
                spectateUpdateNow = true;";
                
            x = SafeZoneX + 0.15;
            y = SafeZoneY + 0.15;
            w = 0.5 - (SafeZoneX + 0.15);
            h = (SafeZoneY + SafeZoneH - 0.15) - (SafeZoneY + 0.15);
        };
    };
};

