//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * An object that can render other objects of a particular type into plain-text
 * form. Allows decoupling that is useful for a dependency-injection
 * architecture.
 * 
 * @param <T> the type to render
 */
abstract class Renderer<T> {
  
  /**
   * Renders {@code object} as plain text. Should never throw any exceptions!
   */
  String render(T object);

  /**
   * Renders {@code object} as plain text, appended directly to {@code
   * appendable}. Should never throw any exceptions except if {@code appendable}
   * throws an {@code IOException}.
   */
  void renderTo(T object, Appendable appendable);
}
