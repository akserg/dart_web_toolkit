//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that displays the image at a given URL. The image can be in
 * 'unclipped' mode (the default) or 'clipped' mode. In clipped mode, a viewport
 * is overlaid on top of the image so that a subset of the image will be
 * displayed. In unclipped mode, there is no viewport - the entire image will be
 * visible. Whether an image is in clipped or unclipped mode depends on how the
 * image is constructed, and how it is transformed after construction. Methods
 * will operate differently depending on the mode that the image is in. These
 * differences are detailed in the documentation for each method.
 *
 * <p>
 * If an image transitions between clipped mode and unclipped mode, any
 * {@link Element}-specific attributes added by the user (including style
 * attributes, style names, and style modifiers), except for event listeners,
 * will be lost.
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <dl>
 * <dt>.gwt-Image</dt>
 * </dd>The outer element</dd>
 * </dl>
 *
 * Tranformations between clipped and unclipped state will result in a loss of
 * any style names that were set/added; the only style names that are preserved
 * are those that are mentioned in the static CSS style rules. Due to
 * browser-specific HTML constructions needed to achieve the clipping effect,
 * certain CSS attributes, such as padding and background, may not work as
 * expected when an image is in clipped mode. These limitations can usually be
 * easily worked around by encapsulating the image in a container widget that
 * can itself be styled.
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.ImageExample}
 * </p>
 */
