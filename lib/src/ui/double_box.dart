//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A ValueBox that uses {@link DoubleParser} and {@link DoubleRenderer}.
 * Allows only digits: [0..9,'.', ',']
 */
class DoubleBox extends ValueBox<double> {

  // [-+]?[0-9]*\.?[0-9]+
  static RegExp DIGITS_ONLY = new RegExp(r"[-+]?\d*(\.,\,)?d+");
  
  DoubleBox() : super.fromElement(new dart_html.TextInputElement(), new DoubleRenderer.instance(), new DoubleParser.instance()) {
    addKeyPressHandler(new KeyPressHandlerAdapter((KeyPressEvent evt){
      if (isReadOnly || !enabled) {
        return;
      }
  
      int keyCode = evt.getKeyboardEvent().keyCode;
  
      switch (keyCode) {
        case KeyCodes.KEY_LEFT:
        case KeyCodes.KEY_RIGHT:
        case KeyCodes.KEY_BACKSPACE:
        case KeyCodes.KEY_TAB:
        case KeyCodes.KEY_UP:
        case KeyCodes.KEY_DOWN:
          return;
        }
  
        String charCode = new String.fromCharCode(evt.getKeyboardEvent().charCode);
        
        // filter out non-digits
        if (charCode.contains(DoubleBox.DIGITS_ONLY)) {
          return;
        }
  
        cancelKey();
    }));
  }
}
