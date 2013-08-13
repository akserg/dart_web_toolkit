//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library test_uibinder;

import 'dart:html' as dart_html;

import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/uibinder.dart';

part 'dynamic_panel.dart';
part 'login_view.dart';

void main() {
  dart_html.query("#loading").remove();
  //
  String template = """
<div class='dyn-panel'>
  <div ui:field='userLabel' class='dyn-message'>User Name</div>
  <input ui:field='userInput'>
  <div ui:field='passwordLabel' class='dyn-message'>Password</div>
  <input ui:field='passwordInput'>
  <button ui:field='logonButton'>Logon</button>
</div>""";
  
  ui.RootPanel.get().add(new LoginView(template));
}