class Image extends Widget implements HasLoadHandlers, HasErrorHandlers,
  HasClickHandlers, HasDoubleClickHandlers, HasAllDragAndDropHandlers,
  HasAllGestureHandlers, HasAllMouseHandlers, HasAllTouchHandlers {

  /**
   * The attribute that is set when an image fires a native load or error event
   * before it is attached.
   */
  static final String UNHANDLED_EVENT_ATTR = "dwtLastUnhandledEvent";

  /**
   * This map is used to store prefetched images. If a reference is not kept to
   * the prefetched image objects, they can get garbage collected, which
   * sometimes keeps them from getting fully fetched.
   */
  static Map<String, dart_html.Element> prefetchImages = new Map<String, dart_html.Element>();

  /**
   * Causes the browser to pre-fetch the image at a given URL.
   *
   * @param url the URL of the image to be prefetched
   */
  static void prefetch(String url) {
    dart_html.ImageElement img = new dart_html.ImageElement();
    img.src = url;
    prefetchImages[url] = img;
  }

  /**
   * Causes the browser to pre-fetch the image at a given URL.
   *
   * @param url the URL of the image to be prefetched
   */
  static void prefetchSafe(SafeUri url) {
    prefetch(url.asString());
  }

  /**
   * Creates a Image widget that wraps an existing &lt;img&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory Image.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    Image image = new Image.fromElement(element);

    // Mark it attached and remember it for cleanup.
    image.onAttach();
    RootPanel.detachOnWindowClose(image);

    return image;
  }

  _State _state;

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be an &lt;img&gt; element.
   *
   * @param element the element to be used
   */
  Image.fromElement(dart_html.ImageElement element) {
    setElement(element);
    changeState(new _UnclippedState(element:element));
  }

  /**
   * Creates an image with a specified URL. The load event will be fired once
   * the image at the given URL has been retrieved by the browser.
   *
   * @param url the URL of the image to be displayed
   */
  Image(String url) : this.safe(UriUtils.unsafeCastFromUntrustedString(url));

  /**
   * Creates an image with a specified URL. The load event will be fired once
   * the image at the given URL has been retrieved by the browser.
   *
   * @param url the URL of the image to be displayed
   */
  Image.safe(SafeUri url) {
    changeState(new _UnclippedState(image:this, url:url));
    clearAndSetStyleName("dwt-Image");
  }

  /**
   * Creates a clipped image with a specified URL and visibility rectangle. The
   * visibility rectangle is declared relative to the the rectangle which
   * encompasses the entire image, which has an upper-left vertex of (0,0). The
   * load event will be fired immediately after the object has been constructed
   * (i.e. potentially before the image has been loaded in the browser). Since
   * the width and height are specified explicitly by the user, this behavior
   * will not cause problems with retrieving the width and height of a clipped
   * image in a load event handler.
   *
   * @param url the URL of the image to be displayed
   * @param left the horizontal co-ordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param top the vertical co-ordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param width the width of the visibility rectangle
   * @param height the height of the visibility rectangle
   */
  Image.clipped(String url, int left, int top, int width, int height) : this.clippedSafe(UriUtils.unsafeCastFromUntrustedString(url), left, top, width, height);

  /**
   * Creates a clipped image with a specified URL and visibility rectangle. The
   * visibility rectangle is declared relative to the the rectangle which
   * encompasses the entire image, which has an upper-left vertex of (0,0). The
   * load event will be fired immediately after the object has been constructed
   * (i.e. potentially before the image has been loaded in the browser). Since
   * the width and height are specified explicitly by the user, this behavior
   * will not cause problems with retrieving the width and height of a clipped
   * image in a load event handler.
   *
   * @param url the URL of the image to be displayed
   * @param left the horizontal co-ordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param top the vertical co-ordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param width the width of the visibility rectangle
   * @param height the height of the visibility rectangle
   */
  Image.clippedSafe(SafeUri url, int left, int top, int width, int height) {
    changeState(new _ClippedState(this, url, left, top, width, height));
    clearAndSetStyleName("dwt-Image");
  }

  //***********************************
  // Implementation of HasClickHandlers
  //***********************************

  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addHandler(handler, ClickEvent.TYPE);
  }

  HandlerRegistration addDoubleClickHandler(DoubleClickHandler handler) {
    return addHandler(handler, DoubleClickEvent.TYPE);
  }

  HandlerRegistration addDragEndHandler(DragEndHandler handler) {
    return addDomHandler(handler, DragEndEvent.TYPE);
  }

  HandlerRegistration addDragEnterHandler(DragEnterHandler handler) {
    return addDomHandler(handler, DragEnterEvent.TYPE);
  }

  HandlerRegistration addDragHandler(DragHandler handler) {
    return addDomHandler(handler, DragEvent.TYPE);
  }

  HandlerRegistration addDragLeaveHandler(DragLeaveHandler handler) {
    return addDomHandler(handler, DragLeaveEvent.TYPE);
  }

  HandlerRegistration addDragOverHandler(DragOverHandler handler) {
    return addDomHandler(handler, DragOverEvent.TYPE);
  }

  HandlerRegistration addDragStartHandler(DragStartHandler handler) {
    return addDomHandler(handler, DragStartEvent.TYPE);
  }

  HandlerRegistration addDropHandler(DropHandler handler) {
    return addDomHandler(handler, DropEvent.TYPE);
  }

  HandlerRegistration addErrorHandler(ErrorHandler handler) {
    return addHandler(handler, ErrorEvent.TYPE);
  }

  HandlerRegistration addGestureChangeHandler(GestureChangeHandler handler) {
    return addDomHandler(handler, GestureChangeEvent.TYPE);
  }

  HandlerRegistration addGestureEndHandler(GestureEndHandler handler) {
    return addDomHandler(handler, GestureEndEvent.TYPE);
  }

  HandlerRegistration addGestureStartHandler(GestureStartHandler handler) {
    return addDomHandler(handler, GestureStartEvent.TYPE);
  }

  HandlerRegistration addLoadHandler(LoadHandler handler) {
    return addHandler(handler, LoadEvent.TYPE);
  }

  HandlerRegistration addMouseDownHandler(MouseDownHandler handler) {
    return addDomHandler(handler, MouseDownEvent.TYPE);
  }

  HandlerRegistration addMouseMoveHandler(MouseMoveHandler handler) {
    return addDomHandler(handler, MouseMoveEvent.TYPE);
  }

  HandlerRegistration addMouseOutHandler(MouseOutHandler handler) {
    return addDomHandler(handler, MouseOutEvent.TYPE);
  }

  HandlerRegistration addMouseOverHandler(MouseOverHandler handler) {
    return addDomHandler(handler, MouseOverEvent.TYPE);
  }

  HandlerRegistration addMouseUpHandler(MouseUpHandler handler) {
    return addDomHandler(handler, MouseUpEvent.TYPE);
  }

  HandlerRegistration addMouseWheelHandler(MouseWheelHandler handler) {
    return addDomHandler(handler, MouseWheelEvent.TYPE);
  }

  HandlerRegistration addTouchCancelHandler(TouchCancelHandler handler) {
    return addDomHandler(handler, TouchCancelEvent.TYPE);
  }

  HandlerRegistration addTouchEndHandler(TouchEndHandler handler) {
    return addDomHandler(handler, TouchEndEvent.TYPE);
  }

  HandlerRegistration addTouchMoveHandler(TouchMoveHandler handler) {
    return addDomHandler(handler, TouchMoveEvent.TYPE);
  }

  HandlerRegistration addTouchStartHandler(TouchStartHandler handler) {
    return addDomHandler(handler, TouchStartEvent.TYPE);
  }


  /**
   * Gets the alternate text for the image.
   *
   * @return the alternate text for the image
   */
  String getAltText() {
    return _state.getImageElement(this).alt;
  }

  /**
   * Sets the alternate text of the image for user agents that can't render the
   * image.
   *
   * @param altText the alternate text to set to
   */
  void setAltText(String altText) {
    _state.getImageElement(this).alt = altText;
  }

  /**
   * Gets the height of the image. When the image is in the unclipped state, the
   * height of the image is not known until the image has been loaded (i.e. load
   * event has been fired for the image).
   *
   * @return the height of the image, or 0 if the height is unknown
   */
  int getHeight() {
    return _state.getHeight(this);
  }

  /**
   * Gets the horizontal co-ordinate of the upper-left vertex of the image's
   * visibility rectangle. If the image is in the unclipped state, then the
   * visibility rectangle is assumed to be the rectangle which encompasses the
   * entire image, which has an upper-left vertex of (0,0).
   *
   * @return the horizontal co-ordinate of the upper-left vertex of the image's
   *         visibility rectangle
   */
  int getOriginLeft() {
    return _state.getOriginLeft();
  }

  /**
   * Gets the vertical co-ordinate of the upper-left vertex of the image's
   * visibility rectangle. If the image is in the unclipped state, then the
   * visibility rectangle is assumed to be the rectangle which encompasses the
   * entire image, which has an upper-left vertex of (0,0).
   *
   * @return the vertical co-ordinate of the upper-left vertex of the image's
   *         visibility rectangle
   */
  int getOriginTop() {
    return _state.getOriginTop();
  }

  /**
   * Gets the URL of the image. The URL that is returned is not necessarily the
   * URL that was passed in by the user. It may have been transformed to an
   * absolute URL.
   *
   * @return the image URL
   */
  String getUrl() {
    return _state.getUrl(this).asString();
  }

  /**
   * Sets the URL of the image to be displayed. If the image is in the clipped
   * state, a call to this method will cause a transition of the image to the
   * unclipped state. Regardless of whether or not the image is in the clipped
   * or unclipped state, a load event will be fired.
   *
   * @param url the image URL
   */
  void setSafeUrl(SafeUri url) {
    _state.setUrl(this, url);
  }

  /**
   * Sets the URL of the image to be displayed. If the image is in the clipped
   * state, a call to this method will cause a transition of the image to the
   * unclipped state. Regardless of whether or not the image is in the clipped
   * or unclipped state, a load event will be fired.
   *
   * @param url the image URL
   */
  void setUrl(String url) {
    setSafeUrl(UriUtils.unsafeCastFromUntrustedString(url));
  }

  /**
   * Gets the width of the image. When the image is in the unclipped state, the
   * width of the image is not known until the image has been loaded (i.e. load
   * event has been fired for the image).
   *
   * @return the width of the image, or 0 if the width is unknown
   */
  int getWidth() {
    return _state.getWidth(this);
  }

  void onBrowserEvent(dart_html.Event event) {
    // We have to clear the unhandled event before firing handlers because the
    // handlers could trigger onLoad, which would refire the event.
    if (Dom.eventGetType(event) == Event.ONLOAD) {
      clearUnhandledEvent();
      _state.onLoadEvent(this);
    }

    super.onBrowserEvent(event);
  }

  /**
   * Sets the url and the visibility rectangle for the image at the same time,
   * based on an ImageResource instance. A single load event will be fired if
   * either the incoming url or visiblity rectangle co-ordinates differ from the
   * image's current url or current visibility rectangle co-ordinates. If the
   * image is currently in the unclipped state, a call to this method will cause
   * a transition to the clipped state.
   *
   * @param resource the ImageResource to display
   */
