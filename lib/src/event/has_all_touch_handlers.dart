//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * This is a convenience interface that includes all touch handlers defined by
 * the core GWT system.
 * <p>
 * WARNING, PLEASE READ: As this interface is intended for developers who wish
 * to handle all touch events in GWT, new touch event handlers will be added to
 * it. Therefore, updates can cause breaking API changes.
 * </p>
 */
abstract class HasAllTouchHandlers implements HasTouchStartHandlers,
  HasTouchMoveHandlers, HasTouchEndHandlers, HasTouchCancelHandlers {

}
