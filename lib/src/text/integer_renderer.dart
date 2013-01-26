//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * A localized renderer based on {@link NumberFormat#getDecimalFormat}.
 */
class IntegerRenderer extends AbstractRenderer<int> {

  static IntegerRenderer _INSTANCE;

  /**
   * Returns the instance.
   */
  factory IntegerRenderer.instance() {
    if (_INSTANCE == null) {
      _INSTANCE = new IntegerRenderer();
    }
    return _INSTANCE;
  }

  IntegerRenderer();

  String render(int object) {
    if (object == null) {
      return "";
    }

    return NumberFormat.getDecimalFormat().formatInt(object);
  }
}
