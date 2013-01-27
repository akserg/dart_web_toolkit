//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

class DomHelperDefault extends DomHelper {

  Map<dart_html.Element, EventListener> _listener = new Map<dart_html.Element, EventListener>();

  DomHelperDefault();
  
  dart_html.Element captureElem;
  
  static Function dispatchCapturedEvent;

  static Function dispatchCapturedMouseEvent;

  static Function dispatchDragEvent;

  static Function dispatchEvent;

  static Function dispatchUnhandledEvent;

  //*************************
  // Parent - child relations
  //*************************

  bool isOrHasChild(dart_html.Node parent, dart_html.Node child) {
    return parent.contains(child);
  }

  void insertChild(dart_html.Element parent, dart_html.Element toAdd, int index) {
    int count = 0;
    dart_html.Node child = parent.$dom_firstChild;
    dart_html.Node before;
    while (child != null) {
      if (child.nodeType == 1) { // dart_html.Node.ELEMENT_NODE
        if (count == index) {
          before = child;
          break;
        }
        ++count;
      }
      child = child.nextNode; //nextSibling;
    }

    parent.insertBefore(toAdd, before);
  }

  //********************
  // Position of Element
  //********************

  int getAbsoluteLeft(dart_html.Element elem) {
    var left = 0;
    dart_html.Element curr = elem;
    // This intentionally excludes body which has a null offsetParent.
    while (curr.offsetParent != null) {
      left -= curr.scrollLeft;
      curr = curr.parent;
    }
    while (elem != null) {
      left += elem.offsetLeft;
      elem = elem.offsetParent;
    }
    return left;
  }

  int getAbsoluteTop(dart_html.Element elem) {
    var top = 0;
    dart_html.Element curr = elem;
    // This intentionally excludes body which has a null offsetParent.
    while (curr.offsetParent != null) {
      top -= curr.scrollTop;
      curr = curr.parentNode;
    }
    while (elem != null) {
      top += elem.offsetTop;
      elem = elem.offsetParent;
    }
    return top;
  }

  //*********
  // Capturte
  //*********

  void releaseCapture(dart_html.Element elem) {
    maybeInitializeEventSystem();
    _releaseCaptureImpl(elem);
  }

  void _releaseCaptureImpl(dart_html.Element elem) {
    if (elem == captureElem) {
      captureElem = null;
    }
  }

  void setCapture(dart_html.Element elem) {
    maybeInitializeEventSystem();
    _setCaptureImpl(elem);
  }

  void _setCaptureImpl(dart_html.Element elem) {
    captureElem = elem;
  }

  //*******
  // Events
  //*******

  /**
   * Initializes the event dispatch system.
   */
  void initEventSystem() {
    dispatchCapturedEvent = (dart_html.Event evt) {
      if (!Dom.previewEvent(evt)) {
        evt.stopPropagation();
        evt.preventDefault();
        return false;
      }
      return true;
    };

    dispatchEvent = (dart_html.Event event) {
      EventListener listener;
      dart_html.Node curElem = event.currentTarget as dart_html.Node;

      while (curElem != null && (listener = _listener[curElem]) == null) {
        curElem = curElem.parentNode;
      }

      if (curElem != null && curElem.nodeType != 1) { // dart_html.Node.ELEMENT_NODE
        curElem = null;
      }

      if (listener != null) {
        Dom.dispatchEvent(event, curElem, listener);
      }
    };

    // Some drag events must call preventDefault to prevent native text selection.
    dispatchDragEvent = (dart_html.Event evt) {
      evt.preventDefault();
      dispatchEvent(evt);
    };

    dispatchUnhandledEvent = (dart_html.Event evt) {
      //this.dataAttributes["gwtLastUnhandledEvent"] = evt.type; // Image
      dispatchEvent(evt);
    };

    dispatchCapturedMouseEvent = (dart_html.Event evt) {
      Function dispatchCapturedEventFn = dispatchCapturedEvent;
      if (dispatchCapturedEventFn(evt)) {
        dart_html.Element cap = captureElem;
        if (cap != null && _listener[cap] != null) {
          Dom.dispatchEvent(evt, cap, _listener[cap]);
          evt.stopPropagation();
        }
      }
    };

    dart_html.window.on.click.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.doubleClick.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.mouseDown.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.mouseUp.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.mouseMove.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.mouseOver.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.mouseOut.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.mouseWheel.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.keyDown.add(dispatchCapturedEvent, true);
    dart_html.window.on.keyUp.add(dispatchCapturedEvent, true);
    dart_html.window.on.keyPress.add(dispatchCapturedEvent, true);

    // Touch and gesture events are not actually mouse events, but we treat
    // them as such, so that DOM#setCapture() and DOM#releaseCapture() work.
    dart_html.window.on.touchStart.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.touchMove.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.touchEnd.add(dispatchCapturedMouseEvent, true);
    dart_html.window.on.touchCancel.add(dispatchCapturedMouseEvent, true);
//    dart_html.window.on.gesturestart.add(dispatchCapturedMouseEvent, true);
//    dart_html.window.on.gesturechange.add(dispatchCapturedMouseEvent, true);
//    dart_html.window.on.gesturechange.add(dispatchCapturedMouseEvent, true);
  }
  
