//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A type of widget that can wrap another widget, hiding the wrapped widget's
 * methods. When added to a panel, a composite behaves exactly as if the widget
 * it wraps had been added.
 *
 * <p>
 * The composite is useful for creating a single widget out of an aggregate of
 * multiple other widgets contained in a single panel.
 * </p>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.CompositeExample}
 * </p>
 */
abstract class Composite extends Widget implements IsRenderable {
  
  Widget _widget;

  IsRenderable _renderable;
//
//  dart_html.Element _elementToWrap;
  
//  //*******************************
//  // Implementation of IsRenderable
//  //*******************************
//  
//  /**
//   * Replace the previous contents of the receiver with the given element,
//   * presumed to have been created and stamped via a previous call to
//   * {@link #render}.
//   */
//  void claimElement(dart_html.Element element) {
//    if (_renderable != null) {
//      _renderable.claimElement(element);
//      setElement(_widget.getElement());
//    } else {
//      this._elementToWrap = element;
//    }
//  }
//
//  /**
//   * Perform any initialization needed when the widget is not attached to
//   * the document. Assumed to be called after {@link #claimElement}.
//   */
//  void initializeClaimedElement() {
//    if (_renderable != null) {
//      _renderable.initializeClaimedElement();
//    } else {
//      _elementToWrap.getParentNode().replaceChild(_widget.getElement(), _elementToWrap);
//    }
//  }
//
//  /**
//   * @see #render(RendearbleStamper, SafeHtmlBuilder)
//   * TODO(rdcastro): Remove this once UiBinder doesn't rely on it anymore.
//   */
//  SafeHtml render(RenderableStamper stamper);

//  /**
//   * Tells this object to render itself as HTML and append it to the given builder.
//   * If the implementation expects to be able to claim an element later, it must be
//   * marked by the given stamper.
//   */
//  void render(RenderableStamper stamper, SafeHtmlBuilder builder);
  
  /**
   * Returns whether or not the receiver is attached to the
   * {@link com.google.gwt.dom.client.Document Document}'s
   * {@link com.google.gwt.dom.client.BodyElement BodyElement}.
   *
   * @return true if attached, false otherwise
   */
  bool isAttached() {
    if (_widget != null) {
      return _widget.isAttached();
    }
    return false;
  }
  
//********************************
  // Implementation of EventListener
  //********************************
  /**
   * Fired whenever a browser event is received.
   *
   * @param event the event received
   *
   * TODO
   */
  void onBrowserEvent(dart_html.Event event) {
    // Fire any handler added to the composite itself.
    super.onBrowserEvent(event);

    // Delegate events to the widget.
    _widget.onBrowserEvent(event);
  }
  
  /**
   * Provides subclasses access to the topmost widget that defines this
   * composite.
   * 
   * @return the widget
   */
  Widget getWidget() {
    return _widget;
  }
  
  /**
   * Sets the widget to be wrapped by the composite. The wrapped widget must be
   * set before calling any {@link Widget} methods on this object, or adding it
   * to a panel. This method may only be called once for a given composite.
   * 
   * @param widget the widget to be wrapped
   */
  void initWidget(Widget widget) {
    // Validate. Make sure the widget is not being set twice.
    if (this._widget != null) {
      throw new Exception("Composite.initWidget() may only be called once.");
    }

    if (widget is IsRenderable) {
      // In case the Widget being wrapped is an IsRenderable, we save that fact.
      this._renderable = widget as IsRenderable;
    }

    // Detach the new child.
    widget.removeFromParent();

    // Use the contained widget's element as the composite's element,
    // effectively merging them within the DOM.
    dart_html.Element elem = widget.getElement();
    setElement(elem);

//    if (PotentialElement.isPotential(elem)) {
//      PotentialElement.as(elem).setResolver(this);
//    }

    // Logical attach.
    this._widget = widget;

    // Adopt.
    widget.setParent(this);
  }
  
  //*******
  // Attach
  //*******
  
  /**
   * <p>
   * This method is called when a widget is attached to the browser's document.
   * To receive notification after a Widget has been added to the document,
   * override the {@link #onLoad} method or use {@link #addAttachHandler}.
   * </p>
   * <p>
   * It is strongly recommended that you override {@link #onLoad()} or
   * {@link #doAttachChildren()} instead of this method to avoid inconsistencies
   * between logical and physical attachment states.
   * </p>
   * <p>
   * Subclasses that override this method must call
   * <code>super.onAttach()</code> to ensure that the Widget has been attached
   * to its underlying Element.
   * </p>
   *
   * @throws IllegalStateException if this widget is already attached
   * @see #onLoad()
   * @see #doAttachChildren()
   */
  void onAttach() {
    if (!isOrWasAttached()) {
//      _widget.sinkEvents(eventsToSink);
//      eventsToSink = -1;
    }

    _widget.onAttach();

    // Clobber the widget's call to setEventListener(), causing all events to
    // be routed to this composite, which will delegate back to the widget by
    // default (note: it's not necessary to clear this in onDetach(), because
    // the widget's onDetach will do so).
    Dom.setEventListener(getElement(), this);

    // Call onLoad() directly, because we're not calling super.onAttach().
    onLoad();
    AttachEvent.fire(this, true);
  }
  
  /**
   * <p>
   * This method is called when a widget is detached from the browser's
   * document. To receive notification before a Widget is removed from the
   * document, override the {@link #onUnload} method or use {@link #addAttachHandler}.
   * </p>
   * <p>
   * It is strongly recommended that you override {@link #onUnload()} or
   * {@link #doDetachChildren()} instead of this method to avoid inconsistencies
   * between logical and physical attachment states.
   * </p>
   * <p>
   * Subclasses that override this method must call
   * <code>super.onDetach()</code> to ensure that the Widget has been detached
   * from the underlying Element. Failure to do so will result in application
   * memory leaks due to circular references between DOM Elements and JavaScript
   * objects.
   * </p>
   *
   * @throws IllegalStateException if this widget is already detached
   * @see #onUnload()
   * @see #doDetachChildren()
   */
  void onDetach() {
    try {
      onUnload();
      AttachEvent.fire(this, false);
    } finally {
      // We don't want an exception in user code to keep us from calling the
      // super implementation (or event listeners won't get cleaned up and
      // the attached flag will be wrong).
      _widget.onDetach();
    }
  }
}
