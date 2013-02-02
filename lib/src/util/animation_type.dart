//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * The type of animation to use when opening the popup.
*
 * <ul>
 * <li>CENTER - Expand from the center of the popup</li>
 * <li>ONE_WAY_CORNER - Expand from the top left corner, do not animate hiding
 * </li>
 * </ul>
 */
class AnimationType<int> extends Enum<int> {

  const AnimationType(int num) : super(num);

  static const AnimationType CENTER = const AnimationType(0);
  static const AnimationType ONE_WAY_CORNER = const AnimationType(1);
  static const AnimationType ROLL_DOWN = const AnimationType(2);
}
