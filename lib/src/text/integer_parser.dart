//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * A localized parser based on {@link NumberFormat#getDecimalFormat}.
 */
class IntegerParser implements Parser<int> {

  static IntegerParser _INSTANCE;

  /**
   * Returns the instance of the no-op renderer.
   */
  factory IntegerParser.instance() {
    if (_INSTANCE == null) {
      _INSTANCE = new IntegerParser();
    }
    return _INSTANCE;
  }

  IntegerParser();

  int parse(String object) {
    if (object == null || object == "") {
      return null;
    }

    return int.parse(object);
  }
}
