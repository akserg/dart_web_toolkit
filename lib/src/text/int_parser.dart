//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * A localized parser based on {@link NumberFormat#getDecimalFormat}.
 */
class IntParser implements Parser<int> {

  static IntParser _INSTANCE;

  /**
   * Returns the instance of the no-op renderer.
   */
  factory IntParser.instance() {
    if (_INSTANCE == null) {
      _INSTANCE = new IntParser();
    }
    return _INSTANCE;
  }

  IntParser();

  int parse(String object) {
    if (object == null || object == "") {
      return null;
    }

    return int.parse(object);
  }
}
