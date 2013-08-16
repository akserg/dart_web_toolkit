//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_validation;

abstract class WidgetValidator extends Validator {
  
  Widget widget;
  
  WidgetValidator(this.widget) {
    if (widget is HasAllKeyHandlers) {
      (widget as HasAllKeyHandlers).addKeyUpHandler(new KeyUpHandlerAdapter((IEvent evt){ _doValidate(); }));
    }
    if (widget is HasChangeHandlers) {
      (widget as HasChangeHandlers).addChangeHandler(new ChangeHandlerAdapter((IEvent evt){ _doValidate(); }));
    }
  }
  
  ValidationEvent _doValidate() {
    return validate((widget as HasValue).getValue());
  }
  
  /**
   *  Invokes all the validators in the [validators] Array.
   *  Returns true if all validators valid other false. 
   */
  static bool validateAll(List<WidgetValidator> validators) {
    assert(validators != null);

    validators.forEach((WidgetValidator validator) {
      if (validator.enabled) {
        ValidationEvent resultEvent = validator._doValidate();
        
        if (resultEvent.type == ValidationEvent.INVALID)
          return false;
      }

    });
    
    return true;
  }

}