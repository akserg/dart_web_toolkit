//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Abstract implementation of a renderer to make implementation of rendering
 * simpler.
 * 
 * @param <T> the type to render
 */
abstract class AbstractRenderer<T> implements Renderer<T> {
  void renderTo(T object, Appendable appendable) {
    appendable.append(render(object));
  }
}
