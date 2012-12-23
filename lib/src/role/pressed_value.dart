//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_role;

/**
 * State enum for 'aria-pressed' values.
 */
class PressedValue<int> extends Enum<int> implements AriaAttributeType {
  
  //, FALSE, MIXED, UNDEFINED;
  static const PressedValue TRUE = const PressedValue(0);
  static const PressedValue FALSE = const PressedValue(1);
  static const PressedValue MIXED = const PressedValue(2);
  static const PressedValue UNDEFINED = const PressedValue(3);
  
  const PressedValue(int type) : super (type);
  
  /**
   * Gets the enum constant corresponding to {@code value} for the token type
   * PressedValue.
   *
   * @param value Boolean value for which we want to get the corresponding enum constant.
   */
  static PressedValue of(bool value) {
    return value ? TRUE : FALSE;
  }
  
  String getAriaValue() {
    switch (this) {
        case TRUE:
          return "true";
        case FALSE:
          return "false";
        case MIXED:
          return "mixed";
        case UNDEFINED:
          return "undefined";
    }
    return null; // not reachable
  }
}
