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
  bool allowNegative;
  
  /**
   * The character used to separate the whole from the fractional part of the 
   * number. Cannot be a digit and must be distinct from the [thousandsSeparator].
   * By default equals "."
   */
  String decimalSeparator;
  
  /**
   * Type of number to be validated. 
   * Permitted values are [NumberValidator.INTEGER] and [NumberValidator.DOUBLE].
   * By default equals [NumberValidator.DOUBLE].
   */
  String domain;
  
  /**
   * Maximum value for a valid number. A value of null means there is no maximum.
   */
  num maxValue;
  
  /**
   * Minimum value for a valid number. A value of null means there is no minimum.
   */
  num minValue;
  
  /**
   * The maximum number of digits allowed to follow the decimal point.
   * Can be any nonnegative integer.
   */
  int precision;
  
  /**
   * The character used to separate thousands in the whole part of the number.
   * Cannot be a digit and must be distinct from the [decimalSeparator].
   */
  String thousandsSeparator;
  
  /**
   * Error message when the decimal separator character occurs more than once.
   * By default equals "The decimal separator can occur only once."
   */
  String decimalPointCountError;
  
  /**
   * Error message when the value exceeds the [maxValue] property.
   * By default equals "The number entered is too large."
   */
  String exceedsMaxError;
  
  /**
   * Error message when the number must be an integer, as defined by the 
   * [domain] property.
   * By default it's equals "The number must be an integer." 
   */
  String integerError;
  
  /**
   * Error message when the value contains invalid characters.
   *
   * By default it equals "The input contains invalid characters."
   */
  String invalidCharError;
      
  /**
   * Error message when the value contains invalid format characters, which 
   * means that it contains a digit or minus sign (-) as a separator character, 
   * or it contains two or more consecutive separator characters.
   *
   * By default it equals "One of the formatting parameters is invalid."
   */
  String invalidFormatCharsError;
  
  /**
   * Error message when the value is less than [minValue].
   *
   * By default it equals "The amount entered is too small."
   */
  String lowerThanMinError;
  
  /**
   * Error message when the value is negative and the [allowNegative] 
   * property is [false].
   *
   * By default it equals "The amount may not be negative."
   */
  String negativeError;
  
  /**
   * Error message when the value has a precision that exceeds the value defined 
   *  by the precision property.
   *
   *  By "default" it equals "The amount entered has too many digits beyond the decimal point."
   */
  String precisionError;
  
  /**
   * Error message when the thousands separator is in the wrong location.
   *
   * By default it equals "The thousands separator must be followed by three digits."
   */
  String separationError;
  
  NumberValidator(Widget widget, {
    this.allowNegative:true,
    this.decimalPointCountError:"The decimal separator can only occur once.",
    this.decimalSeparator:".",
    this.domain:NumberValidator.DOUBLE,
    this.exceedsMaxError:"The number entered is too large.",
    this.integerError:"The number must be an integer.",
    this.invalidCharError:"The input contains invalid characters.",
    this.invalidFormatCharsError:"One of the formatting parameters is invalid.",
    this.lowerThanMinError:"The amount entered is too small.",
    this.maxValue:null,
    this.minValue:null,
    this.negativeError:"The amount may not be negative.",
    this.precision:-1,
    this.precisionError:"The amount entered has too many digits beyond the decimal point.",
    this.separationError:"The thousands separator must be followed by three digits.",
    this.thousandsSeparator:","}) : super(widget);
  
  /**
   *  Override of the base class [doValidation()] method 
   *  to validate a number.
   *
   *  <p>You do not call this method directly;
   *  Flex calls it as part of performing a validation.
   *  If you create a custom Validator class, you must implement this method. </p>
   *
   *  @param value Object to validate.
   *
   *  @return An Array of ValidationResult objects, with one ValidationResult 
   *  object for each field examined by the validator. 
   *  
   *  @langversion 3.0
   *  @playerversion Flash 9
   *  @playerversion AIR 1.1
   *  @productversion Flex 3
   */
  
  /**
   *  Executes the validation logic of this validatorto validate a number. 
   *  Invalid result returns an List of [ValidationResult] objects, with one 
   *  ValidationResult object for each field examined by the validator that 
   *  failed validation.
   *
   *  You must override this method in a subclass of a validator class.
   */
  List<ValidationResult> doValidation(dynamic value) {
    List<ValidationResult> results = super.doValidation(value);
  
    // Return if there are errors
    // or if the required property is set to [false] and length is 0.
    String val = value != null? value.toString() : "";
    if (results.length > 0 || ((val.length == 0) && !required))
      return results;
    else
        return _validateNumber(value);
  }

  /**
   * Validate [value] and  return List of [ValidationResult] objects, with one
   * ValidationResult object for each field examined by the validator.
   */
  List<ValidationResult> _validateNumber(dynamic value) {
    List<ValidationResult> results = [];
    
    String input = value.toString();
    int len = input.length;

    bool isNegative = false;
    
    int i;
    String c;

    // Make sure the formatting character parameters are unique,
    // are not digits or the negative sign,
    // and that the separators are one character.
    String invalidFormChars = Validator.DECIMAL_DIGITS + "-";
        
    if (decimalSeparator == thousandsSeparator ||
        invalidFormChars.indexOf(decimalSeparator) != -1 ||
        invalidFormChars.indexOf(thousandsSeparator) != -1 ||
        decimalSeparator.length != 1 ||
        thousandsSeparator.length != 1) {
      results.add(new ValidationResult(true, invalidFormatCharsError));
      return results;
    }
    
    // Check for invalid characters in input.
    String validChars = Validator.DECIMAL_DIGITS + "-" + decimalSeparator + thousandsSeparator;
    for (i = 0; i < len; i++) {
      c = input[i];
      if (validChars.indexOf(c) == -1) {
        results.add(new ValidationResult(true, invalidCharError));
        return results;
      }
    }
    
    // Check if the input is negative.
    if (input[0] == "-") {
      if (len == 1) {
        // we have only '-' char
        results.add(new ValidationResult(true, invalidCharError));
        return results;
      } else if (len == 2 && input[1] == '.') {
        // handle "-."
        results.add(new ValidationResult(true, invalidCharError));
        return results;
      }

      // Check if negative input is allowed.
      if (!allowNegative) {
        results.add(new ValidationResult(true, negativeError));
        return results;
      }

      // Strip off the minus sign, update some variables.
      input = input.substring(1);
      len--;
      isNegative = true;
    }
    
    // Make sure there's only one decimal point.
    if (input.indexOf(decimalSeparator) != input.lastIndexOf(decimalSeparator)) {
      results.add(new ValidationResult(true, decimalPointCountError));
      return results;
    }
    
    // Make sure every character after the decimal is a digit,
    // and that there aren't too many digits after the decimal point:
    // if domain is int there should be none,
    // otherwise there should be no more than specified by precision.
    int decimalSeparatorIndex = input.indexOf(decimalSeparator);
    if (decimalSeparatorIndex != -1) {
      int numDigitsAfterDecimal = 0;

      if (i == 1 && i == len) {
        // we only have a '.'
        results.add(new ValidationResult(true, invalidCharError));
        return results;
      }
      
      for (i = decimalSeparatorIndex + 1; i < len; i++) {
        // This character must be a digit.
        if (Validator.DECIMAL_DIGITS.indexOf(input[i]) == -1) {
          results.add(new ValidationResult(true, invalidCharError));
          return results;
        }

        ++numDigitsAfterDecimal;

        // There may not be any non-zero digits after the decimal
        // if domain is int.
        if (domain == NumberValidator.INTEGER && input[i] != "0") {
          results.add(new ValidationResult(true, integerError));
          return results;
        }

        // Make sure precision is not exceeded.
        if (precision != -1 && numDigitsAfterDecimal > precision) {
          results.add(new ValidationResult(true, precisionError));
          return results;
        }
      }
    }
    
    // Make sure the input begins with a digit or a decimal point.
    if (Validator.DECIMAL_DIGITS.indexOf(input[0]) == -1 && input[0] != decimalSeparator) {
      results.add(new ValidationResult(true, invalidCharError));
      return results;
    }
    
    // Make sure that every character before the decimal point
    // is a digit or is a thousands separator.
    // If it's a thousands separator,
    // make sure it's followed by three consecutive digits.
    int end = decimalSeparatorIndex == -1 ? len : decimalSeparatorIndex;
    for (i = 1; i < end; i++) {
      c = input[i];
      if (c == thousandsSeparator) {
        if (c == thousandsSeparator) {
          if ((end - i != 4 &&
              input[i + 4] != thousandsSeparator) ||
              Validator.DECIMAL_DIGITS.indexOf(input[i + 1]) == -1 ||
              Validator.DECIMAL_DIGITS.indexOf(input[i + 2]) == -1 ||
              Validator.DECIMAL_DIGITS.indexOf(input[i + 3]) == -1) {
            results.add(new ValidationResult(true, separationError));
            return results;
          }
        }
      } else if (Validator.DECIMAL_DIGITS.indexOf(c) == -1) {
        results.add(new ValidationResult(true, invalidCharError));
        return results;
      }
    }
    
    // Make sure the input is within the specified range.
    if (minValue != null || maxValue != null) {
      // First strip off the thousands separators.
      for (i = 0; i < end; i++) {
        if (input[i] == thousandsSeparator) {
          String left = input.substring(0, i);
          String right = input.substring(i + 1);
          input = left + right;
        }
      }

      // Translate the value back into standard english
      // If the decimalSeperator is not '.' we need to change it to '.' 
      // so that the number casting will work properly
      if (decimalSeparator != '.') {
        int dIndex = input.indexOf(decimalSeparator);
        if (dIndex != -1) { 
          String dLeft = input.substring(0, dIndex);
          String dRight = input.substring(dIndex + 1);
          input = dLeft + '.' + dRight;
        }
      }

      // Check bounds
      double x = double.parse(input, (String source) => 0.0);

      if (isNegative)
          x = -x;

      if (minValue != null && x < minValue) {
        results.add(new ValidationResult(true, lowerThanMinError));
        return results;
      }
            
      if (maxValue != null && x > maxValue) {
        results.add(new ValidationResult(true, exceedsMaxError));
        return results;
      }
    }
    
    return results;
  }
}