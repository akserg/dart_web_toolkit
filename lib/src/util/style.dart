//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

class Style {

  static const String _DISPLAY_INLINE_BLOCK = "inline-block";
  static const String _DISPLAY_INLINE = "inline";
  static const String _DISPLAY_BLOCK = "block";
  static const String _DISPLAY_NONE = "none";

  static const String _OVERFLOW_AUTO = "auto";
  static const String _OVERFLOW_SCROLL = "scroll";
  static const String _OVERFLOW_HIDDEN = "hidden";
  static const String _OVERFLOW_VISIBLE = "visible";

  static const String _POSITION_FIXED = "fixed";
  static const String _POSITION_ABSOLUTE = "absolute";
  static const String _POSITION_RELATIVE = "relative";
  static const String _POSITION_STATIC = "static const";

  static const String _UNIT_MM = "mm";
  static const String _UNIT_CM = "cm";
  static const String _UNIT_IN = "in";
  static const String _UNIT_PC = "pc";
  static const String _UNIT_PT = "pt";
  static const String _UNIT_EX = "ex";
  static const String _UNIT_EM = "em";
  static const String _UNIT_PCT = "%";
  static const String _UNIT_PX = "px";

  static const String _WHITE_SPACE_NORMAL = "normal";
  static const String _WHITE_SPACE_NOWRAP = "nowrap";
  static const String _WHITE_SPACE_PRE = "pre";
  static const String _WHITE_SPACE_PRE_LINE = "pre-line";
  static const String _WHITE_SPACE_PRE_WRAP = "pre-wrap";
}


/**
 * Enum for the display property.
 */
class Display {
  static const String NONE = Style._DISPLAY_NONE;
  static const String BLOCK = Style._DISPLAY_BLOCK;
  static const String INLINE = Style._DISPLAY_INLINE;
  static const String INLINE_BLOCK = Style._DISPLAY_INLINE_BLOCK;
}

/**
 * Enum for the overflow property.
 */
class Overflow {
  static const String VISIBLE = Style._OVERFLOW_VISIBLE;
  static const String HIDDEN = Style._OVERFLOW_HIDDEN;
  static const String SCROLL = Style._OVERFLOW_SCROLL;
  static const String AUTO = Style._OVERFLOW_AUTO;
}

/**
 * Enum for the position property.
 */
class Position {
  static const String STATIC = Style._POSITION_STATIC;
  static const String RELATIVE = Style._POSITION_RELATIVE;
  static const String ABSOLUTE = Style._POSITION_ABSOLUTE;
  static const String FIXED = Style._POSITION_FIXED;
}

/**
 * CSS length units.
 */
class Unit {
  static const String PX = Style._UNIT_PX;
  static const String PCT = Style._UNIT_PCT;
  static const String EM = Style._UNIT_EM;
  static const String EX = Style._UNIT_EX;
  static const String PT = Style._UNIT_PT;
  static const String PC = Style._UNIT_PC;
  static const String IN = Style._UNIT_IN;
  static const String CM = Style._UNIT_CM;
  static const String MM = Style._UNIT_MM;
}

/**
 * Enum for the 'white-space' CSS property.
 */
class WhiteSpace {
  static const String NORMAL = Style._WHITE_SPACE_NORMAL;
  static const String NOWRAP = Style._WHITE_SPACE_NOWRAP;
  static const String PRE = Style._WHITE_SPACE_PRE;
  static const String PRE_LINE = Style._WHITE_SPACE_PRE_LINE;
  static const String PRE_WRAP = Style._WHITE_SPACE_PRE_WRAP;
}