//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

abstract class DomHelper {

  /**
   * Create instance of [DomHelper] depends on broswer.
   */
  factory DomHelper.browserDependent() {
    return new DomHelperDefault();
  }

  DomHelper();
  
  static bool eventSystemIsInitialized = false;

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

  void maybeInitializeEventSystem() {
    if (!eventSystemIsInitialized) {
      initEventSystem();
      eventSystemIsInitialized = true;
    }
  }
  
  /**
   * Initializes the event dispatch system.
   */
  void initEventSystem();
  
  void setEventListener(dart_html.Element elem, EventListener listener);

  void sinkBitlessEvent(dart_html.Element elem, String eventTypeName);

  void sinkEvents(dart_html.Element elem, int eventBits);

  int getEventsSunk(dart_html.Element elem) {
    return _getEventBits(elem);
  }
  
  int _getEventBits(dart_html.Element elem) {
    assert(elem != null);
    String eventBits = elem.dataAttributes["eventBits"];
    if (eventBits != null) {
      try {
        return int.parse(eventBits);
      } on Exception catch(e) {}
    }
    return 0;
  }

  void _setEventBits(dart_html.Element elem, int bits) {
    assert(elem != null);
    assert(bits != null);
    elem.dataAttributes["eventBits"] = bits.toRadixString(16);
  }

  dart_html.Element eventGetToElement(dart_html.Event evt);

  int getEventTypeInt(dart_html.Event evt) {
    return eventGetTypeInt(evt.type);
  }
  
  int eventGetTypeInt(String eventType) {
    switch (eventType) {
      case "blur": return 0x01000;
      case "change": return 0x00400;
      case "click": return 0x00001;
      case "dblclick": return 0x00002;
      case "focus": return 0x00800;
      case "keydown": return 0x00080;
      case "keypress": return 0x00100;
      case "keyup": return 0x00200;
      case "load": return 0x08000;
      case "losecapture": return 0x02000;
      case "mousedown": return 0x00004;
      case "mousemove": return 0x00040;
      case "mouseout": return 0x00020;
      case "mouseover": return 0x00010;
      case "mouseup": return 0x00008;
      case "scroll": return 0x04000;
      case "error": return 0x10000;
      case "mousewheel": return 0x20000;
      case "DOMMouseScroll": return 0x20000;
      case "contextmenu": return 0x40000;
      case "paste": return 0x80000;
      case "touchstart": return 0x100000;
      case "touchmove": return 0x200000;
      case "touchend": return 0x400000;
      case "touchcancel": return 0x800000;
//      case "gesturestart": return 0x1000000;
//      case "gesturechange": return 0x2000000;
//      case "gestureend": return 0x4000000;
      default: return -1;
    }
  }
  
  dart_html.Event createHtmlEvent(String type, bool canBubble, bool cancelable);
}