//  void setResource(ImageResource resource) {
//    setUrlAndVisibleRect(resource.getSafeUri(), resource.getLeft(), resource.getTop(),
//        resource.getWidth(), resource.getHeight());
//  }

  /**
   * Sets the url and the visibility rectangle for the image at the same time. A
   * single load event will be fired if either the incoming url or visiblity
   * rectangle co-ordinates differ from the image's current url or current
   * visibility rectangle co-ordinates. If the image is currently in the
   * unclipped state, a call to this method will cause a transition to the
   * clipped state.
   *
   * @param url the image URL
   * @param left the horizontal coordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param top the vertical coordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param width the width of the visibility rectangle
   * @param height the height of the visibility rectangle
   */
  void setSafeUrlAndVisibleRect(SafeUri url, int left, int top, int width, int height) {
    _state.setUrlAndVisibleRect(this, url, left, top, width, height);
  }

  /**
   * Sets the url and the visibility rectangle for the image at the same time. A
   * single load event will be fired if either the incoming url or visiblity
   * rectangle co-ordinates differ from the image's current url or current
   * visibility rectangle co-ordinates. If the image is currently in the
   * unclipped state, a call to this method will cause a transition to the
   * clipped state.
   *
   * @param url the image URL
   * @param left the horizontal coordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param top the vertical coordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param width the width of the visibility rectangle
   * @param height the height of the visibility rectangle
   */
  void setUrlAndVisibleRect(String url, int left, int top, int width, int height) {
    setSafeUrlAndVisibleRect(UriUtils.unsafeCastFromUntrustedString(url), left, top, width, height);
  }

  /**
   * Sets the visibility rectangle of an image. The visibility rectangle is
   * declared relative to the the rectangle which encompasses the entire image,
   * which has an upper-left vertex of (0,0). Provided that any of the left,
   * top, width, and height parameters are different than the those values that
   * are currently set for the image, a load event will be fired. If the image
   * is in the unclipped state, a call to this method will cause a transition of
   * the image to the clipped state. This transition will cause a load event to
   * fire.
   *
   * @param left the horizontal coordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param top the vertical coordinate of the upper-left vertex of the
   *          visibility rectangle
   * @param width the width of the visibility rectangle
   * @param height the height of the visibility rectangle
   */
  void setVisibleRect(int left, int top, int width, int height) {
    _state.setVisibleRect(this, left, top, width, height);
  }

  void onLoad() {
    super.onLoad();

    // Issue 863: the state may need to fire a synthetic event if the native
    // onload event fired while the image was detached.
    _state.onLoad(this);
  }

  void changeState(_State newState) {
    _state = newState;
  }

  /**
   * Clear the unhandled event.
   */
  void clearUnhandledEvent() {
    if (_state != null) {
      _state.getImageElement(this).dataAttributes[Image.UNHANDLED_EVENT_ATTR] = "";
    }
  }
}

