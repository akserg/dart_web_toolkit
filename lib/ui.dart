//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit UI library.
 */
library dart_web_toolkit_ui;

import 'dart:html' as dart_html;
import 'dart:math' as dart_math;

import 'event.dart';
import 'i18n.dart';
import 'animation.dart';
import 'layout.dart';
import 'util.dart';
import 'scheduler.dart';
import 'role.dart';
import 'editor.dart';
import 'text.dart';
import 'data.dart';
import 'resource.dart';
import 'core.dart';

part 'src/ui/ui_object.dart';

part 'src/ui/is_widget.dart';
part 'src/ui/widget.dart';
part 'src/ui/focus_widget.dart';
part 'src/ui/impl/focus_impl.dart';
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
part 'src/ui/impl/resize_layout_panel_impl.dart';
part 'src/ui/impl/resize_layout_panel_impl_standard.dart';
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
part 'src/ui/value_box_base.dart';
part 'src/ui/text_box_base.dart';
part 'src/ui/text_box.dart';
part 'src/ui/password_text_box.dart';
part 'src/ui/text_area.dart';
part 'src/ui/stack_panel.dart';
part 'src/ui/decorated_stack_panel.dart';
part 'src/ui/decorator_panel.dart';
part 'src/ui/resize_composite.dart';
part 'src/ui/stack_layout_panel.dart';
part 'src/ui/label_base.dart';
part 'src/ui/label.dart';
part 'src/ui/Html.dart';
part 'src/ui/value_label.dart';
part 'src/ui/date_label.dart';
part 'src/ui/number_label.dart';
part 'src/ui/value_box.dart';
part 'src/ui/double_box.dart';
part 'src/ui/integer_box.dart';
part 'src/ui/simple_check_box.dart';
part 'src/ui/simple_radio_button.dart';
part 'src/ui/deck_layout_panel.dart';
part 'src/ui/flow_panel.dart';
part 'src/ui/html_panel.dart';
part 'src/ui/lazy_panel.dart';
part 'src/ui/caption_panel.dart';
part 'src/ui/tab_layout_panel.dart';
part 'src/ui/deck_panel.dart';
part 'src/ui/html_table.dart';
part 'src/ui/flex_table.dart';
part 'src/ui/grid.dart';
part 'src/ui/simple_layout_panel.dart';
part 'src/ui/scroll_panel.dart';
part 'src/ui/has_scrolling.dart';
part 'src/ui/popup_panel.dart';
part 'src/ui/tab_panel.dart';
part 'src/ui/tab_bar.dart';
part 'src/ui/decorated_popup_panel.dart';
part 'src/ui/dialog_box.dart';
part 'src/ui/frame.dart';
part 'src/ui/hidden.dart';
part 'src/ui/dock_panel.dart';
part 'src/ui/value_list_box.dart';
part 'src/ui/tree.dart';
part 'src/ui/abstract_image_prototype.dart';
part 'src/ui/menu_item_separator.dart';
part 'src/ui/menu_item.dart';
part 'src/ui/menu_bar.dart';
part 'src/ui/notification_mole.dart';
part 'src/ui/disclosure_panel.dart';

part 'src/ui/has_tree_items.dart';
part 'src/ui/tree_item.dart';
part 'src/ui/is_tree_item.dart';

part 'src/ui/text_alignment.dart';

part 'src/ui/inline_label.dart';
part 'src/ui/inline_html.dart';
part 'src/ui/inline_hyperlink.dart';

part 'src/ui/adapter/value_box_editor.dart';
part 'src/ui/adapter/takes_value_editor.dart';
part 'src/ui/adapter/has_text_editor.dart';

part 'src/ui/widget_collection.dart';
part 'src/ui/widget_iterators.dart';

part 'src/ui/has_widgets.dart';
part 'src/ui/has_one_widget.dart';

part 'src/ui/impl/focus_impl_default.dart';
part 'src/ui/impl/hyperlink_impl.dart';
part 'src/ui/impl/history_impl.dart';
part 'src/ui/impl/text_box_impl.dart';
part 'src/ui/impl/clipped_image_impl.dart';
part 'src/ui/impl/element_mapper_impl.dart';
part 'src/ui/impl/scroll_impl.dart';
part 'src/ui/impl/popup_impl.dart';
part 'src/ui/impl/clipped_image_prototype.dart';

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
    // Replaced with "true" by DWT compiler.
    return false;
  }
}

