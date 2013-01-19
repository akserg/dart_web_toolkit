//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Default implementation of DateTimeFormatInfo interface, using values from
 * the CLDR root locale.
 * <p>
 * Users who need to create their own DateTimeFormatInfo implementation are
 * encouraged to extend this class so their implementation won't break when
 * new methods are added.
 */
class DefaultDateTimeFormatInfo implements DateTimeFormatInfo {

  DefaultDateTimeFormatInfo();

  List<String> ampms() {
    return ["AM", "PM" ];
  }


  String dateFormat() {
    return dateFormatMedium();
  }


  String dateFormatFull() {
    return "EEEE, y MMMM dd";
  }


  String dateFormatLong() {
    return "y MMMM d";
  }


  String dateFormatMedium() {
    return "y MMM d";
  }


  String dateFormatShort() {
    return "yyyy-MM-dd";
  }


  String dateTime(String timePattern, String datePattern) {
    return dateTimeMedium(timePattern, datePattern);
  }


  String dateTimeFull(String timePattern, String datePattern) {
    return datePattern.concat(" ").concat(timePattern);
  }


  String dateTimeLong(String timePattern, String datePattern) {
    return datePattern.concat(" ").concat(timePattern);
  }


  String dateTimeMedium(String timePattern, String datePattern) {
    return datePattern.concat(" ").concat(timePattern);
  }


  String dateTimeShort(String timePattern, String datePattern) {
    return datePattern.concat(" ").concat(timePattern);
  }


  List<String> erasFull() {
    return ["Before Christ", "Anno Domini"];
  }


  List<String> erasShort() {
    return ["BC", "AD"];
  }


  int firstDayOfTheWeek() {
    return 1;
  }


  String formatDay() {
    return "d";
  }


  String formatHour12Minute() {
    return "h:mm a";
  }


  String formatHour12MinuteSecond() {
    return "h:mm:ss a";
  }


  String formatHour24Minute() {
    return "HH:mm";
  }


  String formatHour24MinuteSecond() {
    return "HH:mm:ss";
  }


  String formatMinuteSecond() {
    return "mm:ss";
  }


  String formatMonthAbbrev() {
    return "LLL";
  }


  String formatMonthAbbrevDay() {
    return "MMM d";
  }


  String formatMonthFull() {
    return "LLLL";
  }


  String formatMonthFullDay() {
    return "MMMM d";
  }


  String formatMonthFullWeekdayDay() {
    return "EEEE MMMM d";
  }


  String formatMonthNumDay() {
    return "M-d";
  }


  String formatYear() {
    return "y";
  }


  String formatYearMonthAbbrev() {
    return "y MMM";
  }


  String formatYearMonthAbbrevDay() {
    return "y MMM d";
  }


  String formatYearMonthFull() {
    return "y MMMM";
  }


  String formatYearMonthFullDay() {
    return "y MMMM d";
  }


  String formatYearMonthNum() {
    return "y-M";
  }


  String formatYearMonthNumDay() {
    return "y-M-d";
  }


  String formatYearMonthWeekdayDay() {
    return "EEE, y MMM d";
  }


  String formatYearQuarterFull() {
    return "y QQQQ";
  }


  String formatYearQuarterShort() {
    return "y Q";
  }


  List<String> monthsFull() {
    return ["January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ];
  }


  List<String> monthsFullStandalone() {
    return monthsFull();
  }


  List<String> monthsNarrow() {
    return ["J",
        "F",
        "M",
        "A",
        "M",
        "J",
        "J",
        "A",
        "S",
        "O",
        "N",
        "D"
    ];
  }


  List<String> monthsNarrowStandalone() {
    return monthsNarrow();
  }


  List<String> monthsShort() {
    return [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
    ];
  }


  List<String> monthsShortStandalone() {
    return monthsShort();
  }


  List<String> quartersFull() {
    return [
        "1st quarter",
        "2nd quarter",
        "3rd quarter",
        "4th quarter"
    ];
  }


  List<String> quartersShort() {
    return [
        "Q1",
        "Q2",
        "Q3",
        "Q4"
    ];
  }


  String timeFormat() {
    return timeFormatMedium();
  }


  String timeFormatFull() {
    return "HH:mm:ss zzzz";
  }


  String timeFormatLong() {
    return "HH:mm:ss z";
  }


  String timeFormatMedium() {
    return "HH:mm:ss";
  }


  String timeFormatShort() {
    return "HH:mm";
  }


  List<String> weekdaysFull() {
    return [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
    ];
  }


  List<String> weekdaysFullStandalone() {
    return weekdaysFull();
  }


  List<String> weekdaysNarrow() {
    return [
        "S",
        "M",
        "T",
        "W",
        "T",
        "F",
        "S"
    ];
  }


  List<String> weekdaysNarrowStandalone() {
    return weekdaysNarrow();
  }


  List<String> weekdaysShort() {
    return [
        "Sun",
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat"
    ];
  }


  List<String> weekdaysShortStandalone() {
    return weekdaysShort();
  }


  int weekendEnd() {
    return 0;
  }


  int weekendStart() {
    return 6;
  }
}
