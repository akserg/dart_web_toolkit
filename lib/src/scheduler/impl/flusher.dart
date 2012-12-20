//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_scheduler;

/**
 * Calls {@link SchedulerImpl#flushPostEventPumpCommands()}.
 */
class Flusher implements RepeatingCommand {

  SchedulerImpl _schedulerImpl;

  Flusher(this._schedulerImpl);

  bool execute() {

    _schedulerImpl._flushRunning = true;
    _schedulerImpl.flushPostEventPumpCommands();
    /*
     * No finally here, we want this to be clear only on a normal exit. An
     * abnormal exit would indicate that an exception isn't being caught
     * correctly or that a slow script warning canceled the timer.
     */
    _schedulerImpl._flushRunning = false;
    return _schedulerImpl._shouldBeRunning = _schedulerImpl.isWorkQueued();
  }
}
