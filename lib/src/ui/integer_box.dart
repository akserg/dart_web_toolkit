//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A ValueBox that uses {@link IntegerParser} and {@link IntegerRenderer}.
 * Allows only digits: [0..9].
 */
class IntegerBox extends ValueBox<int> {

  // [-+]?[0-9]+
  //static RegExp DIGITS_ONLY = new RegExp(r"(0|-?[1-9][0-9]*)");
  RegExp DIGITS_ONLY = new RegExp(r"^\d+$");
  
  IntegerBox() : super.fromElement(new dart_html.TextInputElement(), new IntegerRenderer.instance(), new IntegerParser.instance()) {
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
        if (DIGITS_ONLY.hasMatch(charCode)) {
        //if (charCode.contains(IntegerBox.DIGITS_ONLY)) {
          return;
        }
  
        cancelKey();
    }));
  }
}