//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

class DomHelperDefault implements DomHelper {

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
//    maybeInitializeEventSystem();
//    releaseCaptureImpl(elem);
  }

  void setCapture(dart_html.Element elem) {
//    maybeInitializeEventSystem();
//    setCaptureImpl(elem);
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
}