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
class Display<String> extends Enum<String> {
  
  const Display(String type) : super (type);
  
  static const Display NONE = const Display(Style._DISPLAY_NONE);
  static const Display BLOCK = const Display(Style._DISPLAY_BLOCK);
  static const Display INLINE = const Display(Style._DISPLAY_INLINE);
  static const Display INLINE_BLOCK = const Display(Style._DISPLAY_INLINE_BLOCK);
}

/**
 * Enum for the overflow property.
 */
class Overflow<String> extends Enum<String> {
  
  const Overflow(String type) : super (type);
  
  static const Overflow VISIBLE = const Overflow(Style._OVERFLOW_VISIBLE);
  static const Overflow HIDDEN = const Overflow(Style._OVERFLOW_HIDDEN);
  static const Overflow SCROLL = const Overflow(Style._OVERFLOW_SCROLL);
  static const Overflow AUTO = const Overflow(Style._OVERFLOW_AUTO);
}

/**
 * Enum for the position property.
 */
class Position<String> extends Enum<String> {
  
  const Position(String type) : super (type);
  
  static const Position STATIC = const Position(Style._POSITION_STATIC);
  static const Position RELATIVE = const Position(Style._POSITION_RELATIVE);
  static const Position ABSOLUTE = const Position(Style._POSITION_ABSOLUTE);
  static const Position FIXED = const Position(Style._POSITION_FIXED);
}

/**
 * CSS length units.
 */
class Unit<String> extends Enum<String> {
  
  const Unit(String type) : super (type);
  
  static const Unit PX = const Unit(Style._UNIT_PX);
  static const Unit PCT = const Unit(Style._UNIT_PCT);
  static const Unit EM = const Unit(Style._UNIT_EM);
  static const Unit EX = const Unit(Style._UNIT_EX);
  static const Unit PT = const Unit(Style._UNIT_PT);
  static const Unit PC = const Unit(Style._UNIT_PC);
  static const Unit IN = const Unit(Style._UNIT_IN);
  static const Unit CM = const Unit(Style._UNIT_CM);
  static const Unit MM = const Unit(Style._UNIT_MM);
}

/**
 * Enum for the 'white-space' CSS property.
 */
class WhiteSpace<String> extends Enum<String> {
  
  const WhiteSpace(String type) : super (type);
  
  static const WhiteSpace NORMAL = const WhiteSpace(Style._WHITE_SPACE_NORMAL);
  static const WhiteSpace NOWRAP = const WhiteSpace(Style._WHITE_SPACE_NOWRAP);
  static const WhiteSpace PRE = const WhiteSpace(Style._WHITE_SPACE_PRE);
  static const WhiteSpace PRE_LINE = const WhiteSpace(Style._WHITE_SPACE_PRE_LINE);
  static const WhiteSpace PRE_WRAP = const WhiteSpace(Style._WHITE_SPACE_PRE_WRAP);
}