//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_validation;

/**
 * The SocialSecurityNumberValidator class validates that a String is a valid United 
 * States Social Security number. It does not check whether it is an existing 
 * Social Security number.
 */
class SocialSecurityNumberValidator extends WidgetValidator {
  
  /**
   * Specifies the set of formatting characters allowed in the input.
   * By default equals "-"
   */
  String allowedFormatChars;
  
  /**
   * Error message when the value contains characters other than digits and 
   * formatting characters defined by the [allowedFormatChars] property.
   * By default equals "You entered invalid characters in your Social Security number."
   */
  String invalidCharError;
  
  /**
   * Error message when the value is incorrectly formatted.
   * By default equals "The Social Security number must be 9 digits or in the form NNN-NN-NNNN."
   */
  String wrongFormatError;
  
  /**
   * Error message when the value contains an invalid Social Security number.
   * By default equals "Invalid Social Security number; not allowed all zeros in any digit group."
   */
  String zeroGroupError;
  
  /**
   * Error message when the value contains an invalid Social Security number.
   * By default equals "Invalid Social Security number; not allowed Area Numbers 666 and 900-999."
   */
  String wrongAreaError;
  
  SocialSecurityNumberValidator(Widget widget, {
    this.allowedFormatChars:"-",
    this.invalidCharError:"You entered invalid characters in your Social Security number.",
    this.wrongFormatError:"The Social Security number must be 9 digits or in the form NNN-NN-NNNN.",
    this.zeroGroupError:"Invalid Social Security number; not allowed all zeros in any digit group.",
    this.wrongAreaError:"Invalid Social Security number; not allowed Area Numbers 666 and 900-999."
    }) : super(widget);
  
  /**
   *  Executes the validation logic of this validator to validate a Social Security number. 
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
      return _validateSocialSecurity(value);
  }
  
  /**
   * Validate [value] and  return List of [ValidationResult] objects, with one
   * ValidationResult object for each field examined by the validator.
   */
  List<ValidationResult> _validateSocialSecurity(dynamic value) {
    List<ValidationResult> results = new List<ValidationResult>();
    
    // Resource-backed properties of the validator.
    int len = value.length;
    bool checkForFormatChars = false;

    if ((len != 9) && (len != 11)) {
      results.add(new ValidationResult(true, wrongFormatError));
      return results;
    }

    for (int i = 0; i < allowedFormatChars.length; i++) {
      if (Validator.DECIMAL_DIGITS.indexOf(allowedFormatChars[i]) != -1) {
        throw new Exception("Invalid format chars");
      }
    }

    if (len == 11)
      checkForFormatChars = true;

    for (int i = 0; i < len; i++) {
      String allowedChars;
      if (checkForFormatChars && (i == 3 || i == 6))
        allowedChars = allowedFormatChars;
      else
        allowedChars = Validator.DECIMAL_DIGITS;

      if (allowedChars.indexOf(value[i]) == -1) {
        results.add(new ValidationResult(true, invalidCharError));
        return results;
      }
    }
    
    String _value = value.replaceAll("-", "");
    String area = _value.substring(0, 3);
    String group = _value.substring(3, 5);
    String serial = _value.substring(5, 9);

    // Not allowed are SSNs with all zeros in any digit group 
    // (000-xx-####, ###-00-####, ###-xx-0000).
    if (area == "000" ||
        group == "00" ||
        serial == "0000") {
      results.add(new ValidationResult(true, zeroGroupError));
      return results;
    }
    
    // Not allowed are SSNs with Area Numbers 000, 666 and 900-999.
    int areaNumber = int.parse(area);
    if (areaNumber == 666 ||
        (areaNumber >= 900 && areaNumber <= 999)) {
      results.add(new ValidationResult(true, wrongAreaError));
      return results;
    }
    
    return results;
  }
}