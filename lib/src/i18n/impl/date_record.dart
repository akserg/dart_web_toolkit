//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Implementation detail of DateTimeFormat -- not a API and subject to
 * change.
 *
 * DateRecord class exposes almost the same set of interface as Date class with
 * only a few exceptions. The main purpose is the record all the information
 * during parsing phase and resolve them in a later time when all information
 * can be processed together.
 */
class DateRecord {
  DateTime _date = new DateTime.now();

  static final int AM = 0;
  static final int PM = 1;

  static final int _JS_START_YEAR = 1900;

  static const int MIN_VALUE = -2147483648;

  int era = -1;
  int year = MIN_VALUE;
  int month = -1;
  int dayOfMonth = -1; // day
  int ampm = -1;
  int hours = -1;
  int minutes = -1;
  int seconds = -1;
  int millisecond = -1;

  int tzOffset = MIN_VALUE;
  int dayOfWeek = -1;
  bool ambiguousYear = false;

  /**
   * Initialize DateExt object with default value. Here we use -1 for most of
   * the field to indicate that field is not set.
   */
  DateRecord();

  /**
   * calcDate uses all the field available so far to fill a Date object. For
   * those information that is not provided, the existing value in 'date' will
   * be kept. Ambiguous year will be resolved after the date/time values are
   * resolved.
   *
   * If the strict option is set to true, calcDate will calculate certain
   * invalid dates by wrapping around as needed. For example, February 30 will
   * wrap to March 2.
   *
   * @param date The Date object being filled. Its value should be set to an
   *          acceptable default before pass in to this method
   * @param strict true to be strict when parsing
   * @return true if successful, otherwise false.
   */
  bool calcDate(DateTime date, bool strict) {
    // Year 0 is 1 BC, and so on.
    if (this.era == 0 && this.year > 0) {
      this.year = -(this.year - 1);
    }

    int _year;
    if (this.year > MIN_VALUE) {
      _year /* date.year */ = this.year - _JS_START_YEAR;
    }

    // "setMonth" and "setDate" is a little bit tricky. Suppose content in
    // date is 11/30, switch month to 02 will lead to 03/02 since 02/30 does
    // not exist. And you certain won't like 02/12 turn out to be 03/12. So
    // here to set date to a smaller number before month, and later setMonth.
    // Real date is set after, and that might cause month switch. However,
    // that's desired.
    int orgDayOfMonth = date.day;
    int _day = 1; //date.day = 1;

    int _month;
    if (this.month >= 0) {
      _month /* date.month */ = this.month;
    }

    if (this.dayOfMonth >= 0) {
      _day /* date.day */ = this.dayOfMonth;
    } else if (this.month >= 0) {
      // If the month was parsed but dayOfMonth was not, then the current day of
      // the month shouldn't affect the parsed month. For example, if "Feb2006"
      // is parse on January 31, the resulting date should be in February, not
      // March. So, we limit the day of the month to the maximum day within the
      // parsed month.
      DateTime tmp = new DateTime(date.year, date.month, 35);
      int daysInCurrentMonth = 35 - tmp.day;
      _day /* date.day */ = dart_math.min(daysInCurrentMonth, orgDayOfMonth);
    } else {
      _day /* date.day */ = orgDayOfMonth;
    }

    // adjust ampm
    if (this.hours < 0) {
      this.hours = date.hour;
    }

    if (this.ampm > 0) {
      if (this.hours < 12) {
        this.hours += 12;
      }
    }
    int _hour /* date.hour */ = this.hours;

    int _minute;
    if (this.minutes >= 0) {
      _minute /* date.minute */ = this.minutes;
    }

    int _second;
    if (this.seconds >= 0) {
      _second /* date.second */ = this.seconds;
    }

    int _millisecond;
    if (this.millisecond >= 0) {
      //date.setTime(date.time / 1000 * 1000 + this.milliseconds);
      _millisecond = date.millisecond ~/ 1000000 + this.millisecond;
    }

    date = new DateTime(_year, _month, _day, _hour, _minute, _second, _millisecond);

    // If strict, verify that the original date fields match the calculated date
    // fields. We do this before we set the timezone offset, which will skew all
    // of the dates.
    //
    // We don't need to check the day of week as it is guaranteed to be correct
    // or return false below.
    if (strict) {
      if ((this.year > MIN_VALUE)
          && ((this.year - _JS_START_YEAR) != date.year)) {
        return false;
      }
      if ((this.month >= 0) && (this.month != date.month)) {
        return false;
      }
      if ((this.dayOfMonth >= 0) && (this.dayOfMonth != date.day)) {
        return false;
      }
      // Times have well defined maximums
      if (this.hours >= 24) {
        return false;
      }
      if (this.minutes >= 60) {
        return false;
      }
      if (this.seconds >= 60) {
        return false;
      }
      if (this.millisecond >= 1000) {
        return false;
      }
    }

    // Resolve ambiguous year if needed.
    if (this.ambiguousYear) { // the two-digit year == the default start year
      DateTime defaultCenturyStart = new DateTime.now();
      //defaultCenturyStart.year = defaultCenturyStart.year - 80;
      defaultCenturyStart = new DateTime(defaultCenturyStart.year - 80, defaultCenturyStart.month, defaultCenturyStart.day, defaultCenturyStart.hour, defaultCenturyStart.minute, defaultCenturyStart.second, defaultCenturyStart.millisecond);

      if (date.isBefore(defaultCenturyStart)) {
        //date.year = defaultCenturyStart.year + 100;
        date = new DateTime(defaultCenturyStart.year + 100, _month, _day, _hour, _minute, _second, _millisecond);
      }
    }

    // Date is resolved to the nearest dayOfWeek if date is not explicitly
    // specified. There is one exception, if the nearest dayOfWeek falls
    // into a different month, the 2nd nearest dayOfWeek, which is on the
    // other direction, will be used.
    if (this.dayOfWeek >= 0) {
      if (this.dayOfMonth == -1) {
        // Adjust to the nearest day of the week.
        int adjustment = (7 + this.dayOfWeek - date.day) % 7;
        if (adjustment > 3) {
          adjustment -= 7;
        }
        int orgMonth = date.month;
        _day /* date.day */ = date.day + adjustment;

        // If the nearest weekday fall into a different month, we will use the
        // 2nd nearest weekday, which will be on the other direction, and is
        // sure fall into the same month.
        if (date.month != orgMonth) {
          _day /* date.day */ = _day /* date.day */ + (adjustment > 0 ? -7 : 7);
        }

        date = new DateTime(date.year, date.month, _day, date.hour, date.minute, date.second, date.millisecond);

      } else {
        if (date.day != this.dayOfWeek) {
          return false;
        }
      }
    }

    // Adjust time zone.
    if (this.tzOffset > MIN_VALUE) {
      //int offset = getTimezoneOffset(date);
      //date.setTime(date.getTime() + (this.tzOffset - offset) * 60 * 1000);
      date = new DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch, isUtc:true);
      // HBJ date.setTime(date.getTime() + this.tzOffset * 60 * 1000);
    }

