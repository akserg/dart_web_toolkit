//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A {@link Widget} that uses an animation should implement this class so users
 * can enable or disable animations.
 */
abstract class HasAnimation {
  
  /**
   * Returns true if animations are enabled, false if not.
   */
  bool isAnimationEnabled();

  /**
   * Enable or disable animations.
   *
   * @param enable true to enable, false to disable
   */
  void setAnimationEnabled(bool enable);
}
