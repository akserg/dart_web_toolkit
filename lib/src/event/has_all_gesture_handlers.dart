//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * This is a convenience interface that includes all gesture handlers defined by
 * the core GWT system.
 * <p>
 * WARNING, PLEASE READ: As this interface is intended for developers who wish
 * to handle all gesture events in GWT, new gesture event handlers will be added
 * to it. Therefore, updates can cause breaking API changes.
 * </p>
 */
abstract class HasAllGestureHandlers implements HasGestureStartHandlers,
  HasGestureChangeHandlers, HasGestureEndHandlers{

}
