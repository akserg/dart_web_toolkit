//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Base class for drag and drop events.
 *
 * @param <H> handler type
 */
abstract class DragDropEventBase extends MouseEvent {

  /**
   * The implementation singleton.
   */
  static DragSupportDetector _impl;

  /**
   * Runtime check for whether drag events are supported in this browser.
   *
   * @return true if supported, false if not
   */
  static bool isSupported() {
    if (_impl == null) {
      _impl = new DragSupportDetector();
    }
    return _impl.isSupported;
  }

  /**
   * Get the {@link DataTransfer} associated with the current drag event.
   *
   * @return the {@link DataTransfer} object
   */
  dart_html.DataTransfer getDataTransfer() {
    if (getNativeEvent() is dart_html.MouseEvent) {
      return (getNativeEvent() as dart_html.MouseEvent).dataTransfer;
    }
    return null;
  }

  /**
   * Get the data for the specified format from the {@link DataTransfer} object.
   *
   * @param format the format
   * @return the data for the specified format
   */
  String getData(String format) {
    dart_html.DataTransfer dt = getDataTransfer();
    if (dt != null) {
      return getDataTransfer().getData(format);
    }
    return null;
  }

  /**
   * Set the data in the {@link DataTransfer} object for the specified format.
   *
   * @param format the format
   * @param data the data to associate with the format
   */
  void setData(String format, String data) {
    dart_html.DataTransfer dt = getDataTransfer();
    if (dt != null) {
      getDataTransfer().setData(format, data);
    }
  }
}

/**
 * Detector for browser support of drag events.
 */
class DragSupportDetector {

  bool _isSupported = detectDragSupport();

  /**
   * Using a run-time check, return true if drag events are supported.
   *
   * @return true if supported, false otherwise.
   */
  bool get isSupported => _isSupported;

  bool detectDragSupport() {
    dart_html.DivElement elem = new dart_html.DivElement();
    try {
      elem.onDragStart.listen((dart_html.Event evt){
        return;
      });
    } on Exception catch(e) {
      return false;
    }
    return true;//(typeof elem.ondragstart) == "function";
  }
}

/**
 * Detector for permutations that do not support drag events.
 */
class DragSupportDetectorNo extends DragSupportDetector {

  bool get isSupported => false;
}
