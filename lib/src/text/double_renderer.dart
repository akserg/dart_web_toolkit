//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * A localized renderer based on {@link NumberFormat#getDecimalFormat}.
 */
class DoubleRenderer extends AbstractRenderer<double> {
  
  static DoubleRenderer _INSTANCE;

  /**
   * Returns the instance.
   */
  factory DoubleRenderer.instance() {
    if (_INSTANCE == null) {
      _INSTANCE = new DoubleRenderer();
    }
    return _INSTANCE;
  }

  DoubleRenderer();

  String render(double object) {
    if (object == null) {
      return "";
    }

    return NumberFormat.getDecimalFormat().formatDouble(object);
  }
}
