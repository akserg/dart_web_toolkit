Dart Web Toolkit Changes
========================

** May 29, 2013

* Migrate project code to follow Dart SDK version 0.5.11.1_r23200.

** May 24, 2013

* Improved SafeHtmlRenderer.

** May 21, 2013

* Migrate project code to follow Dart SDK version 0.5.9.0_r22879

** May 18, 2013

* Migrate project code to follow Dart SDK version 0.5.7.3_r22659

** May 13, 2013

* Dom and DomImpl supports style properties.
* HasHorizontalAlign and HasVerticalAlign constans now.
* Implemented Safe Style utility classes.
* Fixed Safe Html classes.
* Migrate project code to follow Dart SDK version 0.5.7.2_r22611.

** May 7, 2013

* Migrate project code to follow Dart SDK version 0.5.5_r22416.
* Fixed minor fug in uri_utils.dart
* Cleaned comments.

** May 6, 2013

* Minor bugs fixing.
* Added script to generate API Documentation.
* Changed library minor version number.

** May 3, 2013

* Use Map nature of Elements dataset to manage attributes in ElementMapperImpl.
* Migrate project code to follow Dart SDK version 0.5.3.0_r22223.
* Fixed bugs after migration.

** May 1, 2013

* Path to resources has been changed in the core.

** April 30, 2013

* dart2js: Fixed NPE inside insert method of ComplexPanel.
* dart2js: Implemented method forEach of WidgetCollection

** April 29, 2013

* Migrate project code to follow Dart SDK version 0.5.0.1_r21823.
* Fixed bugs after migration.
* Fiexed currency_list.dart and widget_collection.dart because Collection interface removed.
* Fixed physical attache inside insert method of ComplexPanel 

** April 5, 2013

* Fixed null pointer exception happed in ComplexPanel in IE.

** April 4, 2013

* Milestone 0.3 reached.

** April 2, 2013

* Unittests for Widget.

** April 1, 2013

* Unittests for UiObject.

** March 31, 2013

* Migrate project code to follow Dart SDK version 0.4.3.5_r20602
* Fixed background color of chrome theme.

** March 28, 2013

* Implemented DisclosurePanel. Cleaned code of MenuBar, Tree.
* To Image class added constructor fromImageResource and method setImageResource.

** March 27, 2013

* Because bug in Dart http://code.google.com/p/dart/issues/detail?id=9356 the logic of set/get text in ValueBoxBase has been changed.

** March 26, 2013

* Fixed bug:Hyperlink.fromElement generates null pointer exception. Changed Hyperlink.
* Aligned styles. Added clean, dark, standard and chrome themes.
* Added treeOpen, TreeClose and treeLeaf images and changed Tree.
* Added menuBarSubMenuIcon and menuBarSubMenuIcon_rtl and changed MenuBar.
* Added disclosurePanelClosed, disclosurePanelClosed_rtl and disclosurePanelOpen to prepare to implementation of DisclosurePanel inrelease  0.3.

** March 24, 2013

* Assigned version 0.2.67.

** March 23, 2013

* Added Activity and Place libraries.

** March 22, 2013

* Fixed bug:Fix DirectionEstimation problem in TextBox. Changed AutoDirectionalHandler, BidiUtils, DirectionEstimaor, DirectionalTextHelper amd WordDirectionEstimator.

** March 21, 2013

* Fixed bug:Fix InlineHyperlink constructor parameters. Changed InlineHyperlink.
* Commentes have been changed in InlineHtmln 
* Fixed bug:Hidden widget does not update value field . Changed ValueBoxBase.

** March 20, 2013

* Fixed bug:TabPanel does not show content of selected tab. Changed TabBar, TabPanel and standard.css

** March 19, 2013

* Fixed bug: TabLayoutPanel does not implemented add method from HasWidgets interface.
* Changed tab_layout_panel.dart.
* Migrate project code to follow Dart SDK version 0.4.2_r20193
* Fixed migration broken changes.

** March 18, 2013

* Fixed bug: Change parameters UnclippedState constructor.
* Changed image.dart
* Example code migration finished. Example folder removed.

** March 16, 2013

* Fixed bug: Dart to Js compilation issue in tree.dart.
* Changed tree.dart.
* Fixed bug: Dart to Js compilation issue StackPanel.
* Changed stack_panel.dart.

** March 15, 2013

* Fixed bug: Dart to Js compilation issue in animation_scheduler_impl_timer.dart
* Changed animation_scheduler_impl_timer.dart.
* Changed relative path to Menu.png in menu_bar.dart.
* Changed access level to variable timers in Timer class.

** March 14, 2013

* Fixed bug: Not finding image file.
* Changed files Tree, ClippedImageImpl. Hello file updated.

