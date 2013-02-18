#include "defines.inc"

#define CT_STATIC 0
#define CT_COMBO 4
#define ST_LEFT 0x00
#define ST_CENTER 0x02
#define CT_STRUCTURED_TEXT 13
#define FontM "TahomaB"

class RscText {
	idc = -1;
	type = CT_STATIC;
	style = ST_LEFT;
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

class spectateHelpAdviceRsc {
	idd = -1;
	movingEnable = 1;
	fadein = 0.0;
	fadeout = 5.0;
	duration = 5.0;
	access = 0;

	class objects {
	};
	class controlsBackground {
	}; 
	class controls {
		class HelpText : SpecText {
			idc = -1;
			text = "Press F1 for help.";
			x = 0.1;
			y = 0.1;
			w = 0.7;
			h = 0.1;
			colorBackground[] = { 1, 1, 1, 0.0 };
		};
	};
};

class spectateHintRsc {
	idd = SPECOVERLAY_HINT_IDD;
	movingEnable = 1;
	fadein = 0.0;
	fadeout = 3.0;
	duration = 7.0;
	access = 0;

	onLoad = "_this execVM 'bScripts\spectate\spectateHintCtrl.sqf';";

	class objects {
	};
	class controlsBackground {
	}; 
	class controls {
		class HintText : SpecText {
			idc = SPECOVERLAY_HINT_IDC;
			text = "";
			x = 0.1;
			y = 0.1;
			w = 0.4;
			h = 0.1;
			colorBackground[] = { 1, 1, 1, 0.0 };
		};
	};
};


class spectateOverlayRsc {
	idd = SPECOVERLAY_IDD;
	movingEnable = 1;
	fadein = 0.0;
	fadeout = 0.0;
	duration = 1e6;
	access = 0;

	onLoad = "_this call spectateOverlayCtrl;";

	class objects {
	};
	class controlsBackground {
	}; 
	class controls {
		class SpecTag00 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 0; };
		class SpecTag01 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 1; };
		class SpecTag02 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 2; };
		class SpecTag03 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 3; };
		class SpecTag04 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 4; };
		class SpecTag05 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 5; };
		class SpecTag06 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 6; };
		class SpecTag07 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 7; };
		class SpecTag08 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 8; };
		class SpecTag09 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 9; };

		class SpecTag10 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 10; };
		class SpecTag11 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 11; };
		class SpecTag12 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 12; };
		class SpecTag13 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 13; };
		class SpecTag14 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 14; };
		class SpecTag15 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 15; };
		class SpecTag16 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 16; };
		class SpecTag17 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 17; };
		class SpecTag18 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 18; };
		class SpecTag19 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 19; };

		class SpecTag20 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 20; };
		class SpecTag21 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 21; };
		class SpecTag22 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 22; };
		class SpecTag23 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 23; };
		class SpecTag24 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 24; };
		class SpecTag25 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 25; };
		class SpecTag26 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 26; };
		class SpecTag27 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 27; };
		class SpecTag28 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 28; };
		class SpecTag29 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 29; };

		class SpecTag30 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 30; };
		class SpecTag31 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 31; };
		class SpecTag32 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 32; };
		class SpecTag33 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 33; };
		class SpecTag34 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 34; };
		class SpecTag35 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 35; };
		class SpecTag36 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 36; };
		class SpecTag37 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 37; };
		class SpecTag38 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 38; };
		class SpecTag39 : SpecText { idc = SPECOVERLAY_TAG0_IDC + 39; };
	};
};
