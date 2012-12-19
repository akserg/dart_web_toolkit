//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_scheduler;

/**
 * This is used by Scheduler to collaborate with Impl in order to have
 * FinallyCommands executed.
 */
class SchedulerImpl extends Scheduler {

  /**
   * The delay between flushing the task queues.
   */
  static const int FLUSHER_DELAY = 1;

  /**
   * The delay between checking up on SSW problems.
   */
  static const int RESCUE_DELAY = 50;

  /**
   * The amount of time that we're willing to spend executing
   * IncrementalCommands.
   */
  static int TIME_SLICE = 100;

  /**
   * Provides lazy-init pattern for the task queues.
   */
  static List<Task> push(List<Task> queue, Task task) {
    if (queue == null) {
      queue = createQueue();
    }
    queue.add(task);
    return queue;
  }

  /**
   * Extract boilerplate code.
   */
  static List<Task> createQueue() {
    return new List<Task>();
  }

  static void scheduleFixedDelayImpl(RepeatingCommand cmd, int delayMs) {
    Caleer caleer = new Caleer();
    caleer.timeoutHandler = () {
      if (cmd.execute()) {
        (dart_html.document.window as dart_html.LocalWindow).setTimeout(caleer.timeoutHandler, delayMs);
      }
    };
    caleer.handle = (dart_html.document.window as dart_html.LocalWindow).setTimeout(caleer.timeoutHandler, delayMs);
  }

  static void scheduleFixedPeriodImpl(RepeatingCommand cmd, int delayMs) {
    Caleer caleer = new Caleer();
    caleer.timeoutHandler = () {
      if (!cmd.execute()) {
        // Either canceled or threw an exception
        (dart_html.document.window as dart_html.LocalWindow).clearInterval(caleer.handle);
      }
    };
    caleer.handle = (dart_html.document.window as dart_html.LocalWindow).setInterval(caleer.timeoutHandler, delayMs);
  }

  //***************

  static SchedulerImpl _instance;

  /**
   * Use a GWT.create() here to make it simple to hijack the default
   * implementation.
   */
  factory SchedulerImpl.Instance() {
    if (_instance == null) {
      _instance = new SchedulerImpl();
    }
    return _instance;
  }

  /**
   * A RepeatingCommand that calls flushPostEventPumpCommands(). It repeats if
   * there are any outstanding deferred or incremental commands.
   */
  Flusher flusher;

  /**
   * This provides some backup for the main flusher task in case it gets shut
   * down by a slow-script warning.
   */
  Rescuer rescue;

  /*
   * Work queues. Timers store their state on the function, so we don't need to
   * track them. They are not final so that we don't have to shorten them.
   * Processing the values in the queues is a one-shot, and then the array is
   * discarded.
   */
  List<Task> deferredCommands;
  List<Task> entryCommands;
  List<Task> finallyCommands;
  List<Task> incrementalCommands;

  /*
   * These two flags are used to control the state of the flusher and rescuer
   * commands.
   */
  bool flushRunning = false;
  bool shouldBeRunning = false;

  SchedulerImpl();

  void maybeSchedulePostEventPumpCommands() {
    if (!shouldBeRunning) {
      shouldBeRunning = true;

      if (flusher == null) {
        flusher = new Flusher(this);
      }
      scheduleFixedDelayImpl(flusher, FLUSHER_DELAY);

      if (rescue == null) {
        rescue = new Rescuer(this);
      }
      scheduleFixedDelayImpl(rescue, RESCUE_DELAY);
    }
  }

  //****************************
  // Implementation of Scheduler
  //****************************

  /**
   * A deferred command is executed after the browser event loop returns.
   */
  void scheduleDeferred(ScheduledCommand cmd) {
    deferredCommands = push(deferredCommands, new Task.fromScheduledCommand(cmd));
    maybeSchedulePostEventPumpCommands();
  }

  /**
   * An "entry" command will be executed before GWT-generated code is invoked by
   * the browser's event loop. The {@link RepeatingCommand} will be called once
   * per entry from the event loop until <code>false</code> is returned. This
   * type of command is appropriate for instrumentation or code that needs to
   * know when "something happens."
   * <p>
   * If an entry command schedules another entry command, the second command
   * will be executed before control flow continues to the GWT-generated code.
   */
  void scheduleRepeatingEntry(RepeatingCommand cmd) {
    entryCommands = push(entryCommands, new Task.fromRepeatingCommand(cmd));
  }

  /**
   * An "entry" command will be executed before GWT-generated code is invoked by
   * the browser's event loop. This type of command is appropriate for code that
   * needs to know when "something happens."
   * <p>
   * If an entry command schedules another entry command, the second command
   * will be executed before control flow continues to the GWT-generated code.
   */
  void scheduleEntry(ScheduledCommand cmd) {
    entryCommands = push(entryCommands, new Task.fromScheduledCommand(cmd));
  }

  /**
   * A "finally" command will be executed before GWT-generated code returns
   * control to the browser's event loop. The {@link RepeatingCommand#execute()}
   * method will be called once per exit to the event loop until
   * <code>false</code> is returned. This type of command is appropriate for
   * instrumentation or cleanup code.
   * <p>
   * If a finally command schedules another finally command, the second command
   * will be executed before control flow returns to the browser.
   */
  void scheduleRepeatingFinally(RepeatingCommand cmd) {
    finallyCommands = push(finallyCommands, new Task.fromRepeatingCommand(cmd));
  }

