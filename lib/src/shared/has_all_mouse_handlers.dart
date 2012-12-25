//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * This is a convenience interface that includes all mouse handlers defined by
 * the core GWT system.
 * <p>
 * WARNING, PLEASE READ: As this interface is intended for developers who wish
 * to handle all mouse events in GWT, new mouse event handlers will be added to
 * it. Therefore, updates can cause breaking API changes.
 * </p>
 */
abstract class HasAllMouseHandlers implements HasMouseDownHandlers,
  HasMouseUpHandlers, HasMouseOutHandlers, HasMouseOverHandlers,
  HasMouseMoveHandlers, HasMouseWheelHandlers{
  
}
