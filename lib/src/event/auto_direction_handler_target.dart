//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * The interface an object must implement in order to add an
 * AutoDirectionHandler to it.
*
 * TODO(tomerigo): add Paste and Input events once they're available in GWT.
 */
abstract class AutoDirectionHandlerTarget implements HasText, HasDirection, HasKeyUpHandlers {

}
