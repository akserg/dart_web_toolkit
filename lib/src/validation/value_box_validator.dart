//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_validation;

class IntegerBoxValidator extends Validator<ui.IntegerBox> {
  
  IntegerBoxValidator(ui.IntegerBox widget, {OnSuccess onSuccess:null, OnError onError:null}) : super(widget, onSuccess:onSuccess, onError:onError);
  
  Validator validate() {
    try {
      widget.getValueOrThrow();
      return onSuccess(widget);
    } on Exception catch(ex) {
      return onError(widget, ex);
    }
  }
}

class DoubleBoxValidator extends Validator<ui.DoubleBox> {
  
  DoubleBoxValidator(ui.DoubleBox widget, {OnSuccess onSuccess:null, OnError onError:null}) : super(widget, onSuccess:onSuccess, onError:onError);
  
  Validator validate() {
    try {
      widget.getValueOrThrow();
      return onSuccess(widget);
    } on Exception catch(ex) {
      return onError(widget, ex);
    }
  }
}