  /**
   * A "finally" command will be executed before GWT-generated code returns
   * control to the browser's event loop. This type of command is used to
   * aggregate small amounts of work before performing a non-recurring,
   * heavyweight operation.
   * <p>
   * If a finally command schedules another finally command, the second command
   * will be executed before control flow returns to the browser.
   * <p>
   * Consider the following:
   *
   * <pre>
   * try {
   *   nativeEventCallback(); // Calls scheduleFinally one or more times
   * } finally {
   *   executeFinallyCommands();
   * }
   * </pre>
   *
   * @see com.google.gwt.dom.client.StyleInjector
   */
  void scheduleFinally(ScheduledCommand cmd) {
    finallyCommands = push(finallyCommands, new Task.fromScheduledCommand(cmd));
  }

  /**
   * Schedules a repeating command that is scheduled with a constant delay. That
   * is, the next invocation of the command will be scheduled for
   * <code>delayMs</code> milliseconds after the last invocation completes.
   * <p>
   * For example, assume that a command takes 30ms to run and a 100ms delay is
   * provided. The second invocation of the command will occur at 130ms after
   * the first invocation starts.
   *
   * @param cmd the command to execute
   * @param delayMs the amount of time to wait after one invocation ends before
   *          the next invocation
   */
  void scheduleFixedDelay(RepeatingCommand cmd, int delayMs) {
    scheduleFixedDelayImpl(cmd, delayMs);
  }

  /**
   * Schedules a repeating command that is scheduled with a constant
   * periodicity. That is, the command will be invoked every
   * <code>delayMs</code> milliseconds, regardless of how long the previous
   * invocation took to complete.
   *
   * @param cmd the command to execute
   * @param delayMs the period with which the command is executed
   */
  void scheduleFixedPeriod(RepeatingCommand cmd, int delayMs) {
    scheduleFixedPeriodImpl(cmd, delayMs);
  }

  /**
   * Schedules a repeating command that performs incremental work. This type of
   * command is encouraged for long-running processes that perform computation
   * or that manipulate the DOM. The commands in this queue are invoked many
   * times in rapid succession and are then deferred to allow the browser to
   * process its event queue.
   *
   * @param cmd the command to execute
   */
  void scheduleIncremental(RepeatingCommand cmd) {
    // Push repeating commands onto the same initial queue for relative order
    deferredCommands = push(deferredCommands, new Task.fromRepeatingCommand(cmd));
    maybeSchedulePostEventPumpCommands();
  }


  /**
   * Execute a list of Tasks that hold RepeatingCommands.
   *
   * @return A replacement array that is possibly a shorter copy of
   *         <code>tasks</code>
   */
  static List<Task> runRepeatingTasks(List<Task> tasks) {
    assert (tasks != null); // : "tasks";

    int length = tasks.length;
    if (length == 0) {
      return null;
    }

    bool canceledSomeTasks = false;
    int start = (new Date.now()).millisecond; // Duration.currentTimeMillis();

    while ((new Date.now()).millisecond - start < TIME_SLICE) {
      for (int i = 0; i < length; i++) {
        assert (tasks.length == length); // : "Working array length changed "  + tasks.length() + " != " + length;
        Task t = tasks[i];
        if (t == null) {
          continue;
        }

        assert (t.isRepeating()); // : "Found a non-repeating Task";

        if (!t.executeRepeating()) {
          tasks[i] = null;
          canceledSomeTasks = true;
        }
      }
    }

    if (canceledSomeTasks) {
      List<Task> newTasks = createQueue();
      // Remove tombstones
      for (int i = 0; i < length; i++) {
        if (tasks[i] != null) {
          newTasks.add(tasks[i]);
        }
      }
      assert (newTasks.length < length);
      return newTasks.length == 0 ? null : newTasks;
    } else {
      return tasks;
    }
  }

  /**
   * Execute a list of Tasks that hold both ScheduledCommands and
   * RepeatingCommands. Any RepeatingCommands in the <code>tasks</code> queue
   * that want to repeat will be pushed onto the <code>rescheduled</code> queue.
   * The contents of <code>tasks</code> may not be altered while this method is
   * executing.
   *
   * @return <code>rescheduled</code> or a newly-allocated array if
   *         <code>rescheduled</code> is null.
   */
  static List<Task> runScheduledTasks(List<Task> tasks, List<Task> rescheduled) {
    assert (tasks != null); // : "tasks";

    for (int i = 0, j = tasks.length; i < j; i++) {
      assert (tasks.length == j); // : "Working array length changed ${tasks.length()} != $j";
      Task t = tasks[i];

      try {
        // Move repeating commands to incremental commands queue
        if (t.isRepeating()) {
          if (t.executeRepeating()) {
            rescheduled = push(rescheduled, t);
          }
        } else {
          t.executeScheduled();
        }
      } on Exception catch (e) {
//        if (GWT.getUncaughtExceptionHandler() != null) {
//          GWT.getUncaughtExceptionHandler().onUncaughtException(e);
//        }
        print(e);
      }
    }
    return rescheduled;
  }

  bool isWorkQueued() {
    return deferredCommands != null || incrementalCommands != null;
  }
  //******************
  // Called by Flusher
  //******************

  void flushPostEventPumpCommands() {
    if (deferredCommands != null) {
      List<Task> oldDeferred = deferredCommands;
      deferredCommands = null;

      /* We might not have any incremental commands queued. */
      if (incrementalCommands == null) {
        incrementalCommands = createQueue();
      }
      runScheduledTasks(oldDeferred, incrementalCommands);
    }

    if (incrementalCommands != null) {
      incrementalCommands = runRepeatingTasks(incrementalCommands);
    }
  }
}

class Caleer {
  dart_html.TimeoutHandler timeoutHandler;
  int handle = -1;
}