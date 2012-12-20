//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_animation;

/**
 * Specifies that a panel can animate between layouts.
 * 
 * <p>
 * The normal use pattern is to set all childrens' positions, then to call
 * {@link #animate(int)} to move them to their new positions over some period
 * of time.
 * </p>
 */
abstract class AnimatedLayout {

  /**
   * Layout children, animating over the specified period of time.
   * 
   * <p>
   * This method provides a callback that will be informed of animation updates.
   * This can be used to create more complex animation effects.
   * </p>
   * 
   * @param duration the animation duration, in milliseconds
   * @param callback the animation callback
   */
  void animate(int duration, [LayoutAnimationCallback callback = null]);

  /**
   * Layout children immediately.
   * 
   * <p>
   * This is not normally necessary, unless you want to update child widgets'
   * positions explicitly to create a starting point for a subsequent call to
   * {@link #animate(int)}.
   * </p>
   * 
   * @see #animate(int)
   * @see #animate(int, Layout.AnimationCallback)
   */
  void forceLayout();
}
