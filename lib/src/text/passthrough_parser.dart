//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * A no-op String parser.
 */
class PassthroughParser implements Parser<String> {

  static PassthroughParser _instance;

  /**
   * Returns the instance of the no-op renderer.
   */
  factory PassthroughParser.instance() {
    if (_instance == null) {
      _instance = new PassthroughParser();
    }
    return _instance;
  }

  PassthroughParser();

  String parse(String text) { //CharSequence object) {
    return text as String;
  }
}
