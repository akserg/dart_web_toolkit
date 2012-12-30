//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * An object that can parse text and return a value.
 *
 * @param <T> the type to parse
 */
abstract class Parser<T> {
  
  T parse(String text);
}
