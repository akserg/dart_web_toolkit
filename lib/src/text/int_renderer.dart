//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * A localized renderer based on {@link NumberFormat#getDecimalFormat}.
 */
class IntRenderer extends AbstractRenderer<int> {

  static IntRenderer _INSTANCE;

  /**
   * Returns the instance.
   */
  factory IntRenderer.instance() {
    if (_INSTANCE == null) {
      _INSTANCE = new IntRenderer();
    }
    return _INSTANCE;
  }

  IntRenderer();

  String render(int object) {
    if (object == null) {
      return "";
    }

    return NumberFormat.getDecimalFormat().formatInt(object);
  }
}
