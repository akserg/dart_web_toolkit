//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;


/**
 * Base class for panels that contain only one widget.
 */
class SimplePanel extends Panel implements HasOneWidget {

  Widget widget;


  /**
   * Creates an empty panel that uses a DIV for its contents or
   * create a panel with the specified child widget.
   */
  SimplePanel([Widget child = null]) {
    setElement(new dart_html.DivElement());
    //
    if (child != null) {
      setWidget(child);
    }
  }

  /**
   * Creates an empty panel that uses the specified browser element for its
   * contents.
   *
   * @param elem the browser element to use
   */
  SimplePanel.fromElement(dart_html.Element elem) {
    setElement(elem);
  }

  /**
   * Override this method to specify that an element other than the root element
   * be the container for the panel's child widget. This can be useful when you
   * want to create a simple panel that decorates its contents.
   *
   * Note that this method continues to return the
   * {@link com.google.gwt.user.client.Element} class defined in the
   * <code>User</code> module to maintain backwards compatibility.
   *
   * @return the element to be used as the panel's container
   */
  dart_html.Element getContainerElement() {
    return getElement();
  }

  //***

  /**
   * Adds a widget to this panel.
   *
   * @param w the child widget to be added
   */
  void add(Widget w) {
    // Can't add() more than one widget to a SimplePanel.
    if (getWidget() != null) {
      throw new Exception("SimplePanel can only contain one child widget");
    }
    setWidget(w);
  }

  Iterator<Widget> iterator() {
    // Return a simple iterator that enumerates the 0 or 1 elements in this
    // panel.
    return new PanelIterator(this);
  }

  bool remove(Widget w) {
    // Validate.
    if (widget != w) {
      return false;
    }

    // Orphan.
    try {
      orphan(w);
    } finally {
      // Physical detach.
      getContainerElement().removeChild(w.getElement());

      // Logical detach.
      widget = null;
    }
    return true;
  }

  //***********************************
  // Implementation of AcceptsOneWidget
  //***********************************

  /**
   * Set the only widget of the receiver, replacing the previous
   * widget if there was one.
   *
   * @param w the widget, or <code>null</code> to remove the widget
   *
   * @see SimplePanel
   */
  void setWidgetIsWidget(IsWidget w) {
    setWidget(asWidgetOrNull(w));
  }

  //*******************************
  // Implementation of HasOneWidget
  //*******************************

  /**
   * Sets this panel's widget. Any existing child widget will be removed.
   *
   * @param w the panel's new widget, or <code>null</code> to clear the panel
   */
  void setWidget(Widget w) {
    // Validate
    if (w == widget) {
      return;
    }

    // Detach new child.
    if (w != null) {
      w.removeFromParent();
    }

    // Remove old child.
    if (widget != null) {
      remove(widget);
    }

    // Logical attach.
    widget = w;

    if (w != null) {
      // Physical attach.
      //DOM.appendChild(getContainerElement(), widget.getElement());
      getContainerElement().append(widget.getElement());

      adopt(w);
    }
  }

  /**
   * Gets the panel's child widget.
   *
   * @return the child widget, or <code>null</code> if none is present
   */
  Widget getWidget() {
    return widget;
  }
}