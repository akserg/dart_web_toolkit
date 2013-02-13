//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Simple widget for providing notification feedback.
 */
class NotificationMole extends Composite {

  dart_html.DivElement borderElement;

  dart_html.DivElement heightMeasure;

  dart_html.SpanElement notificationText;

  int showAttempts = 0;

  Timer showTimer;

  _MoleAnimation _animation;

  int _animationDuration = 0;

  NotificationMole() {
    _animation = new _MoleAnimation(this);
    //
    showTimer = new Timer.get(() {
      if (showAttempts > 0) {
        _showImpl();
      }
    });
    //
    _initWidget();
  }

  /**
   * Sets the widget to be wrapped by the composite. The wrapped widget must be
   * set before calling any {@link Widget} methods on this object, or adding it
   * to a panel. This method may only be called once for a given composite.
   *
   * @param widget the widget to be wrapped
   */
  void _initWidget() {
    HtmlPanel widget = new HtmlPanel("");
    widget.clearAndSetStyleName("container");
    widget.getElement().style.position = Position.ABSOLUTE.value;
    widget.getElement().style.height = "0".concat(Unit.PX.value);
    widget.getElement().style.textAlign = TextAlign.CENTER.value;
    widget.getElement().style.width = "100".concat(Unit.PCT.value);
    //
    borderElement = new dart_html.DivElement();
    borderElement.style.marginLeft = "auto";
    borderElement.style.marginRight = "auto";
    borderElement.style.borderLeft = "1px solid #96A2B5";
    borderElement.style.borderRight = "1px solid #96A2B5";
    borderElement.style.borderBottom = "1px solid #96A2B5";
    borderElement.style.backgroundColor = "#E5EDF9";
    borderElement.style.padding = "5px";
    borderElement.style.overflow = Overflow.HIDDEN.value;
//    borderElement.style.display = Display.INLINE_BLOCK.value;
    borderElement.style.display = Display.NONE.value;
    widget.getElement().append(borderElement);
    //
    heightMeasure = new dart_html.DivElement();
    borderElement.append(heightMeasure);
    //
    notificationText = new dart_html.SpanElement();
    notificationText.style.fontFamily = "Helvetica";
    notificationText.style.fontSize = "1em";
    heightMeasure.append(notificationText);
    //
    super.initWidget(widget);
  }

  /**
   * Hides the notification.
   */
  void hide() {
    if (showAttempts > 0) {
      --showAttempts;
    }
    if (showAttempts == 0) {
      _animation.animateMole(heightMeasure.offsetHeight, 0, _animationDuration);
      return;
    }
  }

  /**
   * Force mole to hide and discard outstanding show attempts.
   */
  void hideNow() {
    showAttempts = 0;
    _animation.animateMole(heightMeasure.offsetHeight, 0, _animationDuration);
  }

  /**
   * Sets the animation duration in milliseconds. The animation duration
   * defaults to 0 if this method is never called.
   *
   * @param duration the animation duration in milliseconds.
   */
  void setAnimationDuration(int duration) {
    this._animationDuration = duration;
  }

  /**
   * Sets the message text to be displayed.
   *
   * @param message the text to be displayed.
   */
  void setMessage(String message) {
    notificationText.text = message;
  }

  /**
   * Set the message text and then display the notification.
   */
  void show([String message = null]) {
    if (message != null) {
      setMessage(message);
    }
    //
    ++showAttempts;
    _showImpl();
  }

  /**
   * Display the notification, but after a delay.
   *
   * @param delay delay in milliseconds.
   */
  void showDelayed(int delay) {
    if (showAttempts == 0) {
      if (delay == 0) {
        show();
      } else {
        ++showAttempts;
        showTimer.schedule(delay);
      }
    }
  }

  void _showImpl() {
    borderElement.style.display = Display.BLOCK.value;
    borderElement.style.width = notificationText.offsetWidth.toString().concat(Unit.PX.value);
    _animation.animateMole(0, heightMeasure.offsetHeight, _animationDuration);
  }
}

/**
 * Default CSS styles for this widget.
 */
//abstract class Style extends CssResource {
//  String container();
//
//  String notificationText();
//}

//abstract class Binder extends UiBinder<HTMLPanel, NotificationMole> {
//}

class _MoleAnimation extends Animation {
  int _endSize = 0;
  int _startSize = 0;

  NotificationMole _mole;

  _MoleAnimation(this._mole);

  void onComplete() {
    if (_endSize == 0) {
      _mole.borderElement.style.display = Display.NONE.value;
      return;
    }
    _mole.borderElement.style.height = _endSize.toString().concat(Unit.PX.value);
  }

  void onUpdate(double progress) {
    double delta = (_endSize - _startSize) * progress;
    double newSize = _startSize + delta;
    _mole.borderElement.style.height = newSize.toString().concat(Unit.PX.value);
  }

  void animateMole(int startSize, int endSize, int duration) {
    this._startSize = startSize;
    this._endSize = endSize;
    if (duration == 0) {
      onComplete();
      return;
    }
    run(duration);
  }
}