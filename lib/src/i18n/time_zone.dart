//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * The TimeZone class implements a time zone information source for client
 * applications. The time zone object is instantiated from a TimeZoneData object,
 * which is made from a JSON string that contains all the data needed for
 * the specified time zone. Applications can instantiate a time zone statically,
 * in which case the data could be retrieved from
 * the {@link com.google.gwt.i18n.client.constants.TimeZoneConstants TimeZoneConstants}
 * class. Applications can also choose to instantiate from a string obtained
 * from a server. The time zone string contains locale specific data. If the
 * application only uses a short representation, the English data will usually
 * satisfy the user's need. In the case that only the time zone offset is known,
 * there is a decent fallback that only uses the time zone offset to create a
 * TimeZone object.
 */
class TimeZone {
// constants to reference time zone names in the time zone names array
  static final int _STD_SHORT_NAME = 0;
  static final int _STD_LONG_NAME = 1;
  static final int _DLT_SHORT_NAME = 2;
  static final int _DLT_LONG_NAME = 3;

  /**
   * This factory method provides a decent fallback to create a time zone object
   * just based on a given time zone offset.
   *
   * @param timeZoneOffsetInMinutes time zone offset in minutes
   * @return a new time zone object
   */
  static TimeZone createTimeZone(int timeZoneOffsetInMinutes) {
    TimeZone tz = new TimeZone();
    tz._standardOffset = timeZoneOffsetInMinutes;
    tz._timezoneID = _composePOSIXTimeZoneID(timeZoneOffsetInMinutes);
    tz._tzNames = new List<String>(2);
    tz._tzNames[0] = _composeUTCString(timeZoneOffsetInMinutes);
    tz._tzNames[1] = _composeUTCString(timeZoneOffsetInMinutes);
    tz._transitionPoints = null;
    tz._adjustments = null;
    return tz;
  }

  /**
   * This factory method creates a time zone instance from a JSON string that
   * contains the time zone information for desired time zone. Applications can
   * get such a string from the TimeZoneConstants class, or it can request the
   * string from the server. Either way, the application obtains the original
   * string from the data provided in the TimeZoneConstant.properties file,
   * which was carefully prepared from CLDR and Olson time zone database.
   *
   * @param tzJSON JSON string that contains time zone data
   * @return a new time zone object
   */
//  static TimeZone createTimeZoneFromJson(String tzJSON) {
//    TimeZoneInfo tzData = TimeZoneInfo.buildTimeZoneData(tzJSON);
//
//    return createTimeZoneFromInfo(tzData);
//  }

//  static TimeZone createTimeZoneFromInfo(TimeZoneInfo timezoneData) {
//    TimeZone tz = new TimeZone();
//
//    tz._timezoneID = timezoneData.getID();
//    tz._standardOffset = -timezoneData.getStandardOffset();
//
//    List<String> jsTimezoneNames = timezoneData.getNames();
//
//    tz._tzNames = new List<String>(jsTimezoneNames.length);
//
//    for (int i = 0; i < jsTimezoneNames.length; i++) {
//      tz._tzNames[i] = jsTimezoneNames[i];
//    }
//
//    List<int> transitions = timezoneData.getTransitions();
//
//    if (transitions == null || transitions.length == 0) {
//      tz._transitionPoints = null;
//      tz._adjustments = null;
//    } else {
//      int transitionNum = transitions.length ~/ 2;
//      tz._transitionPoints = new List<int>(transitionNum);
//      tz._adjustments = new List<int>(transitionNum);
//
//      for (int i = 0; i < transitionNum; ++i) {
//        tz._transitionPoints[i] = transitions[i * 2];
//        tz._adjustments[i] = transitions[i * 2 + 1];
//      }
//    }
//    return tz;
//  }

  /**
   * In GMT representation, +/- has reverse sign of time zone offset.
   * when offset == 480, it should output GMT-08:00.
   */
  static String _composeGMTString(int offset) {
    List<int> data = 'GMT-00:00'.codeUnits;
    if (offset <= 0) {
      data[3] = '+'.codeUnitAt(0);
      offset = -offset; // suppress the '-' sign for text display.
    }
    data[4] += (offset ~/ 60) ~/ 10;
    data[5] += (offset ~/ 60) % 10;
    data[7] += (offset % 60) ~/ 10;
    data[8] += offset % 10;
    return new String.fromCharCodes(data);
  }

