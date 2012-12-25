//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * An object that can parse text and return a value.
 *
 * @param <T> the type to parse
 */
abstract class Parser<T> {
  //T parse(CharSequence text); // throws ParseException;
  T parse(String text);
}
