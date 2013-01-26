Dart Web Toolkit Changes
========================

**January 27, 2013

* Renamed IntBox to IntegerBox, IntParser to IntegerParser, IntRenderer to IntegerRenderer.
* Implemented Hidden widget. Example added.
* Checked SimpleCheckBox, SimpleRadioButton, ValueBoxBase, TextBoxBase, TextArea, TextBox, PasswordTextBox, ValueBox, DoubleBox, IntegerBox, Frame, Hidden, Hyperlink.
* AutoDirectionHandler, AtoDirectionHandlerTarget and HasDirection moved to i18n library

**January 24, 2013

* Prepared to CI testing on Drone.io

**January 23, 2013

* Fixed events for CustomButton, PushButton and ToggleButton. Added example.
* Branch 0.2 merged down to Master branch.
* Code cleaned and follow Dart SDK 0.3.1.1_r17328.

**January 22, 2013

* Fixing Events issues.

**January 20, 2013

* Checked CheckBox, RadioButton.
* Fixed CheckBox and RadionButton sunkEvent methods.

**January 19, 2013

* Code cleaned and follow Dart SDK 0.2.10.1_r16761.

**January 16, 2013

* Implemented set of Adapters for EventHandlers because Dart doesn't support anonimous interfaces.
* Checked Anchor events dispatching.
* All content of Shared library have been moved into Event, I18n and Editor libraries. Shared library Removed.

**January 15, 2013

* Added Browser lib for access to dart.js.
* Checked ButtonBase, Button, ResetButton, SubmitButton, CheckBox.
* Improved sunkEvent mechanism in Dom.

**January 14, 2013

* Checked UiObject, Widget, FocusWidget, Anchor.

**January 11, 2013

* Migrate project code to follow Dart SDK version 0.2.10.1_r16761.
* Fixed minor migration bugs.

**January 8, 2013

* Added Events support. DoubleClickHandler, FocusHandler, BlurHandler, KeyUpHandler, KeyDownHandler, KeyPressHandler, MouseDownHandler, MouseMoveHandler, MouseOutHandler, MouseOverHandler, MouseUpHandler, MouseWheelHandler, TouchCancelHandler, TouchEndHandler, TouchMoveHandler, TouchStartHandler, GestureChangeHandler, GestureEndHandler, GestureStartHandler, DragEndHandler, DragEnterHandler, DragHandler, DragLeaveHandler, DragOverHandler, DragStartHandler, DropHandler. Added couple of examples.
* Fixed bug in SimpleEventBus.
* Added original methods into HasDragEndHandlers, HasDragEnterHandlers, HasDragHandlers, HasDragLeaveHandlers, HasDragOverHandlers, HasDragStartHandlers, HasDropHandlers, HasErrorHandlers, HasKeyDownHandlers, HasKeyPressHandlers, HasLoadHandlers, HasMouseDownHandlers, HasMouseMoveHandlers, HasMouseOutHandlers, HasMouseOverHandlers, HasMouseUpHandlers, HasMouseWheelHandlers, HasTouchCancelHandlers, HasTouchEndHandlers, HasTouchMoveHandlers, HasTouchStartHandlers.
* Fixed problems in Frame and Image classes
* Added ErrorEvent, ErrorHandler, LoadEvent and LoadHandler.
* Fixed event handler for StackPanel.

**January 7, 2013

* Implemented SafeHtmlString and SafeHtmlUtils.
* Implemented DialogBox. Added example.
* Implemented Frame. Added example.
* Created 0.2 feature branch.
* Added events. Changed Widget, FocusWidget, FocusPanel and TabBar. Added example.

**January 6, 2013

* Implemented DecoratedPopupPanel. Fixed DecoratedPanel. Added example.

**January 5, 2013

* Implemented TabBar, TabPanel. Added Example.

**January 4, 2013

* Implemented PopupPanel. Added example.

**January 3, 2013

* Implemented DeckPanel. Added example.
* Implemented HtmlTable.
* Implemented FlexTable. Added example.
* Implemented Grid. Added example.
* Implemented SimpleLayoutPanel.
* Implemented ScrollPanel, HasHorizontalScrolling, HasScrollHandlers, HasVerticalScrolling, ScrollEvent, ScrollHandler, HasScrolling, ScrollImpl. Added example.

**January 2, 2013

* Implemented TabLayoutPanel. Added example.

**January 1, 2013

* Implemented Image. Added example.
* Implemented FlowPanel. Added example.
* Implemented HtmlPanel. Added example.
* Implemented LazyPanel.
* Implemented CaptionPanel. Added example.

**December 31, 2012

