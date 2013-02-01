//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A simple panel that {@link ProvidesResize} to its one child, but does not
 * {@link RequiresResize}. Use this to embed layout panels in any location
 * within your application.
 */
class ResizeLayoutPanel extends SimplePanel implements ProvidesResize, HasResizeHandlers {

  static ResizeLayoutPanelImpl impl = new ResizeLayoutPanelImpl.browserDependent();
  Layer layer;
  Layout layout;
  ScheduledCommand resizeCmd;
  bool resizeCmdScheduled = false;

  ResizeLayoutPanel() {
    resizeCmd = new ResizeScheduledCommand(this);
    layout = new Layout(getElement());
    impl.init(getElement(), new ResizeLayoutPanelResizeDelegate(this));
  }

  HandlerRegistration addResizeHandler(ResizeHandler handler) {
    return addHandler(handler, ResizeEvent.TYPE);
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
      scheduleResize();
    }
  }

  void onAttach() {
    super.onAttach();
    impl.onAttach();
    layout.onAttach();
    scheduleResize();
  }

  void onDetach() {
    super.onDetach();
    impl.onDetach();
    layout.onDetach();
  }

  void handleResize() {
    if (!isAttached()) {
      return;
    }

    // Provide resize to child.
    if (widget is RequiresResize) {
      (widget as RequiresResize).onResize();
    }

    // Fire resize event.
    ResizeEvent.fire(this, getOffsetWidth(), getOffsetHeight());
  }

  /**
   * Schedule a resize handler. We schedule the event so the DOM has time to
   * update the offset sizes, and to avoid duplicate resize events from both a
   * height and width resize.
   */
  void scheduleResize() {
    if (isAttached() && !resizeCmdScheduled) {
      resizeCmdScheduled = true;
      Scheduler.get().scheduleDeferred(resizeCmd);
    }
  }
}

class ResizeScheduledCommand implements ScheduledCommand {

  ResizeLayoutPanel _panel;

  ResizeScheduledCommand(this._panel);

  /**
   * Invokes the command.
   */
  void execute() {
    _panel.resizeCmdScheduled = false;
    _panel.handleResize();
  }
}

/**
 * Delegate event handler.
 */
class ResizeLayoutPanelResizeDelegate extends ResizeDelegate {

  ResizeLayoutPanel _panel;

  ResizeLayoutPanelResizeDelegate(this._panel);


  /**
   * Called when the element is resized.
   */
  void onResize() {
    _panel.scheduleResize();
  }
}