//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_test;

/**
 * Mock implementation of Dart Element.
 */
class MockElement extends Mock implements dart_html.Element {
  /**
   * Gets the offset of this element relative to its offsetParent.
   */
  dart_html.Rect get offset => new dart_html.Rect(10, 20, 30, 40);
}

