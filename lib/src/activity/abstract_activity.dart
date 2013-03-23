//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Activity library.
 * Classes used to implement app navigation.
 */
part of dart_web_toolkit_activity;

/**
 * Simple Activity implementation that is always willing to stop, and does
 * nothing onStop and onCancel.
 */
abstract class AbstractActivity implements Activity {

  String mayStop() {
    return null;
  }

  void onCancel() {
  }

  void onStop() {
  }
}

