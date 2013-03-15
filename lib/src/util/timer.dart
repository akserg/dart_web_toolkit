//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * A simplified, browser-safe timer class. This class serves the same purpose as
 * java.util.Timer, but is simplified because of the single-threaded
 * environment.
 *
 * <p>
 * To schedule a timer, simply create a subclass of it (overriding {@link #run})
 * and call {@link #schedule} or {@link #scheduleRepeating}.
 * </p>
 *
 * <p>
 * NOTE: If you are using a timer to schedule a UI animation, use
 * {@link com.google.gwt.animation.client.AnimationScheduler} instead. The
 * browser can optimize your animation for maximum performance.
 * </p>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.TimerExample}
 * </p>
 */
class Timer {
  static List<Timer> _timers = new List<Timer>();
  static bool _initialised = false;

  static void clearInterval(dart_async.Timer timer) {
    timer.cancel();
  }

  static void clearTimeout(dart_async.Timer timer) {
    timer.cancel();
  }

  static dart_async.Timer createInterval(Timer timer, int period) {
    return new dart_async.Timer.repeating(new Duration(milliseconds:period), (dart_async.Timer t){
      timer.fire();
    });
  }

  static dart_async.Timer createTimeout(Timer timer, int delay) {
    return new dart_async.Timer(new Duration(milliseconds:delay), (){
      timer.fire();
    });
  }

  static void _hookWindowClosing() {
    // Catch the window closing event.
    dart_html.window.onUnload.listen((dart_html.Event event) {
        while (_timers.length > 0) {
          _timers[0].cancel();
        }
    });
  }

  bool isRepeating = false;

  dart_async.Timer _timer;

  Function _callback;

  factory Timer.get(Function _callback) {
    if (!_initialised) {
      _initialised = true;
      _hookWindowClosing();
    }
    return new Timer._internal(_callback);
  }

  Timer._internal(this._callback);

  /**
   * Cancels this timer.
   */
  void cancel() {
    if (_timer != null) {
      if (isRepeating) {
        clearInterval(_timer); //timerId);
      } else {
        clearTimeout(_timer); //timerId);
      }
      int indx = _timers.indexOf(this);
      if (indx != -1) {
        _timers.removeAt(indx);
      }
    }
  }

  /**
   * This method will be called when a timer fires. Override it to implement the
   * timer's logic.
   */
  void run() {
    _callback();
  }

  /**
   * Schedules a timer to elapse in the future.
   *
   * @param delayMillis how long to wait before the timer elapses, in
   *          milliseconds
   */
  void schedule(int delayMillis) {
    if (delayMillis < 0) {
      throw new Exception("must be non-negative");
    }
    cancel();
    isRepeating = false;
    _timer = createTimeout(this, delayMillis);
    _timers.add(this);
  }

  /**
   * Schedules a timer that elapses repeatedly.
   *
   * @param periodMillis how long to wait before the timer elapses, in
   *          milliseconds, between each repetition
   */
  void scheduleRepeating(int periodMillis) {
    if (periodMillis <= 0) {
      throw new Exception("must be positive");
    }
    cancel();
    isRepeating = true;
    _timer = createInterval(this, periodMillis);
    _timers.add(this);
  }

  /*
   * Called by code when this timer fires.
   */
  void fire() {
    // If this is a one-shot timer, remove it from the timer list. This will
    // allow it to be garbage collected.
    if (!isRepeating) {
      int indx = _timers.indexOf(this);
      if (indx != -1) {
        _timers.removeAt(indx);
      }
    }

    // Run the timer's code.
    run();
  }
}
