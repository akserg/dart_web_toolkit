//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

class DomHelperDefault implements DomHelper {

  dart_html.Element captureElem;

  Map<dart_html.Element, Set<String>>  _eventBits = new Map<dart_html.Element, Set<String>>();
  Map<dart_html.Element, EventListener> _listener = new Map<dart_html.Element, EventListener>();

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
      if (child.nodeType == dart_html.Node.ELEMENT_NODE) {
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
    _releaseCaptureImpl(elem);
  }
  
  void _releaseCaptureImpl(dart_html.Element elem) {
    if (elem == captureElem) {
      captureElem = null;
    }
  }

  void setCapture(dart_html.Element elem) {
    _setCaptureImpl(elem);
  }
  
  void _setCaptureImpl(dart_html.Element elem) {
    captureElem = elem;
  }

  //*******
  // Events
  //*******

  void setEventListener(dart_html.Element elem, EventListener listener) {
    //elem.__listener = listener;
    _listener[elem] = listener;
  }

  void sinkBitlessEvent(dart_html.Element elem, String eventTypeName) {
    elem.on[eventTypeName].add(_dispatchEvent);
  }

  void sinkEvents(dart_html.Element elem, Set eventBits) {
    Set<String> _evt = getEventsSunk(elem);
    //
    for (String eventName in eventBits) {
      if (!_evt.contains(eventName)) {
        _evt.add(eventName);
        elem.on[eventName].add(_dispatchEvent);
      }
    }
  }

  void unsinkEvents(dart_html.Element elem, Set eventBits) {
    Set<String> _evt = getEventsSunk(elem);
    //
    for (String eventName in eventBits) {
      _evt.remove(eventName);
      elem.on[eventName].remove(_dispatchEvent);
    }
  }

  Set<String> getEventsSunk(dart_html.Element elem) {
    return _eventBits[elem] == null ? new Set<String>() : _eventBits[elem];
  }

  void _dispatchEvent(dart_html.Event event) {
    EventListener listener;
    dart_html.Node curElem = event.currentTarget as dart_html.Node;

    while (curElem != null && (listener = _listener[curElem]) == null) {
      curElem = curElem.parentNode;
    }

    if (curElem != null && curElem.nodeType != dart_html.Node.ELEMENT_NODE) {
      curElem = null;
    }

    if (listener != null) {
      Dom.dispatchEvent(event, curElem, listener);
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
  
  bool _dispatchCapturedEvent(dart_html.Event evt) {
    if (!Dom.previewEvent(evt)) {
      evt.stopPropagation();
      evt.preventDefault();
      return false;
    }
    return true;
  }

  // Some drag events must call preventDefault to prevent native text selection.
  void _dispatchDragEvent(dart_html.Event evt) {
    evt.preventDefault();
    _dispatchEvent(evt);
  }

  void _dispatchUnhandledEvent(dart_html.Event evt) {
    //this.__gwtLastUnhandledEvent = evt.type; // Image
    _dispatchEvent(evt);
  }

  void _dispatchCapturedMouseEvent(dart_html.Event evt) {
    Function dispatchCapturedEventFn = _dispatchCapturedEvent;
    if (dispatchCapturedEventFn(evt)) {
      dart_html.Element cap = captureElem;
      if (cap != null && _listener[cap] != null) {
        Dom.dispatchEvent(evt, cap, _listener[cap]);
        evt.stopPropagation();
      }
    }  
  }

//  $wnd.addEventListener('click', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('dblclick', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('mousedown', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('mouseup', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('mousemove', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('mouseover', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('mouseout', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('mousewheel', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('keydown', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedEvent, true);
//  $wnd.addEventListener('keyup', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedEvent, true);
//  $wnd.addEventListener('keypress', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedEvent, true);
//
//  // Touch and gesture events are not actually mouse events, but we treat
//  // them as such, so that DOM#setCapture() and DOM#releaseCapture() work.
//  $wnd.addEventListener('touchstart', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('touchmove', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('touchend', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('touchcancel', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('gesturestart', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('gesturechange', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  $wnd.addEventListener('gestureend', @com.google.gwt.user.client.impl.DOMImplStandard::dispatchCapturedMouseEvent, true);
//  }

}