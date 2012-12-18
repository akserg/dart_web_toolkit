//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Iterator over a finite number of widgets, which are stored in a delegate
 * class (usually a widget panel).
 *
 * <p>
 * In order to use this class, assign each widget in the panel an arbitrary
 * index. For example, {@link HeaderPanel} defines the header as index 0, the
 * content as index 1, and the footer as index 2. Construct a new
 * {@link FiniteWidgetIterator} with a {@link WidgetProvider} that provides the
 * child widgets.
 */
class FiniteWidgetIterator implements Iterator<Widget> {

  int index = -1;
  WidgetProvider provider;
  int widgetCount;

  /**
   * Construct a new {@link FiniteWidgetIterator}.
   *
   * <p>
   * The widget count is the number of child widgets that the panel supports,
   * regardless of whether or not they are set.
   *
   * @param provider the widget provider
   * @param widgetCount the finite number of widgets that can be provided
   */
  FiniteWidgetIterator(WidgetProvider provider, int widgetCount) {
    this.provider = provider;
    this.widgetCount = widgetCount;
  }

  bool get hasNext => _getHasNext();

  bool _getHasNext() {
    // Iterate over the remaining widgets until we find one.
    for (int i = index + 1; i < widgetCount; i++) {
      IsWidget w = provider.get(i);
      if (w != null) {
        return true;
      }
    }
    return false;
  }

  Widget next() {
    // Iterate over the remaining widgets until we find one.
    for (int i = index + 1; i < widgetCount; i++) {
      index = i;
      IsWidget w = provider.get(i);
      if (w != null) {
        return w.asWidget();
      }
    }
    throw new Exception("No Such Element");
  }

  void remove() {
    if (index < 0 || index >= widgetCount) {
      throw new Exception("Illegal State");
    }
    IsWidget w = provider.get(index);
    if (w == null) {
      throw new Exception("Widget was already removed.");
    }
    w.asWidget().removeFromParent();
  }
}

/**
 * Provides widgets to the iterator.
 */
abstract class WidgetProvider {
  IsWidget get(int index);
}