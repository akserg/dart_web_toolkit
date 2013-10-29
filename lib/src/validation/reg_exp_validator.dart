//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_validation;

/**
 * The RegExpValidator class lets you use a regular expression to validate a field. 
 * You pass a regular expression to the validator using the [expression] property, 
 * and additional flags to control the regular expression pattern matching using the [flags] property. 
 *
 * The validation is successful if the validator can find a match of the regular 
 * expression in the field to validate. A validation error occurs when the 
 * validator finds no match.
 */
class RegExpValidator extends WidgetValidator {
  
  RegExp _regExp;
  
  bool _foundMatch = false;
  
  /**
   * The regular expression to use for validation.
   */
  String _expression;
  
  void set expression(String value) {
    _expression = value;
    _createRegExp();
  }
  
  String get expression => _expression;
  
  /**
   * The regular expression multiLine flag to use when matching.
   */
  bool _multiLine = false;
  
  void set multiLine(bool value) {
    _multiLine = value;
    _createRegExp();
  }
  
  bool get multiLine => _multiLine;
  
  /**
   * The regular expression caseSensitive flag to use when matching.
   */
  bool _caseSensitive = true;
  
  void set caseSensitive(bool value) {
    _caseSensitive = value;
    _createRegExp();
  }
  
  bool get caseSensitive => _caseSensitive;
  
  /**
   * Error message when there is no regular expression specifed. 
   * By default value is "The expression is missing."
   */
  String noExpressionError;
  
  /**
   * Error message when there are no matches to the regular expression. 
   * By default value is "The field is invalid."
   */
  String noMatchError;
  
  RegExpValidator(Widget widget, String expression, {
    bool multiLine:false,
    bool caseSensitive:true,
    this.noExpressionError:"The expression is missing.",
    this.noMatchError:"The field is invalid."}) : super(widget) {
    
    this.expression = expression;
    this.multiLine = multiLine;
    this.caseSensitive = caseSensitive;
  }
  
  /**
   * Create RegExp as combination of [expression], [multiLine] and [caseSensitive].
   */
  RegExp _createRegExp() {
    if (_expression != null) {
      _regExp = new RegExp(_expression, multiLine:multiLine, caseSensitive:caseSensitive);
    }
  }
  
  /**
   *  Executes the validation logic of this validatorto validate a regular 
   *  expression. For an invalid result returns an List of [ValidationResult] 
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
      return _validateRegExpression(value);
  }
  
  /**
   * Validate [value] and  return List of [ValidationResult] objects, with one
   * ValidationResult object for each field examined by the validator.
   */
  List<ValidationResult> _validateRegExpression(dynamic value) {
    List<ValidationResult> results = [];
    
    _foundMatch = false;
    
    if (_regExp != null && expression != "") {
      List result = _regExp.allMatches(value.toString()).toList();
      
      result.forEach((Match match){
        results.add(new RegExpValidationResult(false, "", matchedString:match.input, matchedIndex:match.start));
        _foundMatch = true;
      });
      
      if (results.length == 0) {
        results.add(new ValidationResult(true, noMatchError));
      }
    } else {
      results.add(new ValidationResult(true, noExpressionError));
    }
    
    return results;
  }
}

/**
 * The RegExpValidationResult class is a child class of the ValidationResult 
 * class, and contains additional properties used with regular expressions.
 */
class RegExpValidationResult extends ValidationResult {
  
  /**
   * An integer that contains the starting index in the input String of the match.
   */
  final int matchedIndex;
  
  /**
   * A String that contains the substring of the input String that matches the 
   * regular expression.
   */
  final String matchedString;
  
  /**
   * An Array of Strings that contains parenthesized substring matches, if any. 
   * If no substring matches are found, this result is of length 0.
   * Use [matchedSubStrings[0]] to access the first substring match.
   */
  List matchedSubstrings;
  
  RegExpValidationResult(bool isError, String message, {
    this.matchedString: "",
    this.matchedIndex: 0,
    this.matchedSubstrings:null}):super(isError, message);
}