//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * DartMob Event library.
 */
library dart_web_toolkit_event;

import 'dart:html' as dart_html;

part 'src/event/event.dart';
part 'src/event/handler_registration.dart';
part 'src/event/command.dart';
part 'src/event/event_bus.dart';
part 'src/event/simple_event_bus.dart';
part 'src/event/umbrella_exception.dart';
part 'src/event/has_direction.dart';

part 'src/event/browser_events.dart';
part 'src/event/dom.dart';
part 'src/event/dom_helper.dart';

part 'src/event/impl/dom_helper_default.dart';

part 'src/event/event_listener.dart';
part 'src/event/dwt_event.dart';
part 'src/event/dom_event.dart';
part 'src/event/attach_event.dart';
part 'src/event/event_handler.dart';
part 'src/event/close_event.dart';
part 'src/event/close_handler.dart';
part 'src/event/value_change_event.dart';
part 'src/event/value_change_handler.dart';

part 'src/event/has_handlers.dart';
part 'src/event/has_attach_handlers.dart';
part 'src/event/has_value_change_handlers.dart';

part 'src/event/event_handler_adapter.dart';
part 'src/event/adapter/value_change_handler_adapter.dart';

part 'src/event/has_visibility.dart';
part 'src/event/has_word_wrap.dart';
part 'src/event/has_html.dart';
part 'src/event/has_text.dart';
part 'src/event/has_name.dart';
part 'src/event/has_focus.dart';
part 'src/event/has_enabled.dart';
part 'src/event/has_animation.dart';

part 'src/event/has_resize_handlers.dart';
part 'src/event/resize_handler.dart';
part 'src/event/resize_event.dart';

part 'src/event/click_handler.dart';
part 'src/event/click_event.dart';
part 'src/event/has_click_handlers.dart';

part 'src/event/change_event.dart';
part 'src/event/change_handler.dart';
part 'src/event/has_change_handlers.dart';

part 'src/event/takes_value.dart';
part 'src/event/has_value.dart';

part 'src/event/has_before_selection_handlers.dart';

part 'src/event/has_all_drag_and_drop_handlers.dart';
part 'src/event/drag_drop_event_base.dart';

part 'src/event/has_drag_end_handlers.dart';
part 'src/event/drag_end_handler.dart';
part 'src/event/drag_end_event.dart';

part 'src/event/has_drag_enter_handlers.dart';
part 'src/event/drag_enter_handler.dart';
part 'src/event/drag_enter_event.dart';

part 'src/event/has_drag_leave_handlers.dart';
part 'src/event/drag_leave_handler.dart';
part 'src/event/drag_leave_event.dart';

part 'src/event/has_drag_handlers.dart';
part 'src/event/drag_handler.dart';
part 'src/event/drag_event.dart';

part 'src/event/has_drag_over_handlers.dart';
part 'src/event/drag_over_handler.dart';
part 'src/event/drag_over_event.dart';

part 'src/event/has_drag_start_handlers.dart';
part 'src/event/drag_start_handler.dart';
part 'src/event/drag_start_event.dart';

part 'src/event/has_drop_handlers.dart';
part 'src/event/drop_handler.dart';
part 'src/event/drop_event.dart';

part 'src/event/has_double_click_handlers.dart';
part 'src/event/double_click_handler.dart';
part 'src/event/double_click_event.dart';

part 'src/event/has_all_focus_handlers.dart';

part 'src/event/has_focus_handlers.dart';
part 'src/event/focus_handler.dart';
part 'src/event/focus_event.dart';

part 'src/event/has_blur_handlers.dart';
part 'src/event/blur_handler.dart';
part 'src/event/blur_event.dart';

part 'src/event/has_all_gesture_handlers.dart';

part 'src/event/has_gesture_start_handlers.dart';
part 'src/event/gesture_start_handler.dart';
part 'src/event/gesture_start_event.dart';

part 'src/event/has_gesture_change_handlers.dart';
part 'src/event/gesture_change_handler.dart';
part 'src/event/gesture_change_event.dart';

part 'src/event/has_gesture_end_handlers.dart';
part 'src/event/gesture_end_handler.dart';
part 'src/event/gesture_end_event.dart';

part 'src/event/has_all_key_handlers.dart';

part 'src/event/has_key_up_handlers.dart';
part 'src/event/key_up_handler.dart';
part 'src/event/key_up_event.dart';

part 'src/event/key_event.dart';
part 'src/event/key_code_event.dart';

part 'src/event/has_key_down_handlers.dart';
part 'src/event/key_down_handler.dart';
part 'src/event/key_down_event.dart';

part 'src/event/has_key_press_handlers.dart';
part 'src/event/key_press_handler.dart';
part 'src/event/key_press_event.dart';

part 'src/event/has_all_mouse_handlers.dart';

