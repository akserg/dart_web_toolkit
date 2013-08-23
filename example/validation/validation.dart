library validation_example;

import 'dart:html' as dart_html;

import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/validation.dart' as validation;

void main() {
  dart_html.query("#loading").remove();
  
  //********************************************
  // String Validation based on callback methods
  //********************************************
  
  ui.Label stringLabel = new ui.Label("String validation with callbacks (length between 2 and 5)");
  ui.TextBox stringInput = new ui.TextBox();
  ui.Label stringValidationMessage = new ui.Label();
  //
  validation.Validator stringValidator = new validation.StringValidator(stringInput, minLength:2, maxLength:5);
  stringValidator.onValid = () {
    stringInput.removeStyleName("error-field");
    stringValidationMessage.text = "";
  };
  stringValidator.onInvalid = (List<validation.ValidationResult> results) {
    stringInput.addStyleName("error-field");
    stringValidationMessage.text = results.join("\n"); 
  };
  
  ui.RootPanel.get().add(stringLabel);
  ui.RootPanel.get().add(stringInput);
  ui.RootPanel.get().add(stringValidationMessage);
  
  ui.RootPanel.get().add(new ui.Html("<br/>"));
  
  
  //*************************************
  // String Validation based on Listeners
  //*************************************
  
  ui.Label stringLabel2 = new ui.Label("String validation with listeners (length between 2 and 5)");
  ui.TextBox stringInput2 = new ui.TextBox();
  ui.Label stringValidationMessage2 = new ui.Label();
  //
  validation.Validator stringValidator2 = new validation.StringValidator(stringInput2, minLength:2, maxLength:5);
  // Listeners
  stringValidator2.listeners.add((validation.ValidationEvent evt){
    if (evt.type == validation.ValidationEvent.VALID) {
      stringInput2.removeStyleName("error-field");
      stringValidationMessage2.text = "";
    } else {
      stringInput2.addStyleName("error-field");
      stringValidationMessage2.text = evt.results.join("\n");
    }
  });
  
  ui.RootPanel.get().add(stringLabel2);
  ui.RootPanel.get().add(stringInput2);
  ui.RootPanel.get().add(stringValidationMessage2);
  
  ui.RootPanel.get().add(new ui.Html("<br/>"));
  
  
  //******************
  // Number Validation
  //******************
  
  ui.Label numberLabel = new ui.Label("Number validation (value between 2 and 20)");
  ui.TextBox numberInput = new ui.TextBox();
  ui.Label numberValidationMessage = new ui.Label();
  //
  validation.Validator numberValidator = new validation.NumberValidator(numberInput, minValue:2, maxValue:20);
  numberValidator.onValid = () {
    numberInput.removeStyleName("error-field");
    numberValidationMessage.text = "";
  };
  numberValidator.onInvalid = (List<validation.ValidationResult> results) {
    numberInput.addStyleName("error-field");
    numberValidationMessage.text = results.join("\n"); 
  };
  
  ui.RootPanel.get().add(numberLabel);
  ui.RootPanel.get().add(numberInput);
  ui.RootPanel.get().add(numberValidationMessage);
  
  ui.RootPanel.get().add(new ui.Html("<br/>"));
  
  //******************
  // RegExp Validation
  //******************
  
  String emailValidationString = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  ui.Label regExpLabel = new ui.Label("RegExp email validation");
  ui.TextBox regExpInput = new ui.TextBox();
  ui.Label regExpValidationMessage = new ui.Label();
  //
  
  ui.RootPanel.get().add(new ui.Html("<br/>"));
  validation.Validator regExpValidator = new validation.RegExpValidator(regExpInput, emailValidationString);
  regExpValidator.onValid = () {
    regExpInput.removeStyleName("error-field");
    regExpValidationMessage.text = "";
  };
  regExpValidator.onInvalid = (List<validation.ValidationResult> results) {
    regExpInput.addStyleName("error-field");
    regExpValidationMessage.text = results.join("\n"); 
  };
  
  ui.RootPanel.get().add(regExpLabel);
  ui.RootPanel.get().add(regExpInput);
  ui.RootPanel.get().add(regExpValidationMessage);
  
  ui.RootPanel.get().add(new ui.Html("<br/>"));

  //**************************************************
  // Phone Number Validation based on callback methods
  //**************************************************
  
  ui.Label phoneNumberLabel = new ui.Label("Phone Number validation (length more then 8 numbers)");
  ui.TextBox phoneNumberInput = new ui.TextBox();
  ui.Label phoneNumberValidationMessage = new ui.Label();
  //
  validation.Validator phoneNumberValidator = new validation.PhoneNumberValidator(phoneNumberInput, minDigits:8);
  phoneNumberValidator.onValid = () {
    phoneNumberInput.removeStyleName("error-field");
    phoneNumberValidationMessage.text = "";
  };
  phoneNumberValidator.onInvalid = (List<validation.ValidationResult> results) {
    phoneNumberInput.addStyleName("error-field");
    phoneNumberValidationMessage.text = results.join("\n"); 
  };
  
  ui.RootPanel.get().add(phoneNumberLabel);
  ui.RootPanel.get().add(phoneNumberInput);
  ui.RootPanel.get().add(phoneNumberValidationMessage);
  
  ui.RootPanel.get().add(new ui.Html("<br/>"));
  
  //************************************************
  // SSN Number Validation based on callback methods
  //************************************************
  
  ui.Label ssnNumberLabel = new ui.Label("SSN Number validation (XXXXXXXXX or XXX-XX-XXXX)");
  ui.TextBox ssnNumberInput = new ui.TextBox();
  ui.Label ssnNumberValidationMessage = new ui.Label();
  //
  validation.Validator ssnNumberValidator = new validation.SocialSecurityNumberValidator(ssnNumberInput);
  ssnNumberValidator.onValid = () {
    ssnNumberInput.removeStyleName("error-field");
    ssnNumberValidationMessage.text = "";
  };
  ssnNumberValidator.onInvalid = (List<validation.ValidationResult> results) {
    ssnNumberInput.addStyleName("error-field");
    ssnNumberValidationMessage.text = results.join("\n"); 
  };
  
  ui.RootPanel.get().add(ssnNumberLabel);
  ui.RootPanel.get().add(ssnNumberInput);
  ui.RootPanel.get().add(ssnNumberValidationMessage);
  
  ui.RootPanel.get().add(new ui.Html("<br/>"));

  //*****************
  // Group Validation
  //*****************
  
  ui.Button submitButton = new ui.Button("Validate & Submit");
  submitButton.addClickHandler(new event.ClickHandlerAdapter((event.ClickEvent evt){
    if (validation.WidgetValidator.validateAll([stringValidator, numberValidator, 
                                                regExpValidator, phoneNumberValidator,
                                                ssnNumberValidator])) {
      dart_html.window.alert("Message sent because all fields valid.");
    }
  }));
  ui.RootPanel.get().add(submitButton);
}