/**
 * Abstract class which is used to hold the state associated with an image
 * object.
 */
abstract class _State {

  /**
   * The pending command to create a synthetic event.
   */
  ScheduledCommand syntheticEventCommand = null;

  int getHeight(Image image);

  dart_html.ImageElement getImageElement(Image image);

  int getOriginLeft();

  int getOriginTop();

  SafeUri getUrl(Image image);

  int getWidth(Image image);

  /**
   * Called when the widget is attached to the page. Not to be confused with
   * the load event that fires when the image loads.
   *
   * @param image the widget
   */
  void onLoad(Image image) {
    // If an onload event fired while the image wasn't attached, we need to
    // synthesize one now.
    String unhandledEvent = getImageElement(image).dataAttributes[Image.UNHANDLED_EVENT_ATTR];
    if (BrowserEvents.LOAD == unhandledEvent) {
      fireSyntheticLoadEvent(image);
    }
  }

  /**
   * Called when a load event is handled by the widget.
   *
   * @param image the widget
   */
  void onLoadEvent(Image image) {
    // Overridden by ClippedState.
  }

  void setUrl(Image image, SafeUri url);

  void setUrlAndVisibleRect(Image image, SafeUri url, int left, int top,
                                            int width, int height);

  void setVisibleRect(Image image, int left, int top, int width, int height);

