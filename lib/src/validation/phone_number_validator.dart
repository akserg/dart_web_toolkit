//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_validation;

/**
 * The PhoneNumberValidator class validates that a string is a valid phone number.
 * A valid phone number contains at least 10 digits, plus additional formatting 
 * characters. The validator does not check if the phone number is an actual 
 * active phone number.
 */
class PhoneNumberValidator extends WidgetValidator {
  
  /**
   * The set of allowable formatting characters.
   * By default equals "()- .+"
   */
  String allowedFormatChars;
  
  /**
   * Minimum number of digits for a valid phone number. A value of null means 
   * this property is ignored.
   * By default equals 10.
   */
  int minDigits;
  
  /**
   * Error message when the value contains invalid characters.
   * By default equals "Your telephone number contains invalid characters."
   */
  String invalidCharError;
  
  /**
   * Error message when the value has fewer than 10 digits.
   * By default equals "Your telephone number must contain at least {minDigits} digits."
   */
  String wrongLengthError;
  
  PhoneNumberValidator(Widget widget, {
    this.minDigits:10,
    this.allowedFormatChars:"()- .+",
    this.invalidCharError:"Your telephone number contains invalid characters.",
    this.wrongLengthError:"Your telephone number must contain at least {minDigits} digits."
    }) : super(widget);
  
  /**
   *  Executes the validation logic of this validator to validate a phone number. 
   *  For an invalid result returns an List of [ValidationResult] 
   *  objects, with one ValidationResult object for each field examined by the 
   *  validator that failed validation.
   *
   *  You must override this method in a subclass of a validator class.
   */
  List<ValidationResult> doValidation(dynamic value) {
    List<ValidationResult> results = super.doValidation(value);

    // Return if there are errors or if the required property is set to false 
    // and length is 0.
    String val = value != null ? value.toString() : "";
    
    if (results.length > 0 || ((val.length == 0) && !required))
      return results;
    else
      return _validatePhoneNumber(value);
  }

  /**
   * Validate [value] and  return List of [ValidationResult] objects, with one
   * ValidationResult object for each field examined by the validator.
   */
  List<ValidationResult> _validatePhoneNumber(dynamic value) {
    List<ValidationResult> results = new List<ValidationResult>();
    
    String valid =  Validator.DECIMAL_DIGITS + allowedFormatChars;
    int len = value.length;
    int digitLen = 0;
    int n;
    int i;
    
    n = allowedFormatChars.length;
    for (i = 0; i < n; i++) {
      if (Validator.DECIMAL_DIGITS.indexOf(allowedFormatChars[i]) != -1) {
        throw new Exception("Invalid format chars");
      }
    }

    for (i = 0; i < len; i++)
    {
      String temp = value.substring(i, i + 1);
      if (valid.indexOf(temp) == -1)
      {
        results.add(new ValidationResult(true, invalidCharError));
        return results;
      }
      if (valid.indexOf(temp) <= 9)
        digitLen++;
    }

    if (minDigits != null && digitLen < minDigits)
    {
      results.add(new ValidationResult(true, substitute(wrongLengthError, '{minDigits}', minDigits)));
      return results;
    }

    return results;
  }
}