  dart_html.EventListener getEventListener(dart_html.Element elem) {
    //return elem.__listener;
    return _listener.containsKey(elem) ? _listener[elem] : null;
  }
  void setEventListener(dart_html.Element elem, EventListener listener) {
    //elem.__listener = listener;
    _listener[elem] = listener;
  }

  void sinkBitlessEvent(dart_html.Element elem, String eventTypeName) {
    maybeInitializeEventSystem();
    _sinkBitlessEventImpl(elem, eventTypeName);
  }

  void _sinkBitlessEventImpl(dart_html.Element elem, String eventTypeName) {
    switch(eventTypeName) {
      case "drag":
      case "dragend":
      case "dragleave":
      case "dragstart":
      case "drop":
        elem.on[eventTypeName].add(dispatchEvent);
        break;
      case "dragenter":
      case "dragover":
        elem.on[eventTypeName].add(dispatchDragEvent);
        break;
      case "canplaythrough":
      case "ended":
      case "progress":
        // First call removeEventListener, so as not to add the same event listener more than once
        elem.on[eventTypeName].remove(dispatchEvent);
        elem.on[eventTypeName].add(dispatchEvent);
        break;
      default:
        // catch missing cases
        throw new Exception("Trying to sink unknown event type $eventTypeName");
    }
  }

  void sinkEvents(dart_html.Element elem, int bits) {
    maybeInitializeEventSystem();
    sinkEventsImpl(elem, bits);
  }

  void sinkEventsImpl(dart_html.Element elem, int bits) {
    int chMask = _getEventBits(elem) ^ bits;
    if (chMask == 0) {
      return;
    }
    _setEventBits(elem, chMask);
    //
    _applyDispatcher(elem, bits, chMask, "click", 0x00001, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "dblclick", 0x00002, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "mousedown", 0x00004, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "mouseup", 0x00008, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "mouseover", 0x00010, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "mouseout", 0x00020, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "mousemove", 0x00040, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "keydown", 0x00080, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "keypress", 0x00100, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "keyup", 0x00200, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "change", 0x00400, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "focus", 0x00800, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "blur", 0x01000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "losecapture", 0x02000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "scroll", 0x04000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "load", 0x08000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "error", 0x10000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "mousewheel", 0x20000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "contextmenu", 0x40000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "paste", 0x80000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "touchstart", 0x100000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "touchmove", 0x200000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "touchend", 0x400000, dispatchEvent);
    _applyDispatcher(elem, bits, chMask, "touchcancel", 0x800000, dispatchEvent);
//    _applyDispatcher(elem, bits, chMask, "gesturestart", 0x1000000, dispatchEvent);
//    _applyDispatcher(elem, bits, chMask, "gesturechange", 0x2000000, dispatchEvent);
//    _applyDispatcher(elem, bits, chMask, "gestureend", 0x4000000, dispatchEvent);
  }
  
  void _applyDispatcher(dart_html.Element elem, int bits, int chMask, String eventName, int mask, dart_html.EventListener handler, [bool useCapture = false]) {
    if ((chMask & mask) != 0) {
      if ((bits & mask) != 0) {
        elem.on[eventName].add(handler, useCapture);
      } else {
        elem.on[eventName].remove(handler);
      }
    }
  }

  dart_html.Element eventGetToElement(dart_html.Event evt) {
    if (evt.type == BrowserEvents.MOUSEOVER) {
      return evt.target as dart_html.Element;
    }

    if (evt.type == BrowserEvents.MOUSEOUT) {
      return (evt as dart_html.MouseEvent).relatedTarget as dart_html.Element;
    }

    return null;
  }

  dart_html.Event createHtmlEvent(String type, bool canBubble, bool cancelable) {
    dart_html.CustomEvent evt = new dart_html.CustomEvent('HTMLEvents');
    evt.$dom_initCustomEvent(type, canBubble, cancelable, null);

    return evt;
  }
}