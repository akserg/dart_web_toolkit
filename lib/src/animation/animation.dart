//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_animation;

/**
 * An {@link Animation} is a continuous event that updates progressively over
 * time at a non-fixed frame rate.
 */
abstract class Animation {

  AnimationCallback callback;


  /**
   * The duration of the {@link Animation} in milliseconds.
   */
  int duration = -1;

  /**
   * The element being animated.
   */
  dart_html.Element element;

  /**
   * Is the animation running, even if it hasn't started yet.
   */
  bool running = false;

  /**
   * Has the {@link Animation} actually started.
   */
  bool isStarted = false;

  /**
   * The ID of the pending animation request.
   */
  AnimationHandle requestHandle;

  /**
   * The unique ID of the current run. Used to handle cases where an animation
   * is restarted within an execution block.
   */
  int runId = -1;

  AnimationScheduler scheduler;

  /**
   * The start time of the {@link Animation}.
   */
  int startTime = -1;

  /**
   * Did the animation start before {@link #cancel()} was called.
   */
  bool wasStarted = false;

  /**
   * Construct a new {@link AnimationScheduler} using the specified scheduler to
   * sheduler request frames.
   *
   * @param scheduler an {@link AnimationScheduler} instance
   */
  Animation([AnimationScheduler scheduler = null]) {
    if (scheduler == null) {
      this.scheduler = new AnimationScheduler.Instance();
    } else {
      this.scheduler = scheduler;
    }
    this.callback = new AnimationCallback2(this);
  }

  /**
   * Immediately cancel this animation. If the animation is running or is
   * scheduled to run, {@link #onCancel()} will be called.
   */
  void cancel() {
    // Ignore if the animation is not currently running.
    if (!running) {
      return;
    }

    // Reset the state.
    wasStarted = isStarted; // Used by onCancel.
    element = null;
    running = false;
    isStarted = false;

    // Cancel the animation request.
    if (requestHandle != null) {
      requestHandle.cancel();
      requestHandle = null;
    }

    onCancel();
  }

//  /**
//   * Immediately run this animation. If the animation is already running, it
//   * will be canceled first.
//   * <p>
//   * This is equivalent to <code>run(duration, null)</code>.
//   *
//   * @param duration the duration of the animation in milliseconds
//   * @see #run(int, Element)
//   */
//  void run(int duration) {
//    run(duration, null);
//  }
//
//  /**
//   * Immediately run this animation. If the animation is already running, it
//   * will be canceled first.
//   * <p>
//   * If the element is not <code>null</code>, the {@link #onUpdate(double)}
//   * method might be called only if the element may be visible (generally left
//   * at the appreciation of the browser). Otherwise, it will be called
//   * unconditionally.
//   *
//   * @param duration the duration of the animation in milliseconds
//   * @param element the element that visually bounds the entire animation
//   */
//  void run(int duration, Element element) {
//    run(duration, Duration.currentTimeMillis(), element);
//  }
//
//  /**
//   * Run this animation at the given startTime. If the startTime has already
//   * passed, the animation will run synchronously as if it started at the
//   * specified start time. If the animation is already running, it will be
//   * canceled first.
//   * <p>
//   * This is equivalent to <code>run(duration, startTime, null)</code>.
//   *
//   * @param duration the duration of the animation in milliseconds
//   * @param startTime the synchronized start time in milliseconds
//   * @see #run(int, double, Element)
//   */
//  void run(int duration, double startTime) {
//    run(duration, startTime, null);
//  }

