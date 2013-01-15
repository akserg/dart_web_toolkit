//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

abstract class DomHelper {

  /**
   * Create instance of [DomHelper] depends on broswer.
   */
  factory DomHelper.browserDependent() {
    return new DomHelperDefault();
  }
  
  //*************************
  // Parent - child relations
  //*************************
  
  bool isOrHasChild(dart_html.Node parent, dart_html.Node child);

  void insertChild(dart_html.Element parent, dart_html.Element child, int index);
  
  //********************
  // Position of Element
  //********************
  
  int getAbsoluteLeft(dart_html.Element elem);

  int getAbsoluteTop(dart_html.Element elem);

  //*********
  // Capturte
  //*********

  void releaseCapture(dart_html.Element elem);

  void setCapture(dart_html.Element elem);

  //*******
  // Events
  //*******

  void setEventListener(dart_html.Element elem, EventListener listener);
  
  void sinkBitlessEvent(dart_html.Element elem, String eventTypeName);

  void sinkEvents(dart_html.Element elem, Set<String> eventBits);
  
  void unsinkEvents(dart_html.Element elem, Set<String> eventBits);
  
  Set<String> getEventsSunk(dart_html.Element elem);
}
