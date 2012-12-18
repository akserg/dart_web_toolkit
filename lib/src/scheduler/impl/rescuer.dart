//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_scheduler;

/**
 * Keeps {@link Flusher} running.
 */
class Rescuer implements RepeatingCommand {

  SchedulerImpl _schedulerImpl;

  Rescuer(this._schedulerImpl);

  bool execute() {
    if ( _schedulerImpl.flushRunning) {
      /*
       * Since JS is single-threaded, if we're here, then than means that
       * FLUSHER.execute() started, but did not finish. Reschedule FLUSHER.
       */
      _schedulerImpl.scheduleFixedDelay( _schedulerImpl.flusher, SchedulerImpl.FLUSHER_DELAY);
    }
    return  _schedulerImpl.shouldBeRunning;
  }
}