  /**
   * We need to synthesize a load event in case the image loads synchronously,
   * before our handlers can be attached.
   *
   * @param image the image on which to dispatch the event
   */
  void fireSyntheticLoadEvent(Image image) {
    /*
     * We use a deferred command here to simulate the native version of the
     * event as closely as possible. In the native event case, it is unlikely
     * that a second load event would occur while you are in the load event
     * handler.
     */
    syntheticEventCommand = new StateScheduledCommand(this, image);
    Scheduler.get().scheduleDeferred(syntheticEventCommand);
  }

  // This method is used only by unit tests.
  String getStateName();
}

class StateScheduledCommand extends ScheduledCommand {

  _State _state;
  Image _image;

  StateScheduledCommand(this._state, this._image);

  void execute() {
    /*
     * The state has been replaced, or another load event is already
     * pending.
     */
    if (_image._state != _state || this != _state.syntheticEventCommand) {
      return;
    }
    _state.syntheticEventCommand = null;

    /*
     * The image is not attached, so we cannot safely fire the event. We
     * still want the event to fire eventually, so we mark an unhandled
     * load event, which will trigger a new synthetic event the next time
     * the widget is attached.
     */
    if (!_image.isAttached()) {
      _state.getImageElement(_image).dataAttributes[Image.UNHANDLED_EVENT_ATTR] = BrowserEvents.LOAD;
      return;
    }

    dart_html.Event evt =  Dom.createLoadEvent();
    _state.getImageElement(_image).$dom_dispatchEvent(evt);
  }
}

/**
 * Implementation of behaviors associated with the clipped state of an image.
 */
class _ClippedState extends _State {

  static ClippedImageImpl impl = new ClippedImageImpl(); //GWT.create(ClippedImageImpl.class);

  int height = 0;
  int left = 0;
  bool pendingNativeLoadEvent = true;
  int top = 0;
  SafeUri url = null;
  int width = 0;

  _ClippedState(Image image, this.url, this.left, this.top, this.width, this.height) {
    this.left = left;
    this.top = top;
    this.width = width;
    this.height = height;
    this.url = url;
    image.replaceElement(impl.createStructure(url, left, top, width, height));
    // Todo(ecc) This is wrong, we should not be sinking these here on such a
    // common widget.After the branch is stable, this should be fixed.
    image.sinkEvents(Event.ONCLICK | Event.ONDBLCLICK | Event.MOUSEEVENTS | Event.ONMOUSEWHEEL
        | Event.ONLOAD | Event.TOUCHEVENTS | Event.GESTUREEVENTS);
  }

  int getHeight(Image image) {
    return height;
  }

  dart_html.ImageElement getImageElement(Image image) {
    return impl.getImgElement(image) as dart_html.ImageElement;
  }

  int getOriginLeft() {
    return left;
  }

  int getOriginTop() {
    return top;
  }

