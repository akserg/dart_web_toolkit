//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

class LocaleInfo {

  /**
   * Currently we only support getting the currently running locale, so this
   * is a static.  In the future, we would need a hash map from locale names
   * to LocaleInfo instances.
   */
  static LocaleInfo instance = new LocaleInfo(new LocaleInfoImpl()); //, new CldrImpl());

  /**
   * Returns an array of available locale names.
   */
  static List<String> getAvailableLocaleNames() {
    /*
     * The set of all locales is constant across all permutations, so this
     * is static.  Ideally, the set of available locales would be generated
     * by a different GWT.create but that would slow the compilation process
     * unnecessarily.
     *
     * This is static, and accesses infoImpl this way, with an eye towards
     * when we implement static LocaleInfo getLocale(String localeName) as
     * you might want to get the list of available locales in order to create
     * instances of each of them.
     */
    return instance.infoImpl.getAvailableLocaleNames();
  }

  /**
   * Returns a LocaleInfo instance for the current locale.
   */
  static LocaleInfo getCurrentLocale() {
    /*
     * In the future, we could make additional static methods which returned a
     * LocaleInfo instance for a specific locale (from the set of those the app
     * was compiled with), accessed via a method like:
     *    public static LocaleInfo getLocale(String localeName)
     */
    return instance;
  }
  
  /**
   * Returns true if any locale supported by this build of the app is RTL.
   */
  static bool hasAnyRTL() {
    return instance.infoImpl.hasAnyRTL();
  }

  LocaleInfoImpl infoImpl;

//  CldrImpl cldrImpl;
  DateTimeFormatInfo dateTimeFormatInfo;

  NumberConstants numberConstants;

  /**
   * Create a LocaleInfo instance, passing in the implementation classes.
   *
   * @param impl LocaleInfoImpl instance to use
   * @param cldr CldrImpl instance to use
   */
  LocaleInfo([this.infoImpl = null]); //, this.cldrImpl = null]);

  /**
   * Returns true if this locale is right-to-left instead of left-to-right.
   */
  bool isRTL() {
    return false; //cldrImpl.isRTL();
  }

  /**
   * Returns a DateTimeConstants instance for this locale.
   */
  DateTimeFormatInfo getDateTimeFormatInfo() {
    ensureDateTimeFormatInfo();
    return dateTimeFormatInfo;
  }

  void ensureDateTimeFormatInfo() {
    if (dateTimeFormatInfo == null) {
      dateTimeFormatInfo = infoImpl.getDateTimeFormatInfo();
    }
  }

  /**
   * Returns a NumberConstants instance for this locale.
   */
  NumberConstants getNumberConstants() {
    ensureNumberConstants();
    return numberConstants;
  }

  void ensureNumberConstants() {
    if (numberConstants == null) {
      numberConstants = infoImpl.getNumberConstants();
    }
  }

}
