//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Extended by view interfaces that are likely to be implemented by Widgets.
 * Provides access to that widget, if it exists, without compromising the
 * ability to provide a mock view instance in JRE unit tests.
 */
abstract class IsWidget {

  /**
   * Returns the [Widget] aspect of the receiver.
   */
  Widget asWidget();
}
