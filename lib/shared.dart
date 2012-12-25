//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * DartMob Shared library.
 */
library dart_web_toolkit_shared;

import 'dart:html' as dart_html;

import 'event.dart';
import 'util.dart';
import 'editor.dart';

part 'src/shared/browser_events.dart';

part 'src/shared/has_visibility.dart';
part 'src/shared/has_word_wrap.dart';
part 'src/shared/has_html.dart';
part 'src/shared/has_text.dart';
part 'src/shared/has_name.dart';
part 'src/shared/has_focus.dart';
part 'src/shared/has_enabled.dart';
part 'src/shared/has_alignment.dart';
part 'src/shared/has_horizontal_alignment.dart';
part 'src/shared/has_vertical_alignment.dart';

part 'src/shared/has_resize_handlers.dart';
part 'src/shared/resize_handler.dart';
part 'src/shared/resize_event.dart';

part 'src/shared/click_handler.dart';
part 'src/shared/click_event.dart';
part 'src/shared/has_click_handlers.dart';

part 'src/shared/change_event.dart';
part 'src/shared/change_handler.dart';
part 'src/shared/has_change_handlers.dart';

part 'src/shared/value_change_event.dart';
part 'src/shared/has_value_change_handlers.dart';

part 'src/shared/takes_value.dart';
part 'src/shared/has_value.dart';

part 'src/shared/has_text_direction.dart';

part 'src/shared/has_direction.dart';

part 'src/shared/has_all_drag_and_drop_handlers.dart';

part 'src/shared/has_drag_end_handlers.dart';

part 'src/shared/has_drag_enter_handlers.dart';

part 'src/shared/has_drag_leave_handlers.dart';

part 'src/shared/has_drag_handlers.dart';

part 'src/shared/has_drag_over_handlers.dart';

part 'src/shared/has_drag_start_handlers.dart';

part 'src/shared/has_drop_handlers.dart';

part 'src/shared/has_double_click_handlers.dart';

part 'src/shared/has_all_focus_handlers.dart';

part 'src/shared/has_focus_handlers.dart';

part 'src/shared/has_blur_handlers.dart';

part 'src/shared/has_all_gesture_handlers.dart';

part 'src/shared/has_gesture_start_handlers.dart';

part 'src/shared/has_gesture_change_handlers.dart';

part 'src/shared/has_gesture_end_handlers.dart';

part 'src/shared/has_all_key_handlers.dart';

part 'src/shared/has_key_up_handlers.dart';

part 'src/shared/has_key_down_handlers.dart';

part 'src/shared/has_key_press_handlers.dart';

part 'src/shared/has_all_mouse_handlers.dart';

part 'src/shared/has_mouse_down_handlers.dart';

part 'src/shared/has_mouse_up_handlers.dart';

part 'src/shared/has_mouse_out_handlers.dart';

part 'src/shared/has_mouse_over_handlers.dart';

part 'src/shared/has_mouse_move_handlers.dart';

part 'src/shared/has_mouse_wheel_handlers.dart';

part 'src/shared/has_all_touch_handlers.dart';

part 'src/shared/has_touch_start_handlers.dart';

part 'src/shared/has_touch_move_handlers.dart';

part 'src/shared/has_touch_end_handlers.dart';

part 'src/shared/has_touch_cancel_handlers.dart';

part 'src/shared/has_direction_estimator.dart';

part 'src/shared/has_directional_safe_html.dart';

part 'src/shared/has_directional_text.dart';

part 'src/shared/has_safe_html.dart';

part 'src/shared/has_load_handlers.dart';

part 'src/shared/has_error_handlers.dart';

part 'src/shared/auto_direction_handler_target.dart';

part 'src/shared/has_editor_delegate.dart';
part 'src/shared/parser.dart';
part 'src/shared/renderer.dart';
part 'src/shared/appendable.dart';

part 'src/shared/auto_direction_handler.dart';

part 'src/shared/key_up_handler.dart';

part 'src/shared/abstract_renderer.dart';
part 'src/shared/testing/passthrough_parser.dart';
part 'src/shared/testing/passthrough_renderer.dart';