* Implemented DeckLayoutPanel. Added example.
* Implemented NumberLabel. Added example.

**December 30, 2012

* Partial implemntation of localization.
* Implemented DateLabel, DoubleBox, IntBox, ValueBox and ValueLabel.
* Added text library with parsers and renderers.
* IntegerBox renamed to IntBox.
* Implemented SimpleCheckBox and SimpleRadioButton. Example added.

**December 28, 2012

* Implemented part of i18n and TextDecorator.
* Implemted Mouse, Touch, Drag and Drop handlers.
* Implemented Label and StackLayoutPanel. Added examples.
* Implemented Html. Added examples.
* Implemented InlineHtml, InlineLabel.

**December 26, 2012

* Implemented StackPanel, DecoratedStackPanel and part of DecoratorPanel. Added example.

**December 25, 2012

* Housekeeping.
* Implemented empty abstract classes.
* Abstract classes HasAlignment, HasEnabled, HasFocus, HasHorizontalAlignment, HasHtml, HasName, HasText, HasVerticalAlignment, HasWordWrap moved to 'shared' library.
* Abstract classes HasResizeHandlers, HasVisibility, ResizeEvent, ResizeHandler moved to 'shared' library.
* Added classes HasDragEndHandlers, HasDragEnterHandlers, HasDagHandlers, HasDragLeaveHandlers, HasDragOverHandlers, HasDragStartHandlers, HasDropHandlers, HasDoubleClickHandlers, HasFocusHandlers, HasBlurHandlers, HasGestureStartHandlers, HasGestureChangeHandlers, HasGestureEndHandlers, HasAllKeyHandlers, HasKeyUpHandlers, HasKeyDownHandlers, HasKeyPressHandlers, HasAllMouseHandlers, HasMouseDownHandlers, HasMouseUpHandlers, HasMouseOutHandlers, HasMouseOverHandlers, HasMouseMoveHandlers, HasMouseWheelHandlers, HasAllTouchHandlers, HasTouchStartHandlers, HasTouchMoveHandlers, HasTouchCancelHandlers, HasDirectionEstimator, HasDirectionalSafeHtml, HasDirectionalText, HasSafeHtml, IsEditor, LeafeValueEditor, Editor, HasLoadHandlers, HasErrorHandlers to 'shared' library.
* Implemented TextBoxBase, ValueBoxBase, TextBox, PasswordTextBox, TextArea.

**December 24, 2012

* Implemented ListBox. Added example.

**December 23, 2012

* Implemented CustomButton, PushButton and ToggleButton. Added example.
* Implemented part of Role.

**December 21, 2012

* Implemented SplitLayoutPanel and Spliters. Fixed small bug in LayoutImpl. Added example.
* Implemented FileUpload. Added example.
* 'run.sh' has been added into test folder.

**December 20, 2012

* Implemented AnimatedLayout, DockLayoutPanel, LayoutCommand, WidgetCollection, Enum and RemoveIteraror.
* Internal Style classes Display, Overflow, Position, Unit, WhiteSpace now extends Enum class.
* Implemented LayoutPanel and RootLayoutPanel. Fixed small issue in Scheduler.

**December 19, 2012

* Fixed 'extractLengthValue' method in UiObject, and small bugs in Timer.
* Removed 'empty' factory constructor from Anchor. HeaderPanel added to example.
* Reviewed Style implementation in UiObject. Added styles to Anchor, Button, ResetButton, SubmitButton.
* Method 'getFocusHelper' using instead of factory constructor in FocusHelper. Static variable of FocusHelper removed from FocusWidget.
* Veriable 'element' is private in Widget now. Changed Anchor and FocusManager.
* Implemented CheckBox widget. Added example
* Implemented RadioButton widget. Added example.
* Implemented VerticalPanel and HorizontalPanel. Added examples.

**December 18, 2012

* Added resources and animation, layout, scheduler, command, accepts_one_widget, button, button_base, composite, finite_widget_iterator, has_one_widget, has_resize_handlers, header_panel, resize_layout_panel_impl, is_renderable, panel_iterator, provides_resize, requires_resize, reset_button, resize_event, resize_handler, resize_layout_panel, simple_panel, submit_button, util

**December 15, 2012

* Command class renamed to AttachCommand in UI library.
* Added style methods to UiObject.
* Fixed readme.md

**December 13, 2012

* Implemntation Event handling examples.

**December 12, 2012

* Panel, ComplexPanel, AbsolutePanel and RootPanel has been implemented.
* Added Styles into Widget.
* Working example to test RootPanel and Anchor widgets.

**December 11, 2012

* Prepared base structure of project.
* Implemented event and ui components.