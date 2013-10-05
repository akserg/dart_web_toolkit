//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * A no-op String renderer. This is rarely or never the right
 * thing to use in production, but it's handy for tests.
 */
class PassthroughRenderer extends AbstractRenderer<String> {

  static PassthroughRenderer _instance;

  /**
   * Returns the instance of the no-op renderer.
   */
  factory PassthroughRenderer.instance() {
    if (_instance == null) {
      _instance = new PassthroughRenderer();
    }
    return _instance;
  }

  PassthroughRenderer();

  String render(String object) {
    return object;
  }
}
