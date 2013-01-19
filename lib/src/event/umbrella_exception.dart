//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * DartMob UI library.
 */
part of dart_web_toolkit_event;

/**
 * A [Exception] that collects a [Set] of child
 * [Exception]s together. Typically thrown after a loop, with all of the
 * exceptions thrown during that loop, but delayed so that the loop finishes
 * executing.
 */
class UmbrellaException implements Exception {

  /**
   * A message describing the format error.
   */
  Set<Exception> _causes;

  UmbrellaException(this._causes) {
    throw (makeCause(_causes));
  }

  Set<Exception> get causes => _causes;

  String toString() => makeMessage(_causes);

  static String makeMessage(Set<Exception> causes) {
    if (causes.length == 0) {
      return null;
    }

    StringBuffer b = new StringBuffer();
    for (Exception t in causes) {
      if (b.length > 0) {
        b.add("; ");
      }
      b.add(t.toString());
    }

    return b.toString();
  }

  static Exception makeCause(Set<Exception> causes) {
    Iterator<Exception> iterator = causes.iterator();
    if (!iterator.hasNext) {
      return null;
    }

    return iterator.next();
  }


}
