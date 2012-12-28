//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * An object that implements this interface has a native event associated with
 * it.
 */
abstract class HasNativeEvent {
  /**
   * Gets the underlying native event.
   * 
   * @return the native event
   */
  dart_html.Event getNativeEvent();
}
