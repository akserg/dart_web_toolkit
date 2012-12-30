//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_text;

/**
 * See <a
 * href="http://java.sun.com/javase/6/docs/api/java/lang/Appendable.html">the
 * official Java API doc</a> for details.
 */
abstract class Appendable {
  
//  Appendable append(char c) throws IOException;
//
//  Appendable append(CharSequence charSquence) throws IOException;
//
//  Appendable append(CharSequence charSquence, int start, int end) throws IOException;
  
  Appendable append(String text);
}