** March 11, 2013

* Fixed bug: History does not use HistoryImpl.
* Changed History. Example updated.
* Fixed bug: Image clip does not work. Example updated.

** March, 6, 2013

* Migrate project code to follow Dart SDK version 0.4.1.0_r19425
* Fixed migration bugs in Request, SchedulerImpl, TimeZone, Timer
* Removed all print to console in AttachDetachException, ClippedImageImpl, UiObject, Widget, 
* Fixed bug in Tree: Could not add elements in non extendable array

** March 1, 2013

* Fixed Tree: Tree items does not show hand cursor

** February 27, 2013

* Restored dart code analyzer in run.sh

** February 26, 2013

* Fixed bug Dart Timer calling with Duration. Modified SchedulerImpl and Timer.

** February 25, 2013

* Updated UmbrellaException, BidiFormatterBase, DateRecord, Attribute and HtmlPanel.

** February 24, 2013

* Migrate project code to follow Dart SDK version 0.3.7.6_r18717
* Updated AnimationSchedulerImplWebkit, DragDropEventBase, DomImpl, DomImplStandard, SchedulerImpl, Image, ClippedImage, ElementMapperImpl, Timer.

** February 21, 2013

* Added SelectionHandlerAdapter, BeforeSelectionAdapter.

** February 20, 2013

* Fixed Panel content alignment.
* Fixed CellPanel content alignment.

** February 18, 2013

* Added ScheduledCommandAdapter and RepeatingCommandAdapter to 'scheduler' library.

** February 17, 2013

* Removed referenced on depraceted code:
 - Strings;
 - Date;
 - 'on' method in elements

** February 13, 2013

* Implemented NotificationMole. Added exxample.
* Fixed animation problem.
* Fixed PopupPanel: resizing
* Fixed DecoratedPopupPanel: autohide
* Fixed DialogBox: autohide, resize and center
* Fixed HeaderPanel component
* Fixed TabPanel component layout

** February 12, 2013
* Migrate project code to follow Dart SDK version 0.3.5.1_r18300
* Fixed MenuBar doesn't show sub menu image.

** February 11, 2013

* Fixed MenuBar shows submeus in wrong position.

** February 9, 2013

* Implemented MenuBar. Added example.
* Fixed autohide PopupDialog bug
* Fixed Dialog movements.

** February 7, 2013

* Fixed dependencies versions in pubspec.yaml.
* Changed License and Credits sections in README.md.
* Added Dynamic Tree example.

** February 6, 2013

* Code changed to using Focusable instead HasFocus. Last one has been removed.
* Because HasFocus deletion FocusPanel, FocusWidget has been updated.
* Implemented Tree, TreeItem and resources. 
* Migrate project code to follow Dart SDK version 0.3.4.0_r18115.
* Reference on Clipboard class changed to DataTransfer. Example fixed.
* Fixed: ClippedImageImpl doesn't create instance of Image.
* Added tree example.
* Fixed: Tree incorrect shows navigation images.

** February 4, 2013

* Added http and core libraries.

**  February 3, 2013
* Clean source code.
* Clean example Hello class, added more examples.

** February 2, 2013

* Checked Composite, PopupPanel, ScrollPanel, StackLayoutPanel, TabBar, TabLayoutPanel, TabPanel. Added examples.
* Implemented AnimationType.

** February 1, 2013

* Checked DecoratorPanel, FlexTable, HeaderPanel, HeaderPanel, HtmlTable, ResizeLayoutPanel, StackPanel. Added examples.

** January 31, 2013

* Checked HtmlPanel, RootLayoutPanel, StackPanel. Added examples.

** January 30, 2013

* Fixed bug capturing element doesn't recieve events in Dom, DomImplStandard and Splitter
* Checked SplitLayoutPanel. Added example.

** January 29, 2013

* Fixed Dart SDK breaking changes Element.dispatchEvent in Image and CustomButton.
* Fixed Dart SDK breaking changes LinkedHashMap in TerstGroup.
* Migrate project code to follow Dart SDK version 0.3.2.0_r17657.
* Deleted Diterable class.
* Fixed Dart SDK breaking changes: iterator is field in Iterable now.
* Checked DeckPanel and DeckLayoutPanel. Added examples.

** January 28, 2013

* Implemented DockPanel. Added Example.
* Fixed Timer null pointer exception.
* Fixed animation's bug in DeckLayoutPanel. Added example.
* Added coupler of styles.
* Cleaned BrowserEvents.
* Renamed DomHelper to DomImpl, DomHelperDefault to DomImplStandard.
* Moved HasDirectionalHtml from ui to i18n libraries.
* Moved DirectionalTextHelper from ui to i18n library.

** January 27, 2013

