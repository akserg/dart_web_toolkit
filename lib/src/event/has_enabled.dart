//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface can be put in an "enabled"
 * or "disabled" state.
 */
abstract class HasEnabled {

  /**
   * Returns true if the widget is enabled, false if not.
   */
  bool get enabled;

  /**
   * Sets whether this widget is enabled.
   *
   * @param enabled <code>true</code> to enable the widget, <code>false</code>
   *          to disable it
   */
  void set enabled(bool value);
}
