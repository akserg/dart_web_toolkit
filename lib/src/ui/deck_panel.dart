//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that displays all of its child widgets in a 'deck', where only one
 * can be visible at a time. It is used by
 * {@link com.google.gwt.user.client.ui.TabPanel}.
 * 
 * <p>
 * Once a widget has been added to a DeckPanel, its visibility, width, and
 * height attributes will be manipulated. When the widget is removed from the
 * DeckPanel, it will be visible, and its width and height attributes will be
 * cleared.
 * </p>
 */
class DeckPanel extends ComplexPanel implements HasAnimation, InsertPanelForIsWidget {
  /**
   * The duration of the animation.
   */
  static final int _ANIMATION_DURATION = 350;

  /**
   * The {@link Animation} used to slide in the new {@link Widget}.
   */
  static _SlideAnimation _slideAnimation;

  /**
   * The the container {@link dart_html.Element} around a {@link Widget}.
   * 
   * @param w the {@link Widget}
   * @return the container {@link dart_html.Element}
   */
  static dart_html.Element _getContainer(Widget w) {
    return w.getElement().parent;
  }

  bool _isAnimationEnabled = false;

  Widget _visibleWidget;

  /**
   * Creates an empty deck panel.
   */
  DeckPanel() {
    setElement(new dart_html.DivElement());
  }

  void add(Widget w) {
    dart_html.Element container = createWidgetContainer();
    //Dom.appendChild(getElement(), container);
    getElement().append(container);

    // The order of these methods is very important. In order to preserve
    // backward compatibility, the offsetWidth and offsetHeight of the child
    // widget should be defined (greater than zero) when w.onLoad() is called.
    // As a result, we first initialize the container with a height of 0px, then
    // we attach the child widget to the container. See Issue 2321 for more
    // details.
    super.addWidget(w, container);

    // After w.onLoad is called, it is safe to make the container invisible and
    // set the height of the container and widget to 100%.
    finishWidgetInitialization(container, w);
  }

  /**
   * Gets the index of the currently-visible widget.
   * 
   * @return the visible widget's index
   */
  int getVisibleWidget() {
    return getWidgetIndex(_visibleWidget);
  }

  void insertIsWidget(IsWidget w, int beforeIndex) {
    insertAt(asWidgetOrNull(w), beforeIndex);
  }

  void insertAt(Widget w, int beforeIndex) {
    dart_html.Element container = createWidgetContainer();
    Dom.insertChild(getElement(), container, beforeIndex);

    // See add(Widget) for important comments
    super.insert(w, container, beforeIndex, true);
    finishWidgetInitialization(container, w);
  }

  bool isAnimationEnabled() {
    return _isAnimationEnabled;
  }

  bool remove(Widget w) {
    dart_html.Element container = _getContainer(w);
    bool removed = super.remove(w);
    if (removed) {
      resetChildWidget(w);

      //Dom.removeChild(getElement(), container);
      container.remove();
      if (_visibleWidget == w) {
        _visibleWidget = null;
      }
    }
    return removed;
  }

  void setAnimationEnabled(bool enable) {
    _isAnimationEnabled = enable;
  }

  /**
   * Shows the widget at the specified index. This causes the currently- visible
   * widget to be hidden.
   * 
   * @param index the index of the widget to be shown
   */
  void showWidgetAt(int index) {
    checkIndexBoundsForAccess(index);
    Widget oldWidget = _visibleWidget;
    _visibleWidget = getWidget(index);

    if (_visibleWidget != oldWidget) {
      if (_slideAnimation == null) {
        _slideAnimation = new _SlideAnimation(this);
      }
      _slideAnimation.showWidget(oldWidget, _visibleWidget, _isAnimationEnabled
          && isAttached());
    }
  }

  /**
   * Setup the container around the widget.
   */
  dart_html.Element createWidgetContainer() {
    dart_html.Element container = new dart_html.DivElement();
    container.style.width = "100%";
    container.style.height = "0px";
    container.style.padding = "0px";
    container.style.margin = "0px";
    return container;
  }

  /**
   * Setup the container around the widget.
   */
  void finishWidgetInitialization(dart_html.Element container, Widget w) {
    UiObject.setVisible(container, false);
    container.style.height = "100%";

    // Set 100% by default.
    dart_html.Element element = w.getElement();
    if (element.style.width == "") {
      w.setWidth("100%");
    }
    if (element.style.height == "") {
      w.setHeight("100%");
    }

    // Issue 2510: Hiding the widget isn't necessary because we hide its
    // wrapper, but it's in here for legacy support.
    w.visible = false;
  }

  /**
   * Reset the dimensions of the widget when it is removed.
   */
  void resetChildWidget(Widget w) {
    w.setSize("", "");
    w.visible = true;
  }
}

/**
 * An {@link Animation} used to slide in the new content.
 */
class _SlideAnimation extends Animation {
  
  DeckPanel _deckPanel;
  
  /**
   * The {@link dart_html.Element} holding the {@link Widget} with a lower index.
   */
  dart_html.Element container1 = null;

  /**
   * The {@link dart_html.Element} holding the {@link Widget} with a higher index.
   */
  dart_html.Element container2 = null;

  /**
   * A bool indicating whether container1 is growing or shrinking.
   */
  bool growing = false;

