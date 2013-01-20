//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Constant strings representing browser events.
 */
class BrowserEvents {
  static const String BLUR = "blur";
  static const String CANPLAYTHROUGH = "canplaythrough";
  static const String CHANGE = "change";
  static const String CLICK = "click";
  static const String CONTEXTMENU = "contextmenu";
  static const String DBLCLICK = "dblclick";
  static const String DRAG = "drag";
  static const String DRAGEND = "dragend";
  static const String DRAGENTER = "dragenter";
  static const String DRAGLEAVE = "dragleave";
  static const String DRAGOVER = "dragover";
  static const String DRAGSTART = "dragstart";
  static const String DROP = "drop";
  static const String ENDED = "ended";
  static const String ERROR = "error";
  static const String FOCUS = "focus";
  static const String FOCUSIN = "focusin";
  static const String FOCUSOUT = "focusout";
  static const String GESTURECHANGE = "gesturechange";
  static const String GESTUREEND = "gestureend";
  static const String GESTURESTART = "gesturestart";
  static const String KEYDOWN = "keydown";
  static const String KEYPRESS = "keypress";
  static const String KEYUP = "keyup";
  static const String LOAD = "load";
  static const String LOSECAPTURE = "losecapture";
  static const String MOUSEDOWN = "mousedown";
  static const String MOUSEMOVE = "mousemove";
  static const String MOUSEOUT = "mouseout";
  static const String MOUSEOVER = "mouseover";
  static const String MOUSEUP = "mouseup";
  static const String MOUSEWHEEL = "mousewheel";
  static const String PROGRESS = "progress";
  static const String SCROLL = "scroll";
  static const String TOUCHCANCEL = "touchcancel";
  static const String TOUCHEND = "touchend";
  static const String TOUCHMOVE = "touchmove";
  static const String TOUCHSTART = "touchstart";

  static const List<String> events = const [BLUR, CANPLAYTHROUGH, CHANGE, CLICK, 
       CONTEXTMENU, DBLCLICK, DRAG, DRAGEND, DRAGENTER, DRAGLEAVE, DRAGOVER, 
       DRAGSTART, DROP, ENDED, ERROR, FOCUS, FOCUSIN, FOCUSOUT, GESTURECHANGE, 
       GESTUREEND, GESTURESTART, KEYDOWN, KEYPRESS, KEYUP, LOAD, LOSECAPTURE, 
       MOUSEDOWN, MOUSEMOVE, MOUSEOUT, MOUSEOVER, MOUSEUP, MOUSEWHEEL, PROGRESS, 
       SCROLL, TOUCHCANCEL, TOUCHEND, TOUCHMOVE, TOUCHSTART];
  
  /**
   * A bit-mask covering both focus events (focus and blur).
   */
  static const List<String> FOCUSEVENTS = const [FOCUS, BLUR];

  /**
   * A bit-mask covering all keyboard events (down, up, and press).
   */
  static const List<String> KEYEVENTS = const [KEYDOWN, KEYPRESS, KEYUP];

  /**
   * A bit-mask covering all mouse events (down, up, move, over, and out), but
   * not click, dblclick, or wheel events.
   */
  static const List<String> MOUSEEVENTS = const [MOUSEDOWN, MOUSEUP, MOUSEMOVE, MOUSEOVER, MOUSEOUT];

  /**
   * A bit-mask covering all touch events (start, move, end, cancel).
   */
  static const List<String> TOUCHEVENTS = const [TOUCHSTART, TOUCHMOVE, TOUCHEND, TOUCHCANCEL];

  /**
   * A bit-mask covering all gesture events (start, change, end).
   */
  static const List<String> GESTUREEVENTS = const [GESTURESTART, GESTURECHANGE, GESTUREEND];
  
  /**
   * The left mouse button.
   */
  static const int BUTTON_LEFT = 0;

  /**
   * The middle mouse button.
   */
  static const int BUTTON_MIDDLE = 1;

  /**
   * The right mouse button.
   */
  static const int BUTTON_RIGHT = 2;
}
