//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit UiBinder library.
 */
library uibinder;

import 'dart:html';
import 'dart:mirrors';
import 'ui.dart';

part 'src/uibinder/binder.dart';
part 'src/uibinder/parser.dart';
part 'src/uibinder/processor.dart';
part 'src/uibinder/creator.dart';

/**
 * Marks fields in a UiBinder client that must be filled by the binder's
 * [UiBinder#createAndBindUi] method.
 */
const UiField = const _UiField();

class _UiField {
  const _UiField();
}