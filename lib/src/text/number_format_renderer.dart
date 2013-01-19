//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * Renders {@link Number} objects with a {@link NumberFormat}.
 */
class NumberFormatRenderer extends AbstractRenderer<num> {

  NumberFormat format;

  /**
   * Create an instance with the given [format] or
   * [NumberFormat#getDecimalFormat()]
   */
  NumberFormatRenderer([NumberFormat format = null]) {
    if (format == null) {
      this.format = NumberFormat.getDecimalFormat();
    } else {
      this.format = format;
    }
  }

  String render(num object) {
    if (object == null) {
      return "";
    }
    return format.format(object);
  }
}
