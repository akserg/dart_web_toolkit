//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A simple panel that {@link ProvidesResize} to its one child.
 */
class SimpleLayoutPanel extends SimplePanel implements RequiresResize, ProvidesResize {

  Layer layer;
  Layout layout;

  SimpleLayoutPanel() : super() {
    layout = new Layout(getElement());
  }


  void onResize() {
    if (widget is RequiresResize) {
      (widget as RequiresResize).onResize();
    }
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
      layout.removeChild(layer);
      layer = null;

      // Logical detach.
      widget = null;
    }
    return true;
  }


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
      layer = layout.attachChild(widget.getElement(), userObject:widget);
      layer.setTopHeight(0.0, Unit.PX, 100.0, Unit.PCT);
      layer.setLeftWidth(0.0, Unit.PX, 100.0, Unit.PCT);

      adopt(w);

      // Update the layout.
      layout.layout();
      onResize();
    }
  }


  void onAttach() {
    super.onAttach();
    layout.onAttach();
  }


  void onDetach() {
    super.onDetach();
    layout.onDetach();
  }
}
