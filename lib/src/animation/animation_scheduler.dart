//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_animation;

/**
 * This class provides task scheduling for animations. Any exceptions thrown by
 * the command objects executed by the scheduler will be passed to the
 * {@link com.google.gwt.core.client.GWT.UncaughtExceptionHandler} if one is
 * installed.
 */
abstract class AnimationScheduler {

  /**
   * Returns the default implementation of the AnimationScheduler API.
   */
  factory AnimationScheduler.Instance() {
    return new AnimationSchedulerImpl.Instance();
  }

  AnimationScheduler();

  /**
   * Schedule an animation, letting the browser decide when to trigger the next
   * step in the animation.
   *
   * <p>
   * Using this method instead of a timeout is preferred because the browser is
   * in the best position to decide how frequently to trigger the callback for
   * an animation of the specified element. The browser can balance multiple
   * animations and trigger callbacks at the optimal rate for smooth
   * performance.
   * </p>
   *
   * @param callback the callback to fire
   * @return a handle to the requested animation frame
   * @param element the element being animated
   */
  AnimationHandle requestAnimationFrame(AnimationCallback callback, [dart_html.Element element = null]);
}

/**
 * The callback used when an animation frame becomes available.
 */
abstract class AnimationCallback {
  /**
   * Invokes the command.
   *
   * @param timestamp the current timestamp
   */
  void execute(int timestamp);
}

/**
 * A handle to the requested animation frame created by
 * {@link #requestAnimationFrame(AnimationCallback, Element)}.
 */
abstract class AnimationHandle {
  /**
   * Cancel the requested animation frame. If the animation frame is already
   * canceled, do nothing.
   */
  void cancel();
}