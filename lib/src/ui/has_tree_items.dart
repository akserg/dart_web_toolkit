//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that implements this interface contains
 * {@link com.google.gwt.user.client.ui.TreeItem items} and can operate them.
 */
abstract class HasTreeItems {

  /**
   * Adds a simple tree item containing the specified html.
   *
   * @param itemHtml the html of the item to be added
   * @return the item that was added
   */
  TreeItem addSafeHtmlItem(SafeHtml itemHtml);

  /**
   * Adds an tree item.
   *
   * @param item the item to be added
   */
  void addItem(TreeItem item);

  /**
   * Adds an item wrapped by specified {@link IsTreeItem}.
   *
   * @param isItem the wrapper of item to be added
   */
  void addIsTreeItem(IsTreeItem isItem);

  /**
   * Adds a new tree item containing the specified widget.
   *
   * @param widget the widget to be added
   * @return the new item
   */
  TreeItem addWidgetItem(Widget widget);

  /**
   * Adds a simple tree item containing the specified text.
   *
   * @param itemText the text of the item to be added
   * @return the item that was added
   */
  TreeItem addTextItem(String itemText);

  /**
   * Removes an item.
   *
   * @param item the item to be removed
   */
  void removeItem(TreeItem item);

  /**
   * Removes an item.
   *
   * @param isItem the wrapper of item to be removed
   */
  void removeIsTreeItem(IsTreeItem isItem);

  /**
   * Removes all items.
   */
  void removeItems();

}

/**
 * Extends this interface with convenience methods to handle {@link IsWidget}.
 */
abstract class HasTreeItemsForIsWidget extends HasTreeItems {
  TreeItem addIsWidgetItem(IsWidget w);
}