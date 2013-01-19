//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A normal push button with custom styling.
 *
 * <p>
 * <img class='gallery' src='doc-files/PushButton.png'/>
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class="css">
 * <li>.gwt-PushButton-up/down/up-hovering/down-hovering/up-disabled/down-disabled {.html-face}</li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3> {@example com.google.gwt.examples.PushButtonExample}
 * </p>
 */
class PushButton extends CustomButton {

  static final String _STYLENAME_DEFAULT = "dwt-PushButton";

  /**
   * Constructor for <code>CustomButton</code>.
   *
   * @param upImage image for the default (_up) face of the button
   */
  PushButton.fromImage(Image upImage, {Image downImage:null, ClickHandler handler:null}) : super.fromImage(upImage, downImage:downImage, handler:handler);

  /**
   * Constructor for <code>CustomButton</code>.
   *
   * @param upText the text for the default (_up) face of the button
   */
  PushButton.fromText(String upText, {String downText:null, ClickHandler handler:null}) : super.fromText(upText, downText:downText, handler:handler);

  PushButton.internal() : super.internal();

  /**
   * Constructor for <code>CustomButton</code>.
   */
  void _init() {
    super._init();
    //
    clearAndSetStyleName(_STYLENAME_DEFAULT);
  }

  void onClick() {
    setDown(false);
    super.onClick();
  }

  void onClickCancel() {
    setDown(false);
  }

  void onClickStart() {
    setDown(true);
  }
}
