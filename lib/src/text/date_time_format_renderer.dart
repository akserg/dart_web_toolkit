//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * Renders {@link Date} objects with a {@link DateTimeFormat}.
 */
class DateTimeFormatRenderer extends AbstractRenderer<Date> {

  DateTimeFormat format;
  TimeZone timeZone;

  /**
   * Create an instance with the given format and time zone.
   */
  DateTimeFormatRenderer([DateTimeFormat format = null, TimeZone timeZone = null]) {
    if (format == null) {
      this.format = DateTimeFormat.getPredefinedFormat(PredefinedFormat.DATE_SHORT);
    } else {
      this.format = format;
    }
    this.timeZone = timeZone;
  }

  String render(Date object) {
    if (object == null) {
      return "";
    }
    return format.format(object, timeZone);
  }
}
