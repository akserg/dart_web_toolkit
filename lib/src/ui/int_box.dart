//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A ValueBox that uses {@link IntegerParser} and {@link IntegerRenderer}.
 */
class IntBox extends ValueBox<int> {

  IntBox() : super.fromElement(new dart_html.TextInputElement(), new IntRenderer.instance(), new IntParser.instance());
}