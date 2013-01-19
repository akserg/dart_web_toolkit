//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * A localized parser based on {@link NumberFormat#getDecimalFormat}.
 */
class DoubleParser implements Parser<double> {

  static DoubleParser _INSTANCE;

  /**
   * Returns the instance of the no-op renderer.
   */
  factory DoubleParser.instance() {
    if (_INSTANCE == null) {
      _INSTANCE = new DoubleParser();
    }
    return _INSTANCE;
  }

  DoubleParser();

  double parse(String object) {
    if (object == null || object == "") {
      return null;
    }

    return double.parse(object);
  }
}
