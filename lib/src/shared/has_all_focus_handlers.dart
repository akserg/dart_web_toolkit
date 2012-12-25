//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * This is a convenience interface that includes all focus handlers defined by
 * the core GWT system.
 * 
 * <p>
 * WARNING, PLEASE READ: As this interface is intended for developers who wish
 * to handle all focus events in GWT, in the unlikely event that a new focus
 * event is added, this interface will change.
 * </p>
 */
abstract class HasAllFocusHandlers implements HasFocusHandlers, HasBlurHandlers {
  
}
