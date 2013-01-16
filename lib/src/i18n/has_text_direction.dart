//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * A widget that implements this interface has the ability to override
 * the document directionality for its root element.
 *
 * Widgets that implement this interface should be leaf widgets. More
 * specifically, they should not implement the
 * {@link com.google.gwt.user.client.ui.HasWidgets} interface.
 */
class HasTextDirection {

}

/**
 * Possible return values for {@link HasDirection#getDirection()} and parameter values for
 * {@link HasDirection#setDirection(Direction)}.Widgets that implement this interface can
 * either have a direction that is right-to-left (RTL), left-to-right (LTR), or default
 * (which means that their directionality is inherited from their parent widget).
 */
class TextDirection<int> extends Enum<int> {

  const TextDirection(int type) : super(type);

  static const TextDirection RTL = const TextDirection(0);
  static const TextDirection LTR = const TextDirection(1);
  static const TextDirection DEFAULT = const TextDirection(2);

}