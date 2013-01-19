//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Methods that need browser-specific implementations for Hyperlink.
 * By default, we're very conservative and let the browser handle any clicks
 * with non-left buttons or with modifier keys. This happens to be the correct
 * behavior for Firefox.
 */
class HyperlinkImpl {

  /**
   * Default version, useful for Firefox. Don't fire if it's a rightclick,
   * middleclick, or if any modifiers are held down.
   */
  bool handleAsClick(dart_html.MouseEvent event) {
    int mouseButtons = event.button;
    bool alt = event.altKey;
    bool ctrl = event.ctrlKey;
    bool meta = event.metaKey;
    bool shift = event.shiftKey;
    bool modifiers = alt || ctrl || meta || shift;
    bool middle = mouseButtons == 1;
    bool right = mouseButtons == 2;

    return !modifiers && !middle && !right;
  }
}
