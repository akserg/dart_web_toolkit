//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * DartMob UI library.
 */
library dart_web_toolkit_ui;

import 'dart:html' as dart_html;

import 'event.dart';
import 'i18n.dart';
import 'shared.dart';

part 'src/ui/ui_object.dart';

part 'src/ui/has_visibility.dart';
part 'src/ui/is_widget.dart';
part 'src/ui/widget.dart';
part 'src/ui/focus_widget.dart';
part 'src/ui/dom.dart';
part 'src/ui/dom_helper.dart';
part 'src/ui/focus_helper.dart';
part 'src/ui/anchor.dart';
part 'src/ui/style.dart';
part 'src/ui/root_panel.dart';
part 'src/ui/absolute_panel.dart';
part 'src/ui/complex_panel.dart';
part 'src/ui/insert_panel.dart';
part 'src/ui/indexed_panel.dart';
part 'src/ui/panel.dart';
part 'src/ui/attach_detach_exception.dart';

part 'src/ui/has_enabled.dart';
part 'src/ui/has_focus.dart';
part 'src/ui/has_widgets.dart';
part 'src/ui/has_name.dart';
part 'src/ui/has_html.dart';
part 'src/ui/has_text.dart';
part 'src/ui/has_word_wrap.dart';

part 'src/ui/impl/focus_helper_default.dart';
part 'src/ui/impl/dom_helper_default.dart';

/**
 * Supports core functionality that in some cases requires direct support from
 * the compiler and runtime systems such as runtime type information and
 * deferred binding.
 */
class UI {
 
  /**
   * Returns <code>true</code> when running in production mode. Returns
   * <code>false</code> when running either in development mode, or when running
   * in a plain JVM.
   */
  static bool isProdMode() {
    // Replaced with "true" by GWT compiler.
    return false;
  }
}

