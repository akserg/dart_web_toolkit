//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface can receive keyboard focus.
 */
abstract class Focusable {

  /**
   * Gets the widget's position in the tab index.
   * 
   * @return the widget's tab index
   */
  int get tabIndex;

  /**
   * Sets the widget's 'access key'. This key is used (in conjunction with a
   * browser-specific modifier key) to automatically focus the widget.
   * 
   * @param key the widget's access key
   */
  void set accessKey(int key);

  /**
   * Explicitly focus/unfocus this widget. Only one widget can have focus at a
   * time, and the widget that does will receive all keyboard events.
   * 
   * @param focused whether this widget should take focus or release it
   */
  void set focus(bool focused);

  /**
   * Sets the widget's position in the tab index. If more than one widget has
   * the same tab index, each such widget will receive focus in an arbitrary
   * order. Setting the tab index to <code>-1</code> will cause this widget to
   * be removed from the tab order.
   * 
   * @param index the widget's tab index
   */
  void set tabIndex(int index);
}
