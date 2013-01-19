//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that serves as an "internal" hyperlink. That is, it is a link to
 * another state of the running application. It should behave exactly like
 * {@link com.google.gwt.user.client.ui.Hyperlink}, save that it lays out
 * as an inline element, not block.
 *
 * <p>
 * <h3>Built-in Bidi Text Support</h3>
 * This widget is capable of automatically adjusting its direction according to
 * its content. This feature is controlled by {@link #setDirectionEstimator} or
 * passing a DirectionEstimator parameter to the constructor, and is off by
 * default.
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-InlineHyperlink { }</li>
 * </ul>
 */
class InlineHyperlink extends Hyperlink {

  /**
   * Creates an empty hyperlink.
   */
  InlineHyperlink(String text, [String targetHistoryToken = null]) : super(null) {
    clearAndSetStyleName("dwt-InlineHyperlink");
  }
}
