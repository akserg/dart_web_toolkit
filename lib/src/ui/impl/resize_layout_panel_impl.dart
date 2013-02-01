//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

abstract class ResizeLayoutPanelImpl {

  /**
   * Create instance of [ResizeLayoutPanelImpl] depends on broswer.
   */
  factory ResizeLayoutPanelImpl.browserDependent() {
    return new ResizeLayoutPanelImplStandard();
  }

  bool isAttached;
  dart_html.Element parent;
  ResizeDelegate delegate;

  ResizeLayoutPanelImpl();

  /**
   * Initialize the implementation.
   *
   * @param elem the element to listen for resize
   * @param delegate the {@link Delegate} to inform when resize occurs
   */
  void init(dart_html.Element elem, ResizeDelegate delegate) {
    this.parent = elem;
    this.delegate = delegate;
  }

  /**
   * Called on attach.
   */
  void onAttach() {
    isAttached = true;
  }

  /**
   * Called on detach.
   */
  void onDetach() {
    isAttached = false;
  }

  /**
   * Handle a resize event.
   */
  void handleResize() {
    if (isAttached && delegate != null) {
      delegate.onResize();
    }
  }
}

/**
 * Delegate event handler.
 */
abstract class ResizeDelegate {

  /**
   * Called when the element is resized.
   */
  void onResize();
}