  /**
   * Run this animation at the given startTime. If the startTime has already
   * passed, the animation will run synchronously as if it started at the
   * specified start time. If the animation is already running, it will be
   * canceled first.
   * <p>
   * If the element is not <code>null</code>, the {@link #onUpdate(double)}
   * method might be called only if the element may be visible (generally left
   * at the appreciation of the browser). Otherwise, it will be called
   * unconditionally.
   *
   * @param duration the duration of the animation in milliseconds
   * @param startTime the synchronized start time in milliseconds
   * @param element the element that visually bounds the entire animation
   */
  void run(int duration, {int startTime:null, dart_html.Element element:null}) {
    // Cancel the animation if it is running
    cancel();

    if (startTime == null) {
      startTime = (new Date.now()).millisecond;
    }

    // Save the duration and startTime
    running = true;
    isStarted = false;
    this.duration = duration;
    this.startTime = startTime;
    this.element = element;
    ++runId;

    // Execute the first callback.
    callback.execute((new Date.now()).millisecond); //Duration.currentTimeMillis());
  }

  /**
   * Interpolate the linear progress into a more natural easing function.
   *
   * Depending on the {@link Animation}, the return value of this method can be
   * less than 0.0 or greater than 1.0.
   *
   * @param progress the linear progress, between 0.0 and 1.0
   * @return the interpolated progress
   */
  double interpolate(double progress) {
    return (1 + dart_math.cos(dart_math.PI + progress * dart_math.PI)) / 2;
  }

  /**
   * Called immediately after the animation is canceled. The default
   * implementation of this method calls {@link #onComplete()} only if the
   * animation has actually started running.
   */
  void onCancel() {
    if (wasStarted) {
      onComplete();
    }
  }

  /**
   * Called immediately after the animation completes.
   */
  void onComplete() {
    onUpdate(interpolate(1.0));
  }

  /**
   * Called immediately before the animation starts.
   */
  void onStart() {
    onUpdate(interpolate(0.0));
  }

  /**
   * Called when the animation should be updated.
   *
   * The value of progress is between 0.0 and 1.0 (inclusive) (unless you
   * override the {@link #interpolate(double)} method to provide a wider range
   * of values). You can override {@link #onStart()} and {@link #onComplete()}
   * to perform setup and tear down procedures.
   *
   * @param progress a double, normally between 0.0 and 1.0 (inclusive)
   */
  void onUpdate(double progress);

  /**
   * Check if the specified run ID is still being run.
   *
   * @param curRunId the current run ID to check
   * @return true if running, false if canceled or restarted
   */
  bool isRunning(int curRunId) {
    return running && (runId == curRunId);
  }

  /**
   * Update the {@link Animation}.
   *
   * @param curTime the current time
   * @return true if the animation should run again, false if it is complete
   */
  bool update(int curTime) {
    print("Animation.update(${curTime} >= ${startTime + duration})");
    /*
     * Save the run id. If the runId is incremented during this execution block,
     * we know that this run has been canceled.
     */
    int curRunId = runId;

    bool finished = curTime >= startTime + duration;
    if (isStarted && !finished) {
      print("Animation is in progress.");
      // Animation is in progress.
      double progress = (curTime - startTime) / duration;
      onUpdate(interpolate(progress));
      return isRunning(curRunId); // Check if this run was canceled.
    }
    if (!isStarted && curTime >= startTime) {
      print("Start the animation.");
      /*
       * Start the animation. We do not call onUpdate() because onStart() calls
       * onUpdate() by default.
       */
      isStarted = true;
      onStart();
      if (!isRunning(curRunId)) {
        // This run was canceled.
        return false;
      }
      // Intentional fall through to possibly end the animation.
    }
    if (finished) {
      print("Animation is complete.");
      // Animation is complete.
      running = false;
      isStarted = false;
      onComplete();
      return false;
    }
    return true;
  }

}

class AnimationCallback2 implements AnimationCallback {

  Animation _animation;

  AnimationCallback2(this._animation);

  void execute(int timestamp) {
    print("AnimationCallback2.execute(${timestamp})");
    if (_animation.update(timestamp)) {
      print("Schedule the next animation frame.");
      // Schedule the next animation frame.
      _animation.requestHandle = _animation.scheduler.requestAnimationFrame(_animation.callback, _animation.element);
    } else {
      print("Stop animation frame.");
      _animation.requestHandle = null;
    }
  }
}