* Checked Image.
* Fixed small bugs in Hidden.
* HasDirectionalSafeHtml and HasDirectionalText moved to i18n.
* Checked Anchor, CheckBox, Image, Label, LabelBase. Added examples.
* Checked Panel, ComplexPanel, AbsolutePanel, RootPanel.

** January 26, 2013

* Renamed IntBox to IntegerBox, IntParser to IntegerParser, IntRenderer to IntegerRenderer.
* Implemented Hidden widget. Example added.
* Checked SimpleCheckBox, SimpleRadioButton, ValueBoxBase, TextBoxBase, TextArea, TextBox, PasswordTextBox, ValueBox, DoubleBox, IntegerBox, Frame, Hidden, Hyperlink.
* AutoDirectionHandler, AtoDirectionHandlerTarget and HasDirection moved to i18n library

** January 24, 2013

* Prepared to CI testing on Drone.io

** January 23, 2013

* Fixed events for CustomButton, PushButton and ToggleButton. Added example.
* Branch 0.2 merged down to Master branch.
* Code cleaned and follow Dart SDK 0.3.1.1_r17328.

** January 22, 2013

* Fixing Events issues.

** January 20, 2013

* Checked CheckBox, RadioButton.
* Fixed CheckBox and RadionButton sunkEvent methods.

** January 19, 2013

* Code cleaned and follow Dart SDK 0.2.10.1_r16761.

** January 16, 2013

* Implemented set of Adapters for EventHandlers because Dart doesn't support anonimous interfaces.
* Checked Anchor events dispatching.
* All content of Shared library have been moved into Event, I18n and Editor libraries. Shared library Removed.

** January 15, 2013

* Added Browser lib for access to dart.js.
* Checked ButtonBase, Button, ResetButton, SubmitButton, CheckBox.
* Improved sunkEvent mechanism in Dom.

** January 14, 2013

* Checked UiObject, Widget, FocusWidget, Anchor.

** January 11, 2013

* Migrate project code to follow Dart SDK version 0.2.10.1_r16761.
* Fixed minor migration bugs.

** January 8, 2013

* Added Events support. DoubleClickHandler, FocusHandler, BlurHandler, KeyUpHandler, KeyDownHandler, KeyPressHandler, MouseDownHandler, MouseMoveHandler, MouseOutHandler, MouseOverHandler, MouseUpHandler, MouseWheelHandler, TouchCancelHandler, TouchEndHandler, TouchMoveHandler, TouchStartHandler, GestureChangeHandler, GestureEndHandler, GestureStartHandler, DragEndHandler, DragEnterHandler, DragHandler, DragLeaveHandler, DragOverHandler, DragStartHandler, DropHandler. Added couple of examples.
* Fixed bug in SimpleEventBus.
* Added original methods into HasDragEndHandlers, HasDragEnterHandlers, HasDragHandlers, HasDragLeaveHandlers, HasDragOverHandlers, HasDragStartHandlers, HasDropHandlers, HasErrorHandlers, HasKeyDownHandlers, HasKeyPressHandlers, HasLoadHandlers, HasMouseDownHandlers, HasMouseMoveHandlers, HasMouseOutHandlers, HasMouseOverHandlers, HasMouseUpHandlers, HasMouseWheelHandlers, HasTouchCancelHandlers, HasTouchEndHandlers, HasTouchMoveHandlers, HasTouchStartHandlers.
* Fixed problems in Frame and Image classes
* Added ErrorEvent, ErrorHandler, LoadEvent and LoadHandler.
* Fixed event handler for StackPanel.

** January 7, 2013

* Implemented SafeHtmlString and SafeHtmlUtils.
* Implemented DialogBox. Added example.
* Implemented Frame. Added example.
* Created 0.2 feature branch.
* Added events. Changed Widget, FocusWidget, FocusPanel and TabBar. Added example.

** January 6, 2013

* Implemented DecoratedPopupPanel. Fixed DecoratedPanel. Added example.

** January 5, 2013

* Implemented TabBar, TabPanel. Added Example.

** January 4, 2013

* Implemented PopupPanel. Added example.

** January 3, 2013

* Implemented DeckPanel. Added example.
* Implemented HtmlTable.
* Implemented FlexTable. Added example.
* Implemented Grid. Added example.
* Implemented SimpleLayoutPanel.
* Implemented ScrollPanel, HasHorizontalScrolling, HasScrollHandlers, HasVerticalScrolling, ScrollEvent, ScrollHandler, HasScrolling, ScrollImpl. Added example.

** January 2, 2013

* Implemented TabLayoutPanel. Added example.

** January 1, 2013

* Implemented Image. Added example.
* Implemented FlowPanel. Added example.
* Implemented HtmlPanel. Added example.
* Implemented LazyPanel.
* Implemented CaptionPanel. Added example.

