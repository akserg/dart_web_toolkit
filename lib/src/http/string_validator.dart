//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_http;

/**
 * Utility class for validating strings.
 * 
 * TODO(mmendez): Is there a better place for this?
 */
class StringValidator {
  /**
   * Returns true if the string is empty or null.
   * 
   * @param string to test if null or empty
   * 
   * @return true if the string is empty or null
   */
  static bool isEmptyOrNullString(String string) {
    return (string == null) || (0 == string.trim().length);
  }

  /**
   * Throws if <code>value</code> is <code>null</code> or empty. This method
   * ignores leading and trailing whitespace.
   * 
   * @param name the name of the value, used in error messages
   * @param value the string value that needs to be validated
   * 
   * @throws IllegalArgumentException if the string is empty, or all whitespace
   * @throws NullPointerException if the string is <code>null</code>
   */
  static void throwIfEmptyOrNull(String name, String value) {
    assert (name != null);
    assert (name.trim().length != 0);

    throwIfNull(name, value);

    if (0 == value.trim().length) {
      throw new Exception("$name cannot be empty");
    }
  }

  /**
   * Throws a {@link NullPointerException} if the value is <code>null</code>.
   * 
   * @param name the name of the value, used in error messages
   * @param value the value that needs to be validated
   * 
   * @throws NullPointerException if the value is <code>null</code>
   */
  static void throwIfNull(String name, Object value) {
    if (null == value) {
      throw new Exception("$name cannot be null");
    }
  }
}
