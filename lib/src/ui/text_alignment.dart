//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Alignment values for {@link ValueBoxBase#setAlignment}.
 */
class TextAlignment extends Enum<String> {

  const TextAlignment(String type) : super (type);

  static const TextAlignment CENTER = const TextAlignment("center");
  static const TextAlignment JUSTIFY = const TextAlignment("justify");
  static const TextAlignment LEFT = const TextAlignment("left");
  static const TextAlignment RIGHT = const TextAlignment("right");
}
