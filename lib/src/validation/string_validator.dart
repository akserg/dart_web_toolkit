//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_validation;

/**
 * The StringValidator class validates that the length of a String is within 
 * a specified range between [minLength] and [maxLength].
 */
class StringValidator extends WidgetValidator {
  
  /** 
   *  Maximum length for a valid String. A value of null means this property 
   *  is ignored. It is equals null by default.
   */
  int maxLength;
  
  /** 
   *  Error message when the String is longer than the [maxLength] property. By
   *  default it's equals "This string is longer than the maximum allowed length. 
   *  This must be less than {0} characters long."
   */
  String tooLongError = "This string is longer than the maximum allowed length. This must be less than {maxLength} characters long.";
  
  /** 
   *  Minimum length for a valid String. A value of NaN means this property 
   *  is ignored. It is equals null by default.
   */
  int minLength;
  
  /** 
   *  Error message when the string is shorter than the [minLength] property. By
   *  default it's equals "This string is shorter than the minimum allowed length. 
   *  This must be at least {0} characters long."
   */
  String tooShortError =  "This string is shorter than the minimum allowed length. This must be at least {minLength} characters long.";
  
  StringValidator(Widget widget, {this.maxLength:null, this.minLength:null}) : super(widget);
  
  /**
   *  Executes the validation logic of this validator, including validating that 
   *  a missing or empty [value] causes a validation error as defined by the 
   *  value of the [required] property. For an invalid result returns an List of 
   *  [ValidationResult] objects, with one ValidationResult object for each 
   *  field examined by the validator that failed validation.
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
      return _validateString(value);
    
    return results;
  }
  
  /**
   * Validate [value] and  return List of [ValidationResult] objects, with one
   * ValidationResult object for each field examined by the validator.
   */
  List<ValidationResult> _validateString(dynamic value) {
    List<ValidationResult> results = [];
    
    String val = value != null ? value.toString() : "";
    if (maxLength != null && val.length > maxLength) {
      results.add(new ValidationResult(true,  tooLongError.replaceFirst(new RegExp(r'{maxLength}'), maxLength.toString())));
    } else if (minLength != null && val.length < minLength) {
      results.add(new ValidationResult(true,  tooShortError.replaceFirst(new RegExp(r'{minLength}'), minLength.toString())));
    }

    return results;
  }
}