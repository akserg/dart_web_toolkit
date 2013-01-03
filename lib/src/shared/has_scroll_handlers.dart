//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link ScrollHandler} instances.
 */
abstract class HasScrollHandlers extends HasHandlers {
  
  /**
   * Adds a {@link ScrollEvent} handler.
   * 
   * @param handler the scroll handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addScrollHandler(ScrollHandler handler);
}
