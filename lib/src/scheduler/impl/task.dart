//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_scheduler;

/**
 * Metadata bag for command objects. It's a JSO so that a lightweight JsArray
 * can be used instead of a Collections type.
 */
class Task {

  Object _command;
  bool _repeating = false;

  factory Task.fromRepeatingCommand(RepeatingCommand cmd) {
    return new Task._internal(cmd, true);
  }

  factory Task.fromScheduledCommand(ScheduledCommand cmd) {
    return new Task._internal(cmd, false);
  }

  Task._internal(this._command, this._repeating);

  bool executeRepeating() {
    return getRepeating().execute();
  }

  void executeScheduled() {
    getScheduled().execute();
  }

  /**
   * Has implicit cast.
   */
  RepeatingCommand getRepeating() {
    return _command as RepeatingCommand;
  }

  /**
   * Has implicit cast.
   */
  ScheduledCommand getScheduled() {
    return _command as ScheduledCommand;
  }

  bool isRepeating() {
    return _repeating;
  }
}