** December 31, 2012

* Implemented DeckLayoutPanel. Added example.
* Implemented NumberLabel. Added example.

** December 30, 2012

* Partial implemntation of localization.
* Implemented DateLabel, DoubleBox, IntBox, ValueBox and ValueLabel.
* Added text library with parsers and renderers.
* IntegerBox renamed to IntBox.
* Implemented SimpleCheckBox and SimpleRadioButton. Example added.

** December 28, 2012

* Implemented part of i18n and TextDecorator.
* Implemted Mouse, Touch, Drag and Drop handlers.
* Implemented Label and StackLayoutPanel. Added examples.
* Implemented Html. Added examples.
* Implemented InlineHtml, InlineLabel.

** December 26, 2012

* Implemented StackPanel, DecoratedStackPanel and part of DecoratorPanel. Added example.

** December 25, 2012

* Housekeeping.
* Implemented empty abstract classes.
* Abstract classes HasAlignment, HasEnabled, HasFocus, HasHorizontalAlignment, HasHtml, HasName, HasText, HasVerticalAlignment, HasWordWrap moved to 'shared' library.
* Abstract classes HasResizeHandlers, HasVisibility, ResizeEvent, ResizeHandler moved to 'shared' library.
* Added classes HasDragEndHandlers, HasDragEnterHandlers, HasDagHandlers, HasDragLeaveHandlers, HasDragOverHandlers, HasDragStartHandlers, HasDropHandlers, HasDoubleClickHandlers, HasFocusHandlers, HasBlurHandlers, HasGestureStartHandlers, HasGestureChangeHandlers, HasGestureEndHandlers, HasAllKeyHandlers, HasKeyUpHandlers, HasKeyDownHandlers, HasKeyPressHandlers, HasAllMouseHandlers, HasMouseDownHandlers, HasMouseUpHandlers, HasMouseOutHandlers, HasMouseOverHandlers, HasMouseMoveHandlers, HasMouseWheelHandlers, HasAllTouchHandlers, HasTouchStartHandlers, HasTouchMoveHandlers, HasTouchCancelHandlers, HasDirectionEstimator, HasDirectionalSafeHtml, HasDirectionalText, HasSafeHtml, IsEditor, LeafeValueEditor, Editor, HasLoadHandlers, HasErrorHandlers to 'shared' library.
* Implemented TextBoxBase, ValueBoxBase, TextBox, PasswordTextBox, TextArea.

** December 24, 2012

* Implemented ListBox. Added example.

** December 23, 2012

* Implemented CustomButton, PushButton and ToggleButton. Added example.
* Implemented part of Role.

** December 21, 2012

* Implemented SplitLayoutPanel and Spliters. Fixed small bug in LayoutImpl. Added example.
* Implemented FileUpload. Added example.
* 'run.sh' has been added into test folder.

** December 20, 2012

* Implemented AnimatedLayout, DockLayoutPanel, LayoutCommand, WidgetCollection, Enum and RemoveIteraror.
* Internal Style classes Display, Overflow, Position, Unit, WhiteSpace now extends Enum class.
* Implemented LayoutPanel and RootLayoutPanel. Fixed small issue in Scheduler.

** December 19, 2012

* Fixed 'extractLengthValue' method in UiObject, and small bugs in Timer.
* Removed 'empty' factory constructor from Anchor. HeaderPanel added to example.
* Reviewed Style implementation in UiObject. Added styles to Anchor, Button, ResetButton, SubmitButton.
* Method 'getFocusHelper' using instead of factory constructor in FocusHelper. Static variable of FocusHelper removed from FocusWidget.
* Veriable 'element' is private in Widget now. Changed Anchor and FocusManager.
* Implemented CheckBox widget. Added example
* Implemented RadioButton widget. Added example.
* Implemented VerticalPanel and HorizontalPanel. Added examples.

** December 18, 2012

* Added resources and animation, layout, scheduler, command, accepts_one_widget, button, button_base, composite, finite_widget_iterator, has_one_widget, has_resize_handlers, header_panel, resize_layout_panel_impl, is_renderable, panel_iterator, provides_resize, requires_resize, reset_button, resize_event, resize_handler, resize_layout_panel, simple_panel, submit_button, util

** December 15, 2012

* Command class renamed to AttachCommand in UI library.
* Added style methods to UiObject.
* Fixed readme.md

** December 13, 2012

* Implemntation Event handling examples.

** December 12, 2012

* Panel, ComplexPanel, AbsolutePanel and RootPanel has been implemented.
* Added Styles into Widget.
* Working example to test RootPanel and Anchor widgets.

** December 11, 2012

* Prepared base structure of project.
* Implemented event and ui components.
