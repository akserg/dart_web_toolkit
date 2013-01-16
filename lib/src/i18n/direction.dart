//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Possible return values for {@link HasDirection#getDirection()} and parameter values for
 * {@link HasDirection#setDirection(Direction)}.Widgets that implement this interface can
 * either have a direction that is right-to-left (RTL), left-to-right (LTR), or default
 * (which means that their directionality is inherited from their parent widget).
 */
class Direction<String> extends Enum<String> {

  const Direction(String type) : super(type);

  static const Direction RTL = const Direction("RTL");
  static const Direction LTR = const Direction("LTR");
  static const Direction DEFAULT = const Direction("DEFAULT");
}