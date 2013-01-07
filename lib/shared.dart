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
import 'i18n.dart';

part 'src/shared/browser_events.dart';
part 'src/shared/dom.dart';
part 'src/shared/dom_helper.dart';
part 'src/shared/direction_estimator.dart';

part 'src/shared/impl/dom_helper_default.dart';

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
part 'src/shared/has_auto_horizontal_alignment.dart';
part 'src/shared/has_animation.dart';

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

part 'src/shared/has_before_selection_handlers.dart';

part 'src/shared/has_all_drag_and_drop_handlers.dart';
part 'src/shared/drag_drop_event_base.dart';

part 'src/shared/has_drag_end_handlers.dart';
part 'src/shared/drag_end_handler.dart';
part 'src/shared/drag_end_event.dart';

part 'src/shared/has_drag_enter_handlers.dart';
part 'src/shared/drag_enter_handler.dart';
part 'src/shared/drag_enter_event.dart';

part 'src/shared/has_drag_leave_handlers.dart';
part 'src/shared/drag_leave_handler.dart';
part 'src/shared/drag_leave_event.dart';

part 'src/shared/has_drag_handlers.dart';
part 'src/shared/drag_handler.dart';
part 'src/shared/drag_event.dart';

part 'src/shared/has_drag_over_handlers.dart';
part 'src/shared/drag_over_handler.dart';
part 'src/shared/drag_over_event.dart';

part 'src/shared/has_drag_start_handlers.dart';
part 'src/shared/drag_start_handler.dart';
part 'src/shared/drag_start_event.dart';

part 'src/shared/has_drop_handlers.dart';
part 'src/shared/drop_handler.dart';
part 'src/shared/drop_event.dart';

part 'src/shared/has_double_click_handlers.dart';
part 'src/shared/double_click_handler.dart';
part 'src/shared/double_click_event.dart';

part 'src/shared/has_all_focus_handlers.dart';

part 'src/shared/has_focus_handlers.dart';
part 'src/shared/focus_handler.dart';
part 'src/shared/focus_event.dart';

part 'src/shared/has_blur_handlers.dart';
part 'src/shared/blur_handler.dart';
part 'src/shared/blur_event.dart';

part 'src/shared/has_all_gesture_handlers.dart';

part 'src/shared/has_gesture_start_handlers.dart';
part 'src/shared/gesture_start_handler.dart';
part 'src/shared/gesture_start_event.dart';

part 'src/shared/has_gesture_change_handlers.dart';
part 'src/shared/gesture_change_handler.dart';
part 'src/shared/gesture_change_event.dart';

part 'src/shared/has_gesture_end_handlers.dart';
part 'src/shared/gesture_end_handler.dart';
part 'src/shared/gesture_end_event.dart';

part 'src/shared/has_all_key_handlers.dart';

part 'src/shared/has_key_up_handlers.dart';
part 'src/shared/key_up_handler.dart';
part 'src/shared/key_up_event.dart';

part 'src/shared/key_event.dart';
part 'src/shared/key_code_event.dart';

part 'src/shared/has_key_down_handlers.dart';
part 'src/shared/key_down_handler.dart';
part 'src/shared/key_down_event.dart';

part 'src/shared/has_key_press_handlers.dart';
part 'src/shared/key_press_handler.dart';
part 'src/shared/key_press_event.dart';

part 'src/shared/has_all_mouse_handlers.dart';

part 'src/shared/has_mouse_down_handlers.dart';
part 'src/shared/mouse_down_handler.dart';
part 'src/shared/mouse_down_event.dart';

part 'src/shared/has_mouse_up_handlers.dart';
part 'src/shared/mouse_up_handler.dart';
part 'src/shared/mouse_up_event.dart';

part 'src/shared/has_mouse_out_handlers.dart';

part 'src/shared/has_mouse_over_handlers.dart';

part 'src/shared/has_mouse_move_handlers.dart';
part 'src/shared/mouse_move_handler.dart';
part 'src/shared/mouse_move_event.dart';

part 'src/shared/has_mouse_wheel_handlers.dart';
part 'src/shared/mouse_wheel_handler.dart';
part 'src/shared/mouse_wheel_event.dart';

part 'src/shared/touch_event.dart';
part 'src/shared/has_all_touch_handlers.dart';

part 'src/shared/has_touch_start_handlers.dart';
part 'src/shared/touch_start_handler.dart';
part 'src/shared/touch_start_event.dart';

part 'src/shared/has_touch_move_handlers.dart';
part 'src/shared/touch_move_handler.dart';
part 'src/shared/touch_move_event.dart';

part 'src/shared/has_touch_end_handlers.dart';
part 'src/shared/touch_end_handler.dart';
part 'src/shared/touch_end_event.dart';

part 'src/shared/has_touch_cancel_handlers.dart';
part 'src/shared/touch_cancel_handler.dart';
part 'src/shared/touch_cancel_event.dart';

part 'src/shared/has_direction_estimator.dart';

part 'src/shared/has_directional_safe_html.dart';

part 'src/shared/has_directional_text.dart';

part 'src/shared/has_safe_html.dart';

part 'src/shared/has_load_handlers.dart';

part 'src/shared/has_error_handlers.dart';

part 'src/shared/auto_direction_handler_target.dart';

part 'src/shared/has_editor_delegate.dart';

part 'src/shared/before_selection_handler.dart';
part 'src/shared/before_selection_event.dart';

part 'src/shared/has_selection_handlers.dart';

part 'src/shared/selection_handler.dart';
part 'src/shared/selection_event.dart';

part 'src/shared/mouse_out_handler.dart';
part 'src/shared/mouse_out_event.dart';

part 'src/shared/mouse_over_handler.dart';
part 'src/shared/mouse_over_event.dart';

part 'src/shared/human_input_event.dart';
part 'src/shared/mouse_event.dart';

part 'src/shared/has_horizontal_scrolling.dart';
part 'src/shared/has_vertical_scrolling.dart';
part 'src/shared/has_scroll_handlers.dart';
part 'src/shared/scroll_handler.dart';
part 'src/shared/scroll_event.dart';