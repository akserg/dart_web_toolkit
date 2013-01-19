//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * A JavaScript Overlay type on top of the JSON data describing everything we
 * need to know about a particular timezone. The relevant strings of JSON can
 * be found in TimeZoneConstants, or versions localized for non-en locales can
 * be downloaded elsewhere.
 */
class TimeZoneInfo {

  /**
   * Construct a TimeZoneData javascript overlay object given some json text.
   * This method directly evaluates the String that you pass in; no error or
   * safety checking is performed, so be very careful about the source of
   * your data.
   *
   * @param json JSON text describing a time zone, like what comes from
   * {@link  com.google.gwt.i18n.client.constants.TimeZoneConstants}.
   * @return a TimeZoneInfo object made from the supplied JSON.
   */
  static TimeZoneInfo buildTimeZoneData(String json) {
    return eval(json) as TimeZoneInfo;
  }

  static Object eval(String json) {
    return eval("($json)");
  }

  TimeZoneInfo() { }

//  String getID() {
//    return this.id;
//  }
//
//  List<String> getNames() {
//    return this.names;
//  }
//
//  int getStandardOffset() {
//    return this.std_offset;
//  }
//
//  List<int> getTransitions() {
//    return this.transitions;
//  }
}
