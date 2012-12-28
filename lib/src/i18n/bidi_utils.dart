//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Utility functions for performing common Bidi tests on strings.
 */
class BidiUtils {
  
  /**
   * An instance of BidiUtils, to be returned by {@link #get()}.
   */
  static final BidiUtils _INSTANCE = new BidiUtils();
  
  /**
   * Get an instance of BidiUtils.
   * @return An instance of BidiUtils
   */
  static BidiUtils get() {
    return _INSTANCE;
  }
  
  /**
   * A practical pattern to identify strong LTR characters. This pattern is not
   * completely correct according to the Unicode standard. It is simplified
   * for performance and small code size.
   * <p>
   * This is volatile to prevent the compiler from inlining this constant in
   * various references below.
   */
  static String LTR_CHARS = "A-Za-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02B8\u0300-\u0590\u0800-\u1FFF\u2C00-\uFB1C\uFDFE-\uFE6F\uFEFD-\uFFFF";

  /**
   * A practical pattern to identify strong RTL characters. This pattern is not
   * completely correct according to the Unicode standard. It is simplified for
   * performance and small code size.
   * <p>
   * This is volatile to prevent the compiler from inlining this constant in
   * various references below.
   */
  static String RTL_CHARS = "\u0591-\u07FF\uFB1D-\uFDFD\uFE70-\uFEFC";
  
  /**
   * Simplified regular expression for an HTML tag (opening or closing) or an
   * HTML escape. We might want to skip over such expressions when estimating
   * the text directionality.
   */
  static final RegExp SKIP_HTML_RE = new RegExp("<[^>]*>|&[^;]+;", multiLine:true);
  
  /**
   * The name of the element property which controls element directionality.  
   */
//  static final String DIR_PROPERTY_NAME = "dir";
  
  /**
   * The value for the directionality property which will set the element directionality
   * to right-to-left.  
   */
  static final String DIR_PROPERTY_VALUE_RTL = "rtl";
  
  /**
   * The value for the directionality property which will set the element directionality
   * to left-to-right.  
   */
  static final String DIR_PROPERTY_VALUE_LTR = "ltr";
  
  /**
   * Regular expressions to check if the last strongly-directional character in
   * a piece of text is RTL.
   */
  static final RegExp LAST_STRONG_IS_RTL_RE = new RegExp("[${RTL_CHARS}][^${LTR_CHARS}]*");
  
  /**
   * Regular expressions to check if the last strongly-directional character in
   * a piece of text is LTR.
   */
  static final RegExp LAST_STRONG_IS_LTR_RE = new RegExp("[${LTR_CHARS}][^${RTL_CHARS}]*");
  
  /**
   * Returns the input text with spaces instead of HTML tags or HTML escapes, if
   * isStripNeeded is true. Else returns the input as is.
   * Useful for text directionality estimation.
   * Note: the function should not be used in other contexts; it is not 100%
   * correct, but rather a good-enough implementation for directionality
   * estimation purposes.
   */
  String stripHtmlIfNeeded(String str, bool isStripNeeded) {
    return isStripNeeded ? str.replaceAll(SKIP_HTML_RE, " ") : str;
  }
  
  /**
   * Gets the directionality of an element.
   *
   * @param  elem  the element on which to check the directionality property 
   * @return <code>RTL</code> if the directionality is right-to-left,
   *         <code>LTR</code> if the directionality is left-to-right, or
   *         <code>DEFAULT</code> if the directionality is not explicitly set
   */
  static Direction getDirectionOnElement(dart_html.Element elem) {
    String dirPropertyValue = elem.dir;

    if (DIR_PROPERTY_VALUE_RTL == dirPropertyValue.toLowerCase()) {
      return Direction.RTL;
    } else if (DIR_PROPERTY_VALUE_LTR == dirPropertyValue.toLowerCase()) {
      return Direction.LTR;
    }

    return Direction.DEFAULT;
  }
  
  /**
   * Sets the directionality property for an element.
   *
   * @param elem  the element on which to set the property
   * @param direction <code>RTL</code> if the directionality should be set to right-to-left, 
   *                  <code>LTR</code> if the directionality should be set to left-to-right
   *                  <code>DEFAULT</code> if the directionality should be removed from the element   
   */
  static void setDirectionOnElement(dart_html.Element elem, Direction direction) {
    switch (direction) {            
      case Direction.RTL:
        elem.dir = DIR_PROPERTY_VALUE_RTL;
        break;
      case Direction.LTR:
        elem.dir = DIR_PROPERTY_VALUE_LTR;
        break;        
      case Direction.DEFAULT:
        if (getDirectionOnElement(elem) != Direction.DEFAULT) {
          // only clear out the the dir property if it has already been set to something
          // explicitly
          elem.dir = "";
        }
        break;        
    }    
  }
  
  /**
   * Check whether the last strongly-directional character in the string is LTR.
   * @param str the string to check
   * @param isHtml whether str is HTML / HTML-escaped
   * @return whether LTR exit directionality was detected
   */
  bool endsWithLtr(String str, [bool isHtml = false]) {
    if (isHtml) {
      str = stripHtmlIfNeeded(str, isHtml);
    }
    return LAST_STRONG_IS_LTR_RE.hasMatch(str);
  }
  
  /**
   * Check whether the last strongly-directional character in the string is RTL.
   * @param str the string to check
   * @param isHtml whether str is HTML / HTML-escaped
   * @return whether RTL exit directionality was detected
   */
  bool endsWithRtl(String str, [bool isHtml = false]) {
    if (isHtml) {
      str = stripHtmlIfNeeded(str, isHtml);
    }
    return LAST_STRONG_IS_RTL_RE.hasMatch(str);
  }
}
