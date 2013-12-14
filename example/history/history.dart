//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library history;

import 'dart:html' as dart_html;
import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/event.dart' as event;

void main() {
  dart_html.querySelector("#loading").remove();
  //
  ui.Label lbl = new ui.Label();
  // Create three hyperlinks that change the application's history.
  ui.Hyperlink link0 = new ui.Hyperlink("link to foo", false, "foo");
  ui.Hyperlink link1 = new ui.Hyperlink("link to bar", false, "bar");
  ui.Hyperlink link2 = new ui.Hyperlink("link to baz", false, "baz");

  // If the application starts with no history token, redirect to a new
  // 'baz' state.
  String initToken = ui.History.getToken();
  if (initToken.length == 0) {
    ui.History.newItem("baz");
  }

  // Add widgets to the root panel.
  ui.VerticalPanel panel = new ui.VerticalPanel();
  panel.add(lbl);
  panel.add(link0);
  panel.add(link1);
  panel.add(link2);

  // Add history listener
  ui.History.addValueChangeHandler(new event.ValueChangeHandlerAdapter((event.ValueChangeEvent<String> evt){
    // This method is called whenever the application's history changes. Set
    // the label to reflect the current history token.
    lbl.text = "The current history token is: ${evt.value}";
  }));

  // Now that we've setup our listener, fire the initial history state.
  ui.History.fireCurrentHistoryState();

  ui.RootPanel.get().add(panel);
}