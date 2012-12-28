//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

abstract class Splitter extends Widget {
  Widget target;

  int _offset;
  bool _mouseDown;
  ScheduledCommand _layoutCommand;

  bool reverse;
  int _minSize;
  int _snapClosedSize = -1;
  double _centerSize, _syncedCenterSize;

  bool _toggleDisplayAllowed = false;
  double _lastClick = 0.0;

  SplitLayoutPanel _splitLayoutPanel;

  Splitter(this._splitLayoutPanel, this.target, this.reverse) {

    setElement(new dart_html.DivElement());
    //sinkEvents(Event.ONMOUSEDOWN | Event.ONMOUSEUP | Event.ONMOUSEMOVE | Event.ONDBLCLICK);
  }


  void onBrowserEvent(dart_html.Event event) {
//    switch (event.typetTypeInt()) {
//      case Event.ONMOUSEDOWN:
//        _mouseDown = true;
//
//        /*
//         * Resize glassElem to take up the entire scrollable window area,
//         * which is the greater of the scroll size and the client size.
//         */
//        int width = Math.max(Window.getClientWidth(),
//            Document.get().getScrollWidth());
//        int height = Math.max(Window.getClientHeight(),
//            Document.get().getScrollHeight());
//        glassElem.getStyle().setHeight(height, Unit.PX);
//        glassElem.getStyle().setWidth(width, Unit.PX);
//        Document.get().getBody().appendChild(glassElem);
//
//        _offset = getEventPosition(event) - getAbsolutePosition();
//        dart_html.Event.setCapture(getElement());
//        event.preventDefault();
//        break;
//
//      case Event.ONMOUSEUP:
//        _mouseDown = false;
//
//        glassElem.removeFromParent();
//
//        // Handle double-clicks.
//        // Fake them since the double-click event aren't fired.
//        if (this._toggleDisplayAllowed) {
//          double now = Duration.currentTimeMillis();
//          if (now - this._lastClick < DOUBLE_CLICK_TIMEOUT) {
//            now = 0;
//            LayoutData layout = (LayoutData) target.getLayoutData();
//            if (layout.size == 0) {
//              // Restore the old size.
//              setAssociatedWidgetSize(layout.oldSize);
//            } else {
//              /*
//               * Collapse to size 0. We change the size instead of hiding the
//               * widget because hiding the widget can cause issues if the
//               * widget contains a flash component.
//               */
//              layout.oldSize = layout.size;
//              setAssociatedWidgetSize(0);
//            }
//          }
//          this._lastClick = now;
//        }
//
//        Event.releaseCapture(getElement());
//        event.preventDefault();
//        break;
//
//      case Event.ONMOUSEMOVE:
//        if (_mouseDown) {
//          int size;
//          if (reverse) {
//            size = getTargetPosition() + getTargetSize()
//                - getEventPosition(event) - _offset;
//          } else {
//            size = getEventPosition(event) - getTargetPosition() - _offset;
//          }
//          ((LayoutData) target.getLayoutData()).hidden = false;
//          setAssociatedWidgetSize(size);
//          event.preventDefault();
//        }
//        break;
//    }
  }

  void setMinSize(int minSize) {
    this._minSize = minSize;
    LayoutData layout = target.getLayoutData() as LayoutData;

    // Try resetting the associated widget's size, which will enforce the new
    // minSize value.
    setAssociatedWidgetSize(layout.size);
  }

  void setSnapClosedSize(int snapClosedSize) {
    this._snapClosedSize = snapClosedSize;
  }

  void setToggleDisplayAllowed(bool allowed) {
    this._toggleDisplayAllowed = allowed;
  }

  int getAbsolutePosition();

  double getCenterSize();

  int getEventPosition(dart_html.Event event);

  int getTargetPosition();

  int getTargetSize();

  double getMaxSize() {
    // To avoid seeing stale center size values due to deferred layout
    // updates, maintain our own copy up to date and resync when the
    // DockLayoutPanel value changes.
    double newCenterSize = getCenterSize();
    if (_syncedCenterSize != newCenterSize) {
      _syncedCenterSize = newCenterSize;
      _centerSize = newCenterSize;
    }

    return dart_math.max((target.getLayoutData() as LayoutData).size + _centerSize, 0);
  }

  void setAssociatedWidgetSize(double size) {
    double maxSize = getMaxSize();
    if (size > maxSize) {
      size = maxSize;
    }

    if (_snapClosedSize > 0 && size < _snapClosedSize) {
      size = 0.0;
    } else if (size < _minSize) {
      size = _minSize.toDouble();
    }

    LayoutData layout = target.getLayoutData() as LayoutData;
    if (size == layout.size) {
      return;
    }

    // Adjust our view until the deferred layout gets scheduled.
    _centerSize += layout.size - size;
    layout.size = size;

    // Defer actually updating the layout, so that if we receive many
    // mouse events before layout/paint occurs, we'll only update once.
    if (_layoutCommand == null) {
      _layoutCommand = new SplitterScheduledCommand(this);
      Scheduler.get().scheduleDeferred(_layoutCommand);
    }
  }
}

class HSplitter extends Splitter {
  HSplitter(SplitLayoutPanel splitLayoutPanel, Widget target, bool reverse) : super(splitLayoutPanel, target, reverse) {
    //getElement().getStyle().setPropertyPx("width", splitterSize);
    getElement().style.width = this._splitLayoutPanel._splitterSize.toString().concat(Unit.PX.cssName);
    clearAndSetStyleName("dwt-SplitLayoutPanel-HDragger");
  }


  int getAbsolutePosition() {
    return getAbsoluteLeft();
  }


  double getCenterSize() {
    return this._splitLayoutPanel.getCenterWidth();
  }


  int getEventPosition(dart_html.MouseEvent event) {
    return event.clientX;
  }


  int getTargetPosition() {
    return target.getAbsoluteLeft();
  }


  int getTargetSize() {
    return target.getOffsetWidth();
  }
}

class VSplitter extends Splitter {
  VSplitter(SplitLayoutPanel splitLayoutPanel, Widget target, bool reverse) : super(splitLayoutPanel, target, reverse) {
    //getElement().getStyle().setPropertyPx("height", splitterSize);
    getElement().style.height = this._splitLayoutPanel._splitterSize.toString().concat(Unit.PX.cssName);
    clearAndSetStyleName("dwt-SplitLayoutPanel-VDragger");
  }


  int getAbsolutePosition() {
    return getAbsoluteTop();
  }


  double getCenterSize() {
    return this._splitLayoutPanel.getCenterHeight();
  }


  int getEventPosition(dart_html.MouseEvent event) {
    return event.clientY;
  }


  int getTargetPosition() {
    return target.getAbsoluteTop();
  }


  int getTargetSize() {
    return target.getOffsetHeight();
  }
}

class SplitterScheduledCommand extends ScheduledCommand {

  Splitter _splitter;

  SplitterScheduledCommand(this._splitter);

  /**
   * Invokes the command.
   */
  void execute() {
    _splitter._layoutCommand = null;
    _splitter._splitLayoutPanel.forceLayout();
  }
}