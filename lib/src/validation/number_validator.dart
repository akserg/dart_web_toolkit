//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_validation;

/**
 * The NumberValidator class ensures that a String represents a valid number.
 * It can ensure that the input falls:
 * - within a given range (specified by [minValue] and [maxValue]),
 * - is an integer (specified by [domain]),
 * - is non-negative (specified by [allowNegative]),
 * - does not exceed the specified [precision].
 * 
 * The validator correctly validates formatted numbers (e.g., "12,345.67")
 * and you can customize the [thousandsSeparator] and
 * [decimalSeparator] properties for internationalization.
 */
class NumberValidator extends WidgetValidator {
  
  static const String INTEGER = "integer";
  static const String DOUBLE = "double";
  
  /**
   * Specifies whether negative numbers are permitted.
   * Allowed by default.
   */
  bool allowNegative = true;
  
  /**
   * The character used to separate the whole from the fractional part of the 
   * number. Cannot be a digit and must be distinct from the [thousandsSeparator].
   * By default equals "."
   */
  String decimalSeparator = ".";
  
  /**
   * Type of number to be validated. 
   * Permitted values are [NumberValidator.INTEGER] and [NumberValidator.DOUBLE].
   * By default equals [NumberValidator.DOUBLE].
   */
  String numberType = DOUBLE;
  
  /**
   * Maximum value for a valid number. A value of null means there is no maximum.
   */
  dynamic maxValue;
  
  /**
   * Minimum value for a valid number. A value of null means there is no minimum.
   */
  dynamic minValue;
  
  /**
   * The maximum number of digits allowed to follow the decimal point.
   * Can be any nonnegative integer.
   */
  int precision;
  
  /**
   * The character used to separate thousands in the whole part of the number.
   * Cannot be a digit and must be distinct from the [decimalSeparator].
   */
  String thousandsSeparator = ",";
  
  /**
   * Error message when the decimal separator character occurs more than once.
   * By default equals "The decimal separator can occur only once."
   */
  String decimalPointCountError = "The decimal separator can occur only once.";
  
  /**
   * Error message when the value exceeds the <code>maxValue</code> property.
   * By default equals "The number entered is too large."
   */
  String exceedsMaxError = "The number entered is too large.";
  
  NumberValidator(Widget widget) : super(widget);
}