part 'src/event/has_mouse_down_handlers.dart';
part 'src/event/mouse_down_handler.dart';
part 'src/event/mouse_down_event.dart';

part 'src/event/has_mouse_up_handlers.dart';
part 'src/event/mouse_up_handler.dart';
part 'src/event/mouse_up_event.dart';

part 'src/event/has_mouse_out_handlers.dart';
part 'src/event/mouse_out_handler.dart';
part 'src/event/mouse_out_event.dart';

part 'src/event/has_mouse_over_handlers.dart';
part 'src/event/mouse_over_handler.dart';
part 'src/event/mouse_over_event.dart';

part 'src/event/has_mouse_move_handlers.dart';
part 'src/event/mouse_move_handler.dart';
part 'src/event/mouse_move_event.dart';

part 'src/event/has_mouse_wheel_handlers.dart';
part 'src/event/mouse_wheel_handler.dart';
part 'src/event/mouse_wheel_event.dart';

part 'src/event/touch_event.dart';
part 'src/event/has_all_touch_handlers.dart';

part 'src/event/has_touch_start_handlers.dart';
part 'src/event/touch_start_handler.dart';
part 'src/event/touch_start_event.dart';

part 'src/event/has_touch_move_handlers.dart';
part 'src/event/touch_move_handler.dart';
part 'src/event/touch_move_event.dart';

part 'src/event/has_touch_end_handlers.dart';
part 'src/event/touch_end_handler.dart';
part 'src/event/touch_end_event.dart';

part 'src/event/has_touch_cancel_handlers.dart';
part 'src/event/touch_cancel_handler.dart';
part 'src/event/touch_cancel_event.dart';

part 'src/event/has_direction_estimator.dart';

part 'src/event/has_directional_safe_html.dart';

part 'src/event/has_directional_text.dart';

part 'src/event/has_safe_html.dart';

part 'src/event/has_load_handlers.dart';
part 'src/event/load_handler.dart';
part 'src/event/load_event.dart';

part 'src/event/has_error_handlers.dart';
part 'src/event/error_handler.dart';
part 'src/event/error_event.dart';

part 'src/event/auto_direction_handler_target.dart';

part 'src/event/before_selection_handler.dart';
part 'src/event/before_selection_event.dart';

part 'src/event/has_selection_handlers.dart';
part 'src/event/selection_handler.dart';
part 'src/event/selection_event.dart';

part 'src/event/human_input_event.dart';
part 'src/event/mouse_event.dart';

part 'src/event/has_horizontal_scrolling.dart';
part 'src/event/has_vertical_scrolling.dart';
part 'src/event/has_scroll_handlers.dart';
part 'src/event/scroll_handler.dart';
part 'src/event/scroll_event.dart';

part 'src/event/has_native_event.dart';
part 'src/event/native_preview_event.dart';
part 'src/event/native_preview_handler.dart';

part 'src/event/adapter/blur_handler_adapter.dart';
part 'src/event/adapter/change_handler_adapter.dart';
part 'src/event/adapter/click_handler_adapter.dart';
part 'src/event/adapter/double_click_handler_adapter.dart';
part 'src/event/adapter/drag_end_handler_adapter.dart';
part 'src/event/adapter/drag_enter_handler_adapter.dart';
part 'src/event/adapter/drag_handler_adapter.dart';
part 'src/event/adapter/drag_leave_handler_adapter.dart';
part 'src/event/adapter/drag_over_handler_adapter.dart';
part 'src/event/adapter/drag_start_handler_adapter.dart';
part 'src/event/adapter/drop_handler_adapter.dart';
part 'src/event/adapter/error_handler_adapter.dart';
part 'src/event/adapter/focus_handler_adapter.dart';
part 'src/event/adapter/gesture_change_handler_adapter.dart';
part 'src/event/adapter/gesture_end_handler_adapter.dart';
part 'src/event/adapter/gesture_start_handler_adapter.dart';
part 'src/event/adapter/key_down_handler_adapter.dart';
part 'src/event/adapter/key_press_handler_adapter.dart';
part 'src/event/adapter/key_up_handler_adapter.dart';
part 'src/event/adapter/load_handler_adapter.dart';
part 'src/event/adapter/mouse_down_handler_adapter.dart';
part 'src/event/adapter/mouse_move_handler_adapter.dart';
part 'src/event/adapter/mouse_out_handler_adapter.dart';
part 'src/event/adapter/mouse_over_handler_adapter.dart';
part 'src/event/adapter/mouse_up_handler_adapter.dart';
part 'src/event/adapter/mouse_wheel_handler_adapter.dart';
part 'src/event/adapter/scroll_handler_adapter.dart';
part 'src/event/adapter/touch_cancel_handler_adapter.dart';
part 'src/event/adapter/touch_end_handler_adapter.dart';
part 'src/event/adapter/touch_move_handler_adapter.dart';
part 'src/event/adapter/touch_start_handler_adapter.dart';