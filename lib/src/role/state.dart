//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_role;

/**
 * <p>Class that contains constants for ARIA states. States combined with ARIA roles supply
 * information about the changes in the web page that can be used for alerts, notification,
 * navigation assistance. The state is changed as a result of an user interaction and developers
 * should consider changing the widget state when handling user actions.</p>
 *
 * <p>The following groups of states exist:
 * <ol>
 * <li>Widget states -- specific to common user interface elements found on GUI systems or
 * in rich Internet applications which receive user input and process user actions</li>
 * <li>Live Region states -- specific to live regions in rich Internet applications; may be applied
 * to any element; indicate that content changes may occur without the element having focus, and
 * provides assistive technologies with information on how to process those content updates. </li>
 * <li>Drag-and-drop states -- indicates information about draggable elements and their drop
 * targets</li>
 * </ol>
 * </p>
 */
class State {

  static final Attribute<PressedValue> PRESSED = new AriaValueAttribute<PressedValue>("aria-pressed", "undefined");
}