  /**
   * The fixed height of a {@link TabPanel} in pixels. If the {@link TabPanel}
   * does not have a fixed height, this will be set to -1.
   */
  int fixedHeight = -1;

  /**
   * The old {@link Widget} that is being hidden.
   */
  Widget oldWidget = null;

  /**
   * Construct a new {@link _SlideAnimation} using the specified scheduler to
   * sheduler request frames.
   *
   * @param scheduler an {@link _SlideAnimation} instance
   */
  _SlideAnimation(this._deckPanel, [AnimationScheduler scheduler = null]) : super(scheduler);
    
  /**
   * Switch to a new {@link Widget}.
   * 
   * @param oldWidget the {@link Widget} to hide
   * @param newWidget the {@link Widget} to show
   * @param animate true to animate, false to switch instantly
   */
  void showWidget(Widget oldWidget, Widget newWidget, bool animate) {
    // Immediately complete previous animation
    cancel();

    // Get the container and index of the new widget
    dart_html.Element newContainer = DeckPanel._getContainer(newWidget);
    int newIndex = newContainer.parent.children.indexOf(newContainer);

    // If we aren't showing anything, don't bother with the animation
    if (oldWidget == null) {
      UiObject.setVisible(newContainer, true);
      newWidget.visible = true;
      return;
    }
    this.oldWidget = oldWidget;

    // Get the container and index of the old widget
    dart_html.Element oldContainer = DeckPanel._getContainer(oldWidget);
    int oldIndex = oldContainer.parent.children.indexOf(oldContainer);

    // Figure out whether to grow or shrink the container
    if (newIndex > oldIndex) {
      container1 = oldContainer;
      container2 = newContainer;
      growing = false;
    } else {
      container1 = newContainer;
      container2 = oldContainer;
      growing = true;
    }

    // Start the animation
    if (animate) {
      // Figure out if the deck panel has a fixed height
      dart_html.Element deckElem = container1.parent;
      int deckHeight = deckElem.offsetHeight;
      if (growing) {
        fixedHeight = container2.offsetHeight;
        container2.style.height = (dart_math.max(1, fixedHeight - 1)).toString().concat(Unit.PX.value);
      } else {
        fixedHeight = container1.getOffsetHeight();
        container1.style.height = (dart_math.max(1, fixedHeight - 1)).toString().concat(Unit.PX.value);
      }
      if (deckElem.offsetHeight != deckHeight) {
        fixedHeight = -1;
      }

      // Only scope to the deck if it's fixed height, otherwise it can affect
      // the rest of the page, even if it's not visible to the user.
      run(DeckPanel._ANIMATION_DURATION, element:fixedHeight == -1 ? null : deckElem);
    } else {
      onInstantaneousRun();
    }

    // We call newWidget.setVisible(true) immediately after showing the
    // widget's container so users can delay render their widget. Ultimately,
    // we should have a better way of handling this, but we need to call
    // setVisible for legacy support.
    newWidget.visible = true;
  }

  void onComplete() {
    if (growing) {
      container1.style.height = "100%";
      UiObject.setVisible(container1, true);
      UiObject.setVisible(container2, false);
      container2.style.height = "100%";
    } else {
      UiObject.setVisible(container1, false);
      container1.style.height = "100%";
      container2.style.height = "100%";
      UiObject.setVisible(container2, true);
    }
    container1.style.overflow = "visible";
    container2.style.overflow = "visible";
    container1 = null;
    container2 = null;
    hideOldWidget();
  }

  void onStart() {
    // Start the animation
    container1.style.overflow = "hidden";
    container2.style.overflow = "hidden";
    onUpdate(0.0);
    UiObject.setVisible(container1, true);
    UiObject.setVisible(container2, true);
  }

  void onUpdate(double progress) {
    if (!growing) {
      progress = 1.0 - progress;
    }

    // Container1 expands (shrinks) to its target height
    int height1;
    int height2;
    if (fixedHeight == -1) {
      height1 = (progress * Dom.getElementPropertyInt(container1, "scrollHeight")).toInt();
      height2 = ((1.0 - progress) * Dom.getElementPropertyInt(container2, "scrollHeight")).toInt();
    } else {
      height1 = (progress * fixedHeight).toInt();
      height2 = fixedHeight - height1;
    }

    // Issue 2339: If the height is 0px, IE7 will display the entire content
    // widget instead of hiding it completely.
    if (height1 == 0) {
      height1 = 1;
      height2 = dart_math.max(1, height2 - 1);
    } else if (height2 == 0) {
      height2 = 1;
      height1 = dart_math.max(1, height1 - 1);
    }
    container1.style.height = height1.toString().concat("px");
    container2.style.height = height2.toString().concat("px");
  }

  /**
   * Hide the old widget when the animation completes.
   */
  void hideOldWidget() {
    // Issue 2510: Hiding the widget isn't necessary because we hide its
    // wrapper, but its in here for legacy support.
    oldWidget.visible = false;
    oldWidget = null;
  }

  void onInstantaneousRun() {
    UiObject.setVisible(container1, growing);
    UiObject.setVisible(container2, !growing);
    container1 = null;
    container2 = null;
    hideOldWidget();
  }
}