  SafeUri getUrl(Image image) {
    return url;
  }

  int getWidth(Image image) {
    return width;
  }

  void onLoadEvent(Image image) {
    // A load event has fired.
    pendingNativeLoadEvent = false;
    super.onLoadEvent(image);
  }

  void setUrl(Image image, SafeUri url) {
    image.changeState(new _UnclippedState(image:image));
    // Need to make sure we change the state before an onload event can fire,
    // or handlers will be fired while we are in the old state.
    image.setSafeUrl(url);
  }

  void setUrlAndVisibleRect(Image image, SafeUri url, int left, int top, int width,
                                   int height) {
    /*
     * In the event that the clipping rectangle has not changed, we want to
     * skip all of the work required with a getImpl().adjust, and we do not
     * want to fire a load event.
     */
    if (!this.url.equals(url) || this.left != left || this.top != top || this.width != width
        || this.height != height) {

      this.url = url;
      this.left = left;
      this.top = top;
      this.width = width;
      this.height = height;

      impl.adjust(image.getElement(), url, left, top, width, height);

      /*
       * The native load event hasn't fired yet, so we don't need to
       * synthesize an event. If we did synthesize an event, we would get two
       * load events.
       */
      if (!pendingNativeLoadEvent) {
        fireSyntheticLoadEvent(image);
      }
    }
  }

  void setVisibleRect(Image image, int left, int top, int width, int height) {
    setUrlAndVisibleRect(image, url, left, top, width, height);
  }

  /* This method is used only by unit tests */
  String getStateName() {
    return "clipped";
  }
}

/**
 * Implementation of behaviors associated with the unclipped state of an
 * image.
 */
class _UnclippedState extends _State {

  _UnclippedState({dart_html.Element element, Image image, SafeUri url}) {
    if (?image) {
      image.replaceElement(new dart_html.ImageElement());
      // We are working around an IE race condition that can make the image
      // incorrectly cache itself if the load event is assigned at the same time
      // as the image is added to the dom.
      Event.sinkEvents(image.getElement(), Event.ONLOAD);

      // Todo(ecc) this could be more efficient overall.
      image.sinkEvents(Event.ONCLICK | Event.ONDBLCLICK | Event.MOUSEEVENTS | Event.ONLOAD
          | Event.ONERROR | Event.ONMOUSEWHEEL | Event.TOUCHEVENTS | Event.GESTUREEVENTS);
      
      if (?url) {
        setUrl(image, url);
      }
    } else if (element != null){
      // This case is relatively unusual, in that we swapped a clipped image
      // out, so does not need to be efficient.
      Event.sinkEvents(element, Event.ONCLICK | Event.ONDBLCLICK | Event.MOUSEEVENTS | Event.ONLOAD
          | Event.ONERROR | Event.ONMOUSEWHEEL | Event.TOUCHEVENTS | Event.GESTUREEVENTS);
    }
  }

  int getHeight(Image image) {
    return getImageElement(image).height;
  }

  dart_html.ImageElement getImageElement(Image image) {
    return image.getElement() as dart_html.ImageElement;
  }

  int getOriginLeft() {
    return 0;
  }

  int getOriginTop() {
    return 0;
  }

  SafeUri getUrl(Image image) {
    return UriUtils.unsafeCastFromUntrustedString(getImageElement(image).src);
  }

  int getWidth(Image image) {
    return getImageElement(image).width;
  }

  void setUrl(Image image, SafeUri url) {
    image.clearUnhandledEvent();
    getImageElement(image).src = url.asString();
  }

  void setUrlAndVisibleRect(Image image, SafeUri url, int left, int top, int width,
                                   int height) {
    image.changeState(new _ClippedState(image, url, left, top, width, height));
  }

  void setVisibleRect(Image image, int left, int top, int width, int height) {
    image.changeState(new _ClippedState(image, getUrl(image), left, top, width, height));
  }

  // This method is used only by unit tests.
  String getStateName() {
    return "unclipped";
  }
}