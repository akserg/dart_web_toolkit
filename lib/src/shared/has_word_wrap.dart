//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface has a 'word-wrap' property that can
 * be manipulated using these methods.
 */
abstract class HasWordWrap {

  /**
   * Gets whether word-wrapping is enabled.
   * 
   * @return <code>true</code> if word-wrapping is enabled.
   */
  bool get wordWrap;

  /**
   * Sets whether word-wrapping is enabled.
   * 
   * @param wrap <code>true</code> to enable word-wrapping.
   */
  void set wordWrap(bool wrap);
}
