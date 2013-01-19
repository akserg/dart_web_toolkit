//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

abstract class HasAttachHandlers extends HasHandlers {
  /**
   * Adds an {@link AttachEvent} handler.
   *
   * @param handler the handler
   * @return the handler registration
   */
  HandlerRegistration addAttachHandler(AttachEventHandler handler);

  /**
   * Returns whether or not the receiver is attached to the
   * {@link com.google.gwt.dom.client.Document Document}'s
   * {@link com.google.gwt.dom.client.BodyElement BodyElement}.
   *
   * @return true if attached, false otherwise
   */
  bool isAttached();
}
