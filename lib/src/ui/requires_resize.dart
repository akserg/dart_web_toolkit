//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * This interface designates that its implementor needs to be informed whenever
 * its size is modified.
 * 
 * <p>
 * Widgets that implement this interface should only be added to those that
 * implement {@link ProvidesResize}. Failure to do so will usually result in
 * {@link #onResize()} not being called.
 * </p>
 */
abstract class RequiresResize {

  /**
   * This method must be called whenever the implementor's size has been
   * modified.
   */
  void onResize();
}
