//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A ValueBox that uses {@link DoubleParser} and {@link DoubleRenderer}.
 */
class DoubleBox extends ValueBox<double> {

  DoubleBox() : super.fromElement(new dart_html.TextInputElement(), new DoubleRenderer.instance(), new DoubleParser.instance());
}
