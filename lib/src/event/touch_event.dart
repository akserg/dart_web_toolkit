//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Abstract class representing touch events.
 *
 * See {@link <a href="http://developer.apple.com/library/safari/documentation/UserExperience/Reference/TouchEventClassReference/TouchEvent/TouchEvent.html">Safari Touch Event Documentation</a>}
 * @param <H> handler type
 */
abstract class TouchEvent extends DomEvent {
  /**
   * The implementation singleton.
   */
  static TouchSupportDetector _impl;

  /**
   * Runtime check for whether touch scrolling is supported in this browser. Returns true if touch
   * events are supported but touch based scrolling is not natively supported.
   *
   * @return true if touch events are supported, false if not
   */
  static bool isSupported() {
    if (_impl == null) {
      _impl = new TouchSupportDetector();
    }
    return _impl.isSupported();
  }

  /**
   * Cast native event to [TouchEvent].
   */
  dart_html.TouchEvent getTouchEvent() {
    if (getNativeEvent() is dart_html.TouchEvent) {
      return getNativeEvent() as dart_html.TouchEvent;
    }
    throw new Exception("Native event is not subtype of TouchEvent");
  }

  /**
   * Get an array of {@link Touch touches} which have changed since the last
   * touch event fired. Note, that for {@link TouchEndEvent touch end events},
   * the touch which has just ended will not be present in the array. Moreover,
   * if the touch which just ended was the last remaining touch, then a zero
   * length array will be returned.
   *
   * @return an array of touches
   */
  List<dart_html.Touch> getChangedTouches() {
    return getTouchEvent().changedTouches;
  }

  /**
   * Get an array of {@link Touch touches} all touch which originated at the
   * same target as the current touch event. Note, that for {@link TouchEndEvent
   * touch end events}, the touch which has just ended will not be present in
   * the array. Moreover, if the touch which just ended was the last remaining
   * touch, then a zero length array will be returned.
   *
   * @return an array of touches
   */
  List<dart_html.Touch> getTargetTouches() {
    return getTouchEvent().targetTouches;
  }

  /**
   * Get an array of all current {@link Touch touches}. Note, that for
   * {@link TouchEndEvent touch end events}, the touch which has just ended will
   * not be present in the array. Moreover, if the touch which just ended was
   * the last remaining touch, then a zero length array will be returned.
   *
   * @return an array of touches
   */
  List<dart_html.Touch> getTouches() {
    return getTouchEvent().touches;
  }
}

/**
 * Dectector for browser support for touch events.
 */
class TouchSupportDetector {

  bool _isSupported;

  bool isSupported() {
    return _isSupported;
  }

  TouchSupportDetector() {
    _isSupported = detectTouchSupport();
  }
  
  bool detectTouchSupport() {
    dart_html.DivElement elem = new dart_html.DivElement();
    try {
      elem.onTouchStart.listen((dart_html.Event evt){
        return;
      });
    } on Exception catch(e) {
      return false;
    }
    return true;
  }
}

/**
 * Detector for browsers that do not support touch events.
 */
class TouchSupportDetectorNo extends TouchSupportDetector {

  bool isSupported() {
    return false;
  }
}
