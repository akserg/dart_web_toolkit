//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Implementation detail of LocaleInfo -- not a API and subject to
 * change.
 *
 * Generated interface for locale information.  The default implementation
 * returns null, which is used if the i18n module is not imported.
 *
 * @see com.google.gwt.i18n.client.LocaleInfo
 */
class LocaleInfoImpl {
  /**
   * Returns the runtime locale (note that this requires the i18n locale property
   * provider's assistance).
   */
  static String getRuntimeLocale() {
    return ""; //dart_html.document.$dom_attributes["__gwt_Locale"]; // $wnd['__gwt_Locale'];
  }

  /**
   * Returns an array of available locale names.
   */
  List<String> getAvailableLocaleNames() {
    return null;
  }

  /**
   * Create a {@link DateTimeFormatInfo} instance appropriate for this locale.
   *
   * Note that the caller takes care of any caching so subclasses need not
   * bother.
   *
   * @return a {@link DateTimeFormatInfo} instance
   */
  DateTimeFormatInfo getDateTimeFormatInfo() {
    return new DateTimeFormatInfoImpl();
  }

  /**
   * Returns the name of the name of the cookie holding the locale to use,
   * which is defined in the config property {@code locale.cookie}.
   *
   * @return locale cookie name, or null if none
   */
  String getLocaleCookieName() {
    return null;
  }

  /**
   * Returns the current locale name, such as "default, "en_US", etc.
   */
  String getLocaleName() {
    return null;
  }

  /**
   * Returns the display name of the requested locale in its native locale, if
   * possible. If no native localization is available, the English name will
   * be returned, or as a last resort just the locale name will be returned.  If
   * the locale name is unknown (including user overrides), null is returned.
   *
   * @param localeName the name of the locale to lookup.
   * @return the name of the locale in its native locale
   */
  String getLocaleNativeDisplayName(String localeName) {
    return null;
  }

  /**
   * Returns the name of the query parameter holding the locale to use, which is
   * defined in the config property {@code locale.queryparam}.
   *
   * @return locale URL query parameter name, or null if none
   */
  String getLocaleQueryParam() {
    return null;
  }

//  /**
//   * @return an implementation of {@link LocalizedNames} for this locale.
//   */
//  LocalizedNames getLocalizedNames() {
//    return new LocalizedNamesImpl(); // GWT.create(LocalizedNamesImpl.class);
//  }

  /**
   * Returns a NumberConstants instance appropriate for this locale.
   */
  NumberConstants getNumberConstants() {
    return new NumberConstantsImpl(); //GWT.create(NumberConstantsImpl.class);
  }

  /**
   * Returns true if any locale supported by this build of the app is RTL.
   */
  bool hasAnyRTL() {
    return false;
  }
}
