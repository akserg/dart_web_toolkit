//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library hello;

import 'dart:html' as dart_html;

import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/util.dart' as util;
import 'package:dart_web_toolkit/i18n.dart' as i18n;

//*******************************
//*******************************
//*******************************

// PushButton and ToggleButtons
void main() {
  ui.VerticalPanel vpanel = new ui.VerticalPanel();

  ui.HorizontalPanel pushPanel = new ui.HorizontalPanel();
  pushPanel.spacing = 10;

  ui.HorizontalPanel togglePanel = new ui.HorizontalPanel();
  togglePanel.spacing = 10;

  // Combine all the panels
  vpanel.add(new ui.Html("Custom Button"));
  vpanel.add(pushPanel);
  vpanel.add(new ui.Html("<br><br>PushButtons and ToggleButtons allow you to customize the look of your buttons"));
  vpanel.add(togglePanel);

  ui.PushButton normalPushButton = new ui.PushButton.fromImage(new ui.Image("img/test.jpg"));
  _addAllHandlers(normalPushButton);
  pushPanel.add(normalPushButton);

  // Add a disabled PushButton
  ui.PushButton disabledPushButton = new ui.PushButton.fromImage(new ui.Image("img/test.jpg"));
  disabledPushButton.enabled = false;
  pushPanel.add(disabledPushButton);

// Add a normal ToggleButton
  ui.ToggleButton normalToggleButton = new ui.ToggleButton.fromImage(new ui.Image("img/test.jpg"));
  _addAllHandlers(normalToggleButton);
  togglePanel.add(normalToggleButton);

  // Add a disabled ToggleButton
  ui.ToggleButton disabledToggleButton = new ui.ToggleButton.fromImage(new ui.Image("img/test.jpg"));
  disabledToggleButton.enabled = false;
  togglePanel.add(disabledToggleButton);

  ui.RootPanel.get("testId").add(vpanel);
}

// RadioButton
void main04() {
  ui.RadioButton radioButton = new ui.RadioButton("radio_test", "<b>Hi RadioButton 1</b>", true);
  radioButton.getElement().id = "One";
  _addAllHandlers(radioButton);
  ui.RootPanel.get("testId").add(radioButton);

  radioButton = new ui.RadioButton("radio_test", "<b>Hi RadioButton 2</b>", true);
  radioButton.getElement().id = "Two";
  _addAllHandlers(radioButton);
  ui.RootPanel.get("testId").add(radioButton);

  radioButton = new ui.RadioButton("radio_test", "<b>Hi RadioButton 3</b>", true);
  radioButton.getElement().id = "Three";
  _addAllHandlers(radioButton);
  ui.RootPanel.get("testId").add(radioButton);
}

// CheckBox
void main03() {
  ui.CheckBox checkBox = new ui.CheckBox("<b>Hi CheckBox</b>", true);

  _addAllHandlers(checkBox);

  ui.RootPanel.get("testId").add(checkBox);
}

// Button
void main02() {
  ui.Button button = new ui.Button("<b>Hi Button</b>");

  _addAllHandlers(button);

  ui.RootPanel.get("testId").add(button);
}

// Anchor
void main01() {
  ui.Anchor anchor = new ui.Anchor(true);
  anchor.html = "<b>Hi Anchor</b>";

  _addAllHandlers(anchor);

  ui.RootPanel.get("testId").add(anchor);

}

void _addAllHandlers(ui.Widget widget) {
  if (widget is event.HasClickHandlers) {
    widget.addClickHandler(new event.ClickHandlerAdapter(_print));
  }
  if (widget is event.HasDoubleClickHandlers) {
    widget.addDoubleClickHandler(new event.DoubleClickHandlerAdapter(_print));
  }
  if (widget is event.HasAllFocusHandlers) {
    widget.addFocusHandler(new event.FocusHandlerAdapter(_print));
    widget.addBlurHandler(new event.BlurHandlerAdapter(_print));
  }
  if (widget is event.HasAllMouseHandlers) {
    widget.addMouseDownHandler(new event.MouseDownHandlerAdapter(_print));
    widget.addMouseUpHandler(new event.MouseUpHandlerAdapter(_print));
    widget.addMouseOutHandler(new event.MouseOutHandlerAdapter(_print));
    widget.addMouseOverHandler(new event.MouseOverHandlerAdapter(_print));
    widget.addMouseMoveHandler(new event.MouseMoveHandlerAdapter(_print));
    widget.addMouseWheelHandler(new event.MouseWheelHandlerAdapter(_print));
  }
  if (widget is event.HasAllKeyHandlers) {
    widget.addKeyUpHandler(new event.KeyUpHandlerAdapter(_print));
    widget.addKeyDownHandler(new event.KeyDownHandlerAdapter(_print));
    widget.addKeyPressHandler(new event.KeyPressHandlerAdapter(_print));
  }
  // HasAllDragAndDropHandlers, HasAllGestureHandlers, HasAllTouchHandlers
  if (widget is event.HasValueChangeHandlers) {
    widget.addValueChangeHandler(new event.ValueChangeHandlerAdapter(_print));
  }
}

void _print(event.DwtEvent evt) {
  if (evt is event.DomEvent) {
    print("Source: ${evt.getRelativeElement().toString()} Event: ${evt.getNativeEvent().type} ID: ${evt.getRelativeElement().id != null ? evt.getRelativeElement().id : ''}");
  } else {
    if (evt.getSource() is dart_html.Element && (evt.getSource() as dart_html.Element).id != null) {
      print("Source: ${evt.getSource()} Event: ${evt.toString()} ID: ${(evt.getSource() as dart_html.Element).id}");
    } else {
      print("Source: ${evt.getSource()} Event: ${evt.toString()}");
    }
  }
}