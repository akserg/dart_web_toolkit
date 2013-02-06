//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Extended by objects which have underlying {@link TreeItem}.
 * Provides access to that item, if it exists, without compromising the
 * ability to provide a mock object instance in JRE unit tests.
 */
abstract class IsTreeItem {

  /**
   * Returns the {@link TreeItem} aspect of the receiver.
   */
  TreeItem asTreeItem();
}