    return true;
  }

//  int getTimezoneOffset(DateTime date) {
//    DateTime utc = new DateTime.utc(date.year, date.month, date.day, date.hour, date.minute, date.second, date.millisecond);
//    return (date.millisecondsSinceEpoch - utc.millisecondsSinceEpoch) ~/ 60000;
//  }

  /**
   * Set ambiguous year field. This flag indicates that a 2 digit years's
   * century need to be determined by its date/time value. This can only be
   * resolved after its date/time is known.
   *
   * @param ambiguousYear true if it is ambiguous year.
   */
  void setAmbiguousYear(bool ambiguousYear) {
    this.ambiguousYear = ambiguousYear;
  }

  /**
   * Set morning/afternoon field.
   *
   * @param ampm ampm value.
   */
  void setAmpm(int ampm) {
    this.ampm = ampm;
  }

  /**
   * Set dayOfMonth field.
   *
   * @param day dayOfMonth value
   */
  void setDayOfMonth(int day) {
    this.dayOfMonth = day;
  }

  /**
   * Set dayOfWeek field.
   *
   * @param dayOfWeek day of the week.
   */
  void setDayOfWeek(int dayOfWeek) {
    this.dayOfWeek = dayOfWeek;
  }

  /**
   * Set Era field.
   *
   * @param era era value being set.
   */
  void setEra(int era) {
    this.era = era;
  }

  /**
   * Set hour field.
   *
   * @param hours hour value.
   */
  void setHours(int hours) {
    this.hours = hours;
  }

  /**
   * Set milliseconds field.
   *
   * @param milliseconds milliseconds value.
   */
  void setMilliseconds(int milliseconds) {
    this.millisecond = milliseconds;
  }

  /**
   * Set minute field.
   *
   * @param minutes minute value.
   */
  void setMinutes(int minutes) {
    this.minutes = minutes;
  }

  /**
   * Set month field.
   *
   * @param month month value.
   */
  void setMonth(int month) {
    this.month = month;
  }

  /**
   * Set seconds field.
   *
   * @param seconds second value.
   */
  void setSeconds(int seconds) {
    this.seconds = seconds;
  }

  /**
   * Set timezone offset, in minutes.
   *
   * @param tzOffset timezone offset.
   */
  void setTzOffset(int tzOffset) {
    this.tzOffset = tzOffset;
  }

  /**
   * Set year field.
   *
   * @param value year value.
   */
  void setYear(int value) {
    this.year = value;
  }
}
