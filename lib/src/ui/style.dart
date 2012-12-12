//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_mob_ui;

class Style {
  static String _WHITE_SPACE_NORMAL = "normal";
  static String _WHITE_SPACE_NOWRAP = "nowrap";
  static String _WHITE_SPACE_PRE = "pre";
  static String _WHITE_SPACE_PRE_LINE = "pre-line";
  static String _WHITE_SPACE_PRE_WRAP = "pre-wrap";
}


/**
 * Enum for the 'white-space' CSS property.
 */
class WhiteSpace {
  static String NORMAL = Style._WHITE_SPACE_NORMAL;
  static String NOWRAP = Style._WHITE_SPACE_NOWRAP;
  static String PRE = Style._WHITE_SPACE_PRE;
  static String PRE_LINE = Style._WHITE_SPACE_PRE_LINE;
  static String PRE_WRAP = Style._WHITE_SPACE_PRE_WRAP;
}