  /**
   * POSIX time zone ID as fallback.
   */
  static String _composePOSIXTimeZoneID(int offset) {
    if (offset == 0) {
      return "Etc/GMT";
    }
    String str;
    if (offset < 0) {
      offset = -offset;
      str = "Etc/GMT-";
    } else {
      str = "Etc/GMT+";
    }
    return str +  _offsetDisplay(offset);
  }

  static String _composeUTCString(int offset) {
    if (offset == 0) {
      return "UTC";
    }
    String str;
    if (offset < 0) {
      offset = -offset;
      str = "UTC+";
    } else {
      str = "UTC-";
    }
    return str +  _offsetDisplay(offset);
  }

  static String _offsetDisplay(int offset) {
    int hour = offset ~/ 60;
    int mins = offset % 60;
    if (mins == 0) {
      return hour.toString();
    }
    return hour.toString() + ":" + mins.toString();
  }

  String _timezoneID;
  int _standardOffset;
  List<String> _tzNames;
  List<int> _transitionPoints;
  List<int>  _adjustments;

  TimeZone() {
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#getDaylightAdjustment(java.util.DateTime)
   */
  int getDaylightAdjustment(DateTime date) {
    if (_transitionPoints == null) {
      return 0;
    }
    int timeInHours = date.millisecond ~/ 1000 ~/ 3600;
    int index = 0;
    while (index < _transitionPoints.length &&
        timeInHours >= _transitionPoints[index]) {
      ++index;
    }
    return (index == 0) ? 0 : _adjustments[index - 1];
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#getGMTString(java.util.DateTime)
   */
  String getGMTString(DateTime date) {
    return _composeGMTString(getOffset(date));
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#getID()
   */
  String getID() {
    return _timezoneID;
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#getISOTimeZoneString(java.util.DateTime)
   */
  String getISOTimeZoneString(DateTime date) {
    int offset = -getOffset(date);
    //
    List<int> data = '+00:00'.codeUnits;
    if (offset < 0) {
      data[0] = '-'.codeUnitAt(0);
      offset = -offset; // suppress the '-' sign for text display.
    }
    data[1] += (offset ~/ 60) ~/ 10;
    data[2] += (offset ~/ 60) % 10;
    data[4] += (offset % 60) ~/ 10;
    data[5] += offset % 10;
    return new String.fromCharCodes(data);
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#getLongName(java.util.DateTime)
   */
  String getLongName(DateTime date) {
    return _tzNames[isDaylightTime(date) ? _DLT_LONG_NAME : _STD_LONG_NAME];
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#getOffset(java.util.DateTime)
   */
  int getOffset(DateTime date) {
    return _standardOffset - getDaylightAdjustment(date);
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#getRFCTimeZoneString(java.util.DateTime)
   */
  String getRFCTimeZoneString(DateTime date) {
    int offset = -getOffset(date);
    //
    List<int> data = '+0000'.codeUnits;
    if (offset < 0) {
      data[0] = '-'.codeUnitAt(0);
      offset = -offset; // suppress the '-' sign for text display.
    }
    data[1] += (offset ~/ 60) ~/ 10;
    data[2] += (offset ~/ 60) % 10;
    data[3] += (offset % 60) ~/ 10;
    data[4] += offset % 10;
    return  new String.fromCharCodes(data);
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#getShortName(java.util.DateTime)
   */
  String getShortName(DateTime date) {
    return _tzNames[isDaylightTime(date) ? _DLT_SHORT_NAME : _STD_SHORT_NAME];
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#getStandardOffset()
   */
  int getStandardOffset() {
    return _standardOffset;
  }

  /* (non-Javadoc)
   * @see com.google.gwt.i18n.client.TimeZoneIntf#isDaylightTime(java.util.DateTime)
   */
  bool isDaylightTime(DateTime date) {
    return getDaylightAdjustment(date) > 0;
  }
}
