//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_animation;

/**
 * Implementation using a timer for browsers that do not support animation
 * frames.
 */
class AnimationSchedulerImplTimer extends AnimationSchedulerImpl {

  /**
   * The default time in milliseconds between frames. 60 fps == 16.67 ms.
   */
  static int DEFAULT_FRAME_DELAY = 16;

  /**
   * The minimum delay in milliseconds between frames. The minimum delay is
   * imposed to prevent freezing the UI.
   */
  static int MIN_FRAME_DELAY = 5;

  /**
   * The list of animations that are currently running.
   */
  List<AnimationHandleImplTimer> animationRequests = new List<AnimationHandleImplTimer>();

  /**
   * The singleton timer that updates all animations.
   */
  Timer timer = new Timer.get(() {
    updateAnimations();
  });

  AnimationSchedulerImplTimer();

  AnimationHandle requestAnimationFrame(AnimationCallback callback, [dart_html.Element element = null]) {
    // Save the animation frame request.
    AnimationHandleImplTimer requestId = new AnimationHandleImplTimer(callback, this);
    animationRequests.add(requestId);

    // Start the timer if it isn't started.
    if (animationRequests.length == 1) {
      timer.schedule(DEFAULT_FRAME_DELAY);
    }

    // Return the request id.
    return requestId;
  }

  bool isNativelySupported() {
    return true;
  }

  void cancelAnimationFrame(AnimationHandle requestId) {
    // Remove the request from the list.
    int index = animationRequests.indexOf(requestId);
    if (index != -1) {
      animationRequests.removeAt(index);
    }

    // Stop the timer if there are no more requests.
    if (animationRequests.length == 0) {
      timer.cancel();
    }
  }

  /**
   * Iterate over all animations and update them.
   */
  void updateAnimations() {
    // Copy the animation requests to avoid concurrent modifications.
    List<AnimationHandleImplTimer> curAnimations = new List<AnimationHandleImplTimer>.from(animationRequests);

    // Iterate over the animation requests.
    Duration duration = new Duration();
    for (AnimationHandleImplTimer requestId in curAnimations) {
      // Remove the current request.
      int index = animationRequests.indexOf(requestId);
      if (index != -1) {
        animationRequests.removeAt(index);
      }

      // Execute the callback.
      requestId.getCallback().execute(duration.inMilliseconds); //getStartMillis());
    }

    // Reschedule the timer if there are more animation requests.
    if (animationRequests.length > 0) {
      /*
       * In order to achieve as close to 60fps as possible, we calculate the new
       * delay based on the execution time of this method. The delay will be
       * less than 16ms, assuming this method takes more than 1ms to complete.
       */
      timer.schedule(dart_math.max(MIN_FRAME_DELAY, DEFAULT_FRAME_DELAY - duration.inMilliseconds)); //elapsedMillis()));
    }
  }
}

/**
 * Timer based implementation of {@link AnimationScheduler.AnimationHandle}.
 */
class AnimationHandleImplTimer extends AnimationHandle {
  AnimationCallback callback;
  AnimationSchedulerImplTimer _impl;

  AnimationHandleImplTimer(this.callback, this._impl);

  void cancel() {
    _impl.cancelAnimationFrame(this);
  }

  AnimationCallback getCallback() {
    return callback;
  }
}