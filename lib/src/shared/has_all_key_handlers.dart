//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Convenience interface used to implement all key handlers at once.
 * 
 * <p>
 * WARNING, PLEASE READ: In the unlikely event that more key handler subtypes
 * are added to GWT, this interface will be expanded, so only implement this
 * interface if you wish to have your widget break if a new key event type is
 * introduced.
 * </p>
 */
abstract class HasAllKeyHandlers implements HasKeyUpHandlers,
    HasKeyDownHandlers, HasKeyPressHandlers {
  
}
