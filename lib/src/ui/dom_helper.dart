//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_mob_ui;

abstract class DomHelper {

  /**
   * Create instance of [DomHelper] depends on broswer.
   */
  factory DomHelper.browserDependent() {
    return new DomHelperDefault();
  }
  
  
  void setEventListener(dart_html.Element elem, EventListener listener);
  
  int getAbsoluteLeft(dart_html.Element elem);
  
  int getAbsoluteTop(dart_html.Element elem);
  
}
