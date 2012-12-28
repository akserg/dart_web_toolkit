//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A {@link Composite} implementation that implements {@link RequiresResize} and
 * automatically delegates that interface's methods to its wrapped widget, which
 * must itself implement {@link RequiresResize}.
 */
class ResizeComposite extends Composite implements RequiresResize {
  
  void initWidget(Widget widget) {
    assert (widget is RequiresResize); // : "LayoutComposite requires that its wrapped widget implement RequiresResize";
    super.initWidget(widget);
  }

  void onResize() {
    (getWidget() as RequiresResize).onResize();
  }
}
