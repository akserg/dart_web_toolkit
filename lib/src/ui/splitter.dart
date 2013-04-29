//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Abstract Splitter for SplitLayoutPanelExample. Implemented as Splitter and
 * VSplitter.
 */
abstract class Splitter extends Widget {
  Widget target;

  int _offset = 0;
  bool _mouseDown = false;
  ScheduledCommand _layoutCommand;

  bool reverse = false;
  int _minSize = 0;
  int _snapClosedSize = -1;
  double _centerSize = 0.0, _syncedCenterSize = 0.0;

  bool _toggleDisplayAllowed = false;
  int _lastClick = 0;

  SplitLayoutPanel _splitLayoutPanel;

  Splitter(this._splitLayoutPanel, this.target, this.reverse) {

    setElement(new dart_html.DivElement());
    sinkEvents(IEvent.ONMOUSEDOWN | IEvent.ONMOUSEUP | IEvent.ONMOUSEMOVE | IEvent.ONDBLCLICK);
  }


  void onBrowserEvent(dart_html.Event event) {
    switch (Dom.eventGetType(event)) {
      case IEvent.ONMOUSEDOWN:
        _mouseDown = true;

        /*
         * Resize glassElem to take up the entire scrollable window area,
         * which is the greater of the scroll size and the client size.
         */
        int width = dart_math.max(Dom.getClientWidth(), Dom.getScrollWidth());
        int height = dart_math.max(Dom.getClientHeight(), Dom.getScrollHeight());
        SplitLayoutPanel.glassElem.style.height = height.toString() + Unit.PX.value;
        SplitLayoutPanel.glassElem.style.width = width.toString() + Unit.PX.value;
        dart_html.document.body.append(SplitLayoutPanel.glassElem);

        _offset = getEventPosition(event) - getAbsolutePosition();
        IEvent.setCapture(getElement());
        event.preventDefault();
        break;

      case IEvent.ONMOUSEUP:
        _mouseDown = false;

        SplitLayoutPanel.glassElem.remove();

        // Handle double-clicks.
        // Fake them since the double-click event aren't fired.
        if (this._toggleDisplayAllowed) {
          int now = new Duration().inMilliseconds; //currentTimeMillis();
          if (now - this._lastClick < SplitLayoutPanel.DOUBLE_CLICK_TIMEOUT) {
            now = 0;
            LayoutData layout = target.getLayoutData() as LayoutData;
            if (layout.size == 0) {
              // Restore the old size.
              setAssociatedWidgetSize(layout.oldSize);
            } else {
              /*
               * Collapse to size 0. We change the size instead of hiding the
               * widget because hiding the widget can cause issues if the
               * widget contains a flash component.
               */
              layout.oldSize = layout.size;
              setAssociatedWidgetSize(0.0);
            }
          }
          this._lastClick = now;
        }

        IEvent.releaseCapture(getElement());
        event.preventDefault();
        break;

      case IEvent.ONMOUSEMOVE:
        if (_mouseDown) {
          int size;
          if (reverse) {
            size = getTargetPosition() + getTargetSize() - getEventPosition(event) - _offset;
          } else {
            size = getEventPosition(event) - getTargetPosition() - _offset;
          }
          (target.getLayoutData() as LayoutData).hidden = false;
          setAssociatedWidgetSize(size.toDouble());
          event.preventDefault();
        }
        break;
    }
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
    getElement().style.width = this._splitLayoutPanel._splitterSize.toString() + Unit.PX.value;
    clearAndSetStyleName("dwt-SplitLayoutPanel-HDragger");
  }


  int getAbsolutePosition() {
    return getAbsoluteLeft();
  }


  double getCenterSize() {
    return this._splitLayoutPanel.getCenterWidth();
  }


  int getEventPosition(dart_html.MouseEvent event) {
    return event.client.x;
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
    getElement().style.height = this._splitLayoutPanel._splitterSize.toString() + Unit.PX.value;
    clearAndSetStyleName("dwt-SplitLayoutPanel-VDragger");
  }


  int getAbsolutePosition() {
    return getAbsoluteTop();
  }


  double getCenterSize() {
    return this._splitLayoutPanel.getCenterHeight();
  }


  int getEventPosition(dart_html.MouseEvent event) {
    return event.client.y;
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