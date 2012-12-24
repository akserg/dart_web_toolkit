//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * DartMob UI library.
 */
library dart_web_toolkit_ui;

import 'dart:html' as dart_html;
import 'dart:math' as dart_math;

import 'event.dart';
import 'i18n.dart';
import 'shared.dart';
import 'animation.dart';
import 'layout.dart';
import 'util.dart';
import 'scheduler.dart';
import 'role.dart';

part 'src/ui/ui_object.dart';

part 'src/ui/has_visibility.dart';
part 'src/ui/is_widget.dart';
part 'src/ui/widget.dart';
part 'src/ui/focus_widget.dart';
part 'src/ui/dom.dart';
part 'src/ui/dom_helper.dart';
part 'src/ui/focus_helper.dart';
part 'src/ui/anchor.dart';
part 'src/ui/root_panel.dart';
part 'src/ui/absolute_panel.dart';
part 'src/ui/complex_panel.dart';
part 'src/ui/insert_panel.dart';
part 'src/ui/indexed_panel.dart';
part 'src/ui/panel.dart';
part 'src/ui/attach_detach_exception.dart';
part 'src/ui/button_base.dart';
part 'src/ui/button.dart';
part 'src/ui/reset_button.dart';
part 'src/ui/submit_button.dart';
part 'src/ui/composite.dart';
part 'src/ui/is_renderable.dart';
part 'src/ui/header_panel.dart';
part 'src/ui/requires_resize.dart';
part 'src/ui/simple_panel.dart';
part 'src/ui/accepts_one_widget.dart';
part 'src/ui/resize_layout_panel.dart';
part 'src/ui/provides_resize.dart';
part 'src/ui/has_resize_handlers.dart';
part 'src/ui/resize_handler.dart';
part 'src/ui/resize_event.dart';
part 'src/ui/panel_iterator.dart';
part 'src/ui/impl/resize_layout_panel_impl.dart';
part 'src/ui/finite_widget_iterator.dart';
part 'src/ui/check_box.dart';
part 'src/ui/radio_button.dart';
part 'src/ui/cell_panel.dart';
part 'src/ui/vertical_panel.dart';
part 'src/ui/horizontal_panel.dart';
part 'src/ui/dock_layout_panel.dart';
part 'src/ui/layout_command.dart';
part 'src/ui/layout_panel.dart';
part 'src/ui/root_layout_panel.dart';
part 'src/ui/split_layout_panel.dart';
part 'src/ui/splitter.dart';
part 'src/ui/file_upload.dart';
part 'src/ui/hyperlink.dart';
part 'src/ui/history.dart';
part 'src/ui/custom_button.dart';
part 'src/ui/image.dart';
part 'src/ui/focus_panel.dart';
part 'src/ui/push_button.dart';
part 'src/ui/toggle_button.dart';
part 'src/ui/list_box.dart';

part 'src/ui/widget_collection.dart';

part 'src/ui/has_enabled.dart';
part 'src/ui/has_focus.dart';
part 'src/ui/has_widgets.dart';
part 'src/ui/has_name.dart';
part 'src/ui/has_html.dart';
part 'src/ui/has_text.dart';
part 'src/ui/has_word_wrap.dart';
part 'src/ui/has_one_widget.dart';
part 'src/ui/has_horizontal_alignment.dart';
part 'src/ui/has_vertical_alignment.dart';
part 'src/ui/has_alignment.dart';

part 'src/ui/impl/focus_helper_default.dart';
part 'src/ui/impl/dom_helper_default.dart';
part 'src/ui/impl/hyperlink_impl.dart';
part 'src/ui/impl/history_impl.dart';

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

