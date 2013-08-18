//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_validation;

typedef void ValidationListener(ValidationEvent evt);
typedef void OnValid();
typedef void OnInvalid(List<ValidationResult> results);

abstract class Validator {
  
  /**
   *  A String containing the decimal digits 0 through 9.    
   *  
   *  @langversion 3.0
   *  @playerversion Flash 9
   *  @playerversion AIR 1.1
   *  @productversion Flex 3
   */ 
  static const String DECIMAL_DIGITS = "0123456789";
  
  /**
   * Property to enable/disable validation process.
   * 
   * Setting this value to false will stop the validator from performing 
   * validation. When a validator is disabled, it dispatches no events, and the 
   * [validate] method returns ValidationEvent.VALID instance.
   */
  bool enabled = true;
  
  /**
   * If true specifies that a missing or empty value causes a validation error. 
   */
  bool required = true;
  
  /**
   * Error message when a value is missing and the [required] property is true. 
   *  
   * By default equals "This field is required."
   */
  String requiredError = "This field is required.";
  
  /**
   * List of [ValidationListener]'s
   */
  List<ValidationListener> listeners = new List<ValidationListener>();
  
  /**
   * Callback function invokes when result of validation is valid.
   */
  OnValid onValid;
  
  /**
   * Callback function invokes when result of validation is invalid.
   */
  OnInvalid onInvalid;
  
  /**
   * Performs validation of [value] and notifies the listeners of the result if
   * [fireEvent] equals true.
   */
  ValidationEvent validate(dynamic value, [bool fireEvent = true]) {
    ValidationEvent resultEvent;
    if (enabled && (value != null || required)) {
      // Validate if the target is required or our value is non-null.
      resultEvent = _processValidation(value);
    } else {
      // We assume if value is null and required is false that
      // validation was successful.
      resultEvent = new ValidationEvent(ValidationEvent.VALID);
    }
    // Send notification to listeners
    if (fireEvent && resultEvent != null) {
      listeners.forEach((ValidationListener listener){
        listener(resultEvent);
      });
    }
    // Invoke callback validation functions
    if (onValid != null && resultEvent.type == ValidationEvent.VALID) {
      onValid();
    } else if (onInvalid != null && resultEvent.type == ValidationEvent.INVALID) {
      onInvalid(resultEvent.results);
    }
    return resultEvent;
  }
  
  /**
   * Main internally used function to handle validation process.
   */
  ValidationEvent _processValidation(dynamic value) {
    List errorResults = doValidation(value);
    bool invalid = errorResults.any((ValidationResult res){
      if (res.isError) {
        return true;
      }
      return false;
    });
    return new ValidationEvent(invalid ? 
        ValidationEvent.INVALID : 
        ValidationEvent.VALID, errorResults);
  }
  
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
    List<ValidationResult> results = [];
    
    ValidationResult result = _validateRequired(value);
    if (result != null)
      results.add(result);
    
    return results;
  }
  
  /**
   *  Determines if an object is valid based on its [required] property.
   */
  ValidationResult _validateRequired(dynamic value) {
    if (required) {
      String val = (value != null) ? value.toString() : "";

      val = val.trim();

      // If the string is empty and required is set to true then throw a requiredError.
      if (val.length == 0) {
        return new ValidationResult(true, requiredError);                 
      }
    }
    
    return null;
  }
}

/**
 *  The [ValidationResultEvent] class defines the event object that is passed 
 *  to event listeners for the [valid] and [invalid] validator events. 
 */
class ValidationEvent {
  
  static const String VALID = "valid";
  static const String INVALID = "invalid";
  
  /**
   * Event type
   */
  final String type;
  
  /**
   * The property, which contains an Array of ValidationResult objects, 
   * one for each field examined by the validator.
   */
  final List<ValidationResult> results;
  
  /**
   * Create an instance of ValidationEvent of specified [type] and [results]. 
   */
  ValidationEvent(this.type, [this.results = null]);
}

/**
 * The ValidationResult class contains the results of a validation. 
 */
class ValidationResult {
  
  /**
   * Pass true if there was a validation error.
   */
  final bool isError;
  
  /**
   * Validation error message.
   */
  final String message;
  
  /**
   * Create new instance of [ValidationResult]. You might specify [isError] if
   * validation process finished with error and pass throug result [message].
   */
  ValidationResult(this.isError, this.message);
  
  /**
   * Use [message] content to convert that instance to String.
   */
  String toString() {
    return message == null ? "" : message;
  }
}

/**
 * Convinient method to substitute string with named parameters. Method find 
 * the parameter [from] in curly brackets and change it [to] value converted to 
 * string.
 */
String substitute(String input, String from, dynamic to) {
  return input.replaceFirst(new RegExp(from), to.toString());
}