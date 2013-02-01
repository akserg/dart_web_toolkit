//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implementation of resize event.
 */
class ResizeLayoutPanelImplStandard extends ResizeLayoutPanelImpl implements EventListener {
  /**
   * Chrome does not fire an onresize event if the dimensions are too small to
   * render a scrollbar.
   */
  static final String _MIN_SIZE = "20px";

  dart_html.Element _collapsible;
  dart_html.Element _collapsibleInner;
  dart_html.Element _expandable;
  dart_html.Element _expandableInner;
  int _lastOffsetHeight = -1;
  int _lastOffsetWidth = -1;
  bool _resettingScrollables = false;

  
  void init(dart_html.Element elem, ResizeDelegate delegate) {
    super.init(elem, delegate);

    /*
     * Set the minimum dimensions to ensure that scrollbars are rendered and
     * fire onscroll events.
     */
    elem.style.minWidth = _MIN_SIZE;
    elem.style.minHeight = _MIN_SIZE;

    /*
     * Detect expansion. In order to detect an increase in the size of the
     * widget, we create an absolutely positioned, scrollable div with
     * height=width=100%. We then add an inner div that has fixed height and
     * width equal to 100% (converted to pixels) and set scrollLeft/scrollTop
     * to their maximum. When the outer div expands, scrollLeft/scrollTop
     * automatically becomes a smaller number and trigger an onscroll event.
     */
    _expandable = new dart_html.DivElement();
    _expandable.style.visibility = Visibility.HIDDEN.value;
    _expandable.style.position = Position.ABSOLUTE.value;
    _expandable.style.height = "100".concat(Unit.PCT.value);
    _expandable.style.width = "100".concat(Unit.PCT.value);
    _expandable.style.overflow = Overflow.SCROLL.value;
    elem.append(_expandable);
    _expandableInner = new dart_html.DivElement();
    _expandable.append(_expandableInner);
    Dom.sinkEvents(_expandable, Event.ONSCROLL);

    /*
     * Detect collapse. In order to detect a decrease in the size of the
     * widget, we create an absolutely positioned, scrollable div with
     * height=width=100%. We then add an inner div that has height=width=200%
     * and max out the scrollTop/scrollLeft. When the height or width
     * decreases, the inner div loses 2px for every 1px that the scrollable
     * div loses, so the scrollTop/scrollLeft decrease and we get an onscroll
     * event.
     */
    _collapsible = new dart_html.DivElement();
    _collapsible.style.visibility = Visibility.HIDDEN.value;
    _collapsible.style.position = Position.ABSOLUTE.value;
    _collapsible.style.height = "100".concat(Unit.PCT.value);
    _collapsible.style.width = "100".concat(Unit.PCT.value);
    _collapsible.style.overflow = Overflow.SCROLL.value;
    elem.append(_collapsible);
    _collapsibleInner = new dart_html.DivElement();
    _collapsibleInner.style.width = "200".concat(Unit.PCT.value);
    _collapsibleInner.style.height = "200".concat(Unit.PCT.value);
    _collapsible.append(_collapsibleInner);
    Dom.sinkEvents(_collapsible, Event.ONSCROLL);
  }

  
  void onAttach() {
    super.onAttach();
    Dom.setEventListener(_expandable, this);
    Dom.setEventListener(_collapsible, this);

    /*
     * Update the scrollables in a deferred command so the browser calculates
     * the offsetHeight/Width correctly.
     */
    Scheduler.get().scheduleDeferred(new _ScheduledCommand(this));
  }

  void onBrowserEvent(dart_html.Event event) {
    if (!_resettingScrollables && Event.ONSCROLL == Dom.eventGetType(event)) {
      dart_html.EventTarget eventTarget = event.target;
      if (eventTarget is! dart_html.Element) {
        return;
      }
      dart_html.Element target = eventTarget as dart_html.Element;
      if (target == _collapsible || target == _expandable) {
        handleResize();
      }
    }
  }

  
  void onDetach() {
    super.onDetach();
    Dom.setEventListener(_expandable, null);
    Dom.setEventListener(_collapsible, null);
    _lastOffsetHeight = -1;
    _lastOffsetWidth = -1;
  }

  
  void handleResize() {
    if (_resetScrollables()) {
      super.handleResize();
    }
  }

  /**
   * Reset the positions of the scrollable elements.
   * 
   * @return true if the size changed, false if not
   */
  bool _resetScrollables() {
    /*
     * Older versions of safari trigger a synchronous scroll event when we
     * update scrollTop/scrollLeft, so we set a bool to ignore that event.
     */
    if (_resettingScrollables) {
      return false;
    }
    _resettingScrollables = true;

    /*
     * Reset expandable element. Scrollbars are not rendered if the div is too
     * small, so we need to set the dimensions of the inner div to a value
     * greater than the offsetWidth/Height.
     */
    int offsetHeight = parent.offsetHeight;
    int offsetWidth = parent.offsetWidth;
    int height = offsetHeight + 100;
    int width = offsetWidth + 100;
    _expandableInner.style.height = height.toString().concat(Unit.PX.value);
    _expandableInner.style.width = width.toString().concat(Unit.PX.value);
    _expandable.scrollTop = height;
    _expandable.scrollLeft = width;

    // Reset collapsible element.
    _collapsible.scrollTop = _collapsible.scrollHeight + 100;
    _collapsible.scrollLeft = _collapsible.scrollWidth + 100;

    if (_lastOffsetHeight != offsetHeight || _lastOffsetWidth != offsetWidth) {
      _lastOffsetHeight = offsetHeight;
      _lastOffsetWidth = offsetWidth;
      _resettingScrollables = false;
      return true;
    }
    _resettingScrollables = false;
    return false;
  }
}

class _ScheduledCommand implements ScheduledCommand {
  ResizeLayoutPanelImplStandard _panel;
  
  _ScheduledCommand(this._panel);
  
  void execute() {
    _panel._resetScrollables();
  }
}
