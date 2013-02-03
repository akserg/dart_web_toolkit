//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Animation library.
 */
library dart_web_toolkit_animation;

import 'dart:html' as dart_html;
import 'dart:math' as dart_math;

import 'util.dart';
import 'layout.dart';

part 'src/animation/animation.dart';
part 'src/animation/animation_scheduler.dart';
part 'src/animation/animated_layout.dart';

part 'src/animation/impl/animation_scheduler_impl.dart';
part 'src/animation/impl/animation_scheduler_impl_webkit.dart';
part 'src/animation/impl/animation_scheduler_impl_timer.dart';
