//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * Utility class containing static methods for escaping and sanitizing strings.
 */
class SafeHtmlUtils {

  /**
   * Returns a {@link SafeHtml} constructed from a trusted string, i.e., without
   * escaping the string. No checks are performed. The calling code should be
   * carefully reviewed to ensure the argument meets the {@link SafeHtml} contract.
   *
   * @param s the input String
   * @return a {@link SafeHtml} instance
   */
  static SafeHtml fromTrustedString(String s) {
    return new SafeHtmlString(s);
  }
}