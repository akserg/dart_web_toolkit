//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * An object that can render other objects of a particular type into safe HTML
 * form. Allows decoupling that is useful for a dependency-injection
 * architecture.
 *
 * @param <T> the type to render
 */
abstract class SafeHtmlRenderer<T> {

  /**
   * Renders {@code object} as safe HTML, appended directly to {@code builder}.
   */
  void render(T object, [SafeHtmlBuilder builder = null]);
}