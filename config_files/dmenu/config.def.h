/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Hack Nerd Mono:size=20"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */
    [SchemeNorm] = { "#ffffff", "#000000" }, // Full white text on full black background
    [SchemeSel]  = { "#000000", "#00ff00" }, // Full black text on green background
    [SchemeOut]  = { "#000000", "#004000" }, // Full black text on cyan background (out state)
};


/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 15;


/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
