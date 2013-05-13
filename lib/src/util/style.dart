//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * Enum for the border-style property.
 */
class BorderStyle<String> extends Enum<String> {

  const BorderStyle(String type) : super (type);

  static const BorderStyle NONE = const BorderStyle(Style._BORDER_STYLE_NONE);
  static const BorderStyle DOTTED = const BorderStyle(Style._BORDER_STYLE_DOTTED);
  static const BorderStyle DASHED = const BorderStyle(Style._BORDER_STYLE_DASHED);
  static const BorderStyle HIDDEN = const BorderStyle(Style._BORDER_STYLE_HIDDEN);
  static const BorderStyle SOLID = const BorderStyle(Style._BORDER_STYLE_SOLID);
}

/**
 * Enum for the 'clear' CSS property.
 */
class Clear<String> extends Enum<String> {

  const Clear(String type) : super (type);

  static const Clear BOTH = const Clear(Style._CLEAR_BOTH);
  static const Clear LEFT = const Clear(Style._CLEAR_LEFT);
  static const Clear NONE = const Clear(Style._CLEAR_NONE);
  static const Clear RIGHT = const Clear(Style._CLEAR_RIGHT);
}

/**
 * Enum for the cursor property.
 */
class Cursor<String> extends Enum<String> {

  const Cursor(String type) : super (type);

  static const Cursor DEFAULT = const Cursor(Style._CURSOR_DEFAULT);
  static const Cursor AUTO = const Cursor(Style._CURSOR_AUTO);
  static const Cursor CROSSHAIR = const Cursor(Style._CURSOR_CROSSHAIR);
  static const Cursor POINTER = const Cursor(Style._CURSOR_POINTER);
  static const Cursor MOVE = const Cursor(Style._CURSOR_MOVE);
  static const Cursor E_RESIZE = const Cursor(Style._CURSOR_E_RESIZE);
  static const Cursor NE_RESIZE = const Cursor(Style._CURSOR_NE_RESIZE);
  static const Cursor NW_RESIZE = const Cursor(Style._CURSOR_NW_RESIZE);
  static const Cursor N_RESIZE = const Cursor(Style._CURSOR_N_RESIZE);
  static const Cursor SE_RESIZE = const Cursor(Style._CURSOR_SE_RESIZE);
  static const Cursor SW_RESIZE = const Cursor(Style._CURSOR_SW_RESIZE);
  static const Cursor S_RESIZE = const Cursor(Style._CURSOR_S_RESIZE);
  static const Cursor W_RESIZE = const Cursor(Style._CURSOR_W_RESIZE);
  static const Cursor TEXT = const Cursor(Style._CURSOR_TEXT);
  static const Cursor WAIT = const Cursor(Style._CURSOR_WAIT);
  static const Cursor HELP = const Cursor(Style._CURSOR_HELP);
  static const Cursor COL_RESIZE = const Cursor(Style._CURSOR_COL_RESIZE);
  static const Cursor ROW_RESIZE = const Cursor(Style._CURSOR_ROW_RESIZE);
}

/**
 * Enum for the display property.
 */
class Display<String> extends Enum<String> {

  const Display(String type) : super (type);

  static const Display NONE = const Display(Style._DISPLAY_NONE);
  static const Display BLOCK = const Display(Style._DISPLAY_BLOCK);
  static const Display INLINE = const Display(Style._DISPLAY_INLINE);
  static const Display INLINE_BLOCK = const Display(Style._DISPLAY_INLINE_BLOCK);
}

/**
 * Enum for the float property.
 */
class Float<String> extends Enum<String> {

  const Float(String type) : super (type);

  static const Float LEFT = const Float(Style._FLOAT_LEFT);
  static const Float RIGHT = const Float(Style._FLOAT_RIGHT);
  static const Float NONE = const Float(Style._FLOAT_NONE);
}

/**
 * Enum for the font-style property.
 */
class FontStyle<String> extends Enum<String> {

  const FontStyle(String type) : super (type);

  static const FontStyle NORMAL = const FontStyle(Style._FONT_STYLE_NORMAL);
  static const FontStyle ITALIC = const FontStyle(Style._FONT_STYLE_ITALIC);
  static const FontStyle OBLIQUE = const FontStyle(Style._FONT_STYLE_OBLIQUE);
}

/**
 * Enum for the font-weight property.
 */
class FontWeight<String> extends Enum<String> {

  const FontWeight(String type) : super (type);

  static const FontWeight NORMAL = const FontWeight(Style._FONT_WEIGHT_NORMAL);
  static const FontWeight BOLD = const FontWeight(Style._FONT_WEIGHT_BOLD);
  static const FontWeight BOLDER = const FontWeight(Style._FONT_WEIGHT_BOLDER);
  static const FontWeight LIGHTER = const FontWeight(Style._FONT_WEIGHT_LIGHTER);
}

/**
 * Enum for the list-style-type property.
 */
class ListStyleType<String> extends Enum<String> {

  const ListStyleType(String type) : super (type);

  static const ListStyleType NONE = const ListStyleType(Style._LIST_STYLE_TYPE_NONE);
  static const ListStyleType DISC = const ListStyleType(Style._LIST_STYLE_TYPE_DISC);
  static const ListStyleType CIRCLE = const ListStyleType(Style._LIST_STYLE_TYPE_CIRCLE);
  static const ListStyleType SQUARE = const ListStyleType(Style._LIST_STYLE_TYPE_SQUARE);
  static const ListStyleType DECIMAL = const ListStyleType(Style._LIST_STYLE_TYPE_DECIMAL);
  static const ListStyleType LOWER_ALPHA = const ListStyleType(Style._LIST_STYLE_TYPE_LOWER_ALPHA);
  static const ListStyleType UPPER_ALPHA = const ListStyleType(Style._LIST_STYLE_TYPE_UPPER_ALPHA);
  static const ListStyleType LOWER_ROMAN = const ListStyleType(Style._LIST_STYLE_TYPE_LOWER_ROMAN);
  static const ListStyleType UPPER_ROMAN = const ListStyleType(Style._LIST_STYLE_TYPE_UPPER_ROMAN);
}

/**
 * Enum for the overflow property.
 */
class Overflow<String> extends Enum<String> {

  const Overflow(String type) : super (type);

  static const Overflow VISIBLE = const Overflow(Style._OVERFLOW_VISIBLE);
  static const Overflow HIDDEN = const Overflow(Style._OVERFLOW_HIDDEN);
  static const Overflow SCROLL = const Overflow(Style._OVERFLOW_SCROLL);
  static const Overflow AUTO = const Overflow(Style._OVERFLOW_AUTO);
}

/**
 * Enum for the outline-style property.
 */
class OutlineStyle<String> extends Enum<String> {

  const OutlineStyle(String type) : super (type);

  static const OutlineStyle NONE = const OutlineStyle(Style._OUTLINE_STYLE_NONE);
  static const OutlineStyle DASHED = const OutlineStyle(Style._OUTLINE_STYLE_DASHED);
  static const OutlineStyle DOTTED = const OutlineStyle(Style._OUTLINE_STYLE_DOTTED);
  static const OutlineStyle DOUBLE = const OutlineStyle(Style._OUTLINE_STYLE_DOUBLE);
  static const OutlineStyle GROOVE = const OutlineStyle(Style._OUTLINE_STYLE_GROOVE);
  static const OutlineStyle INSET = const OutlineStyle(Style._OUTLINE_STYLE_INSET);
  static const OutlineStyle OUTSET = const OutlineStyle(Style._OUTLINE_STYLE_OUTSET);
  static const OutlineStyle RIDGE = const OutlineStyle(Style._OUTLINE_STYLE_RIDGE);
  static const OutlineStyle SOLID = const OutlineStyle(Style._OUTLINE_STYLE_SOLID);
}

/**
 * Enum for the position property.
 */
class Position<String> extends Enum<String> {

  const Position(String type) : super (type);

  static const Position STATIC = const Position(Style._POSITION_STATIC);
  static const Position RELATIVE = const Position(Style._POSITION_RELATIVE);
  static const Position ABSOLUTE = const Position(Style._POSITION_ABSOLUTE);
  static const Position FIXED = const Position(Style._POSITION_FIXED);
}

/**
 * Enum for the table-layout property.
 */
class TableLayout<String> extends Enum<String> {

  const TableLayout(String type) : super (type);

  static const TableLayout AUTO = const TableLayout(Style._TABLE_LAYOUT_AUTO);
  static const TableLayout FIXED = const TableLayout(Style._TABLE_LAYOUT_FIXED);
}

/**
 * Enum for the 'text-decoration' CSS property.
 */
class TextDecoration<String> extends Enum<String> {

  const TextDecoration(String type) : super (type);

  static const TextDecoration BLINK = const TextDecoration(Style._TEXT_DECORATION_BLINK);
  static const TextDecoration LINE_THROUGH = const TextDecoration(Style._TEXT_DECORATION_LINE_THROUGH);
  static const TextDecoration NONE = const TextDecoration(Style._TEXT_DECORATION_NONE);
  static const TextDecoration OVERLINE = const TextDecoration(Style._TEXT_DECORATION_OVERLINE);
  static const TextDecoration UNDERLINE = const TextDecoration(Style._TEXT_DECORATION_UNDERLINE);
}

/**
 * Enum for the 'text-justify' CSS3 property.
 */
class TextJustify<String> extends Enum<String> {

  const TextJustify(String type) : super (type);

  static const TextJustify AUTO = const TextJustify(Style._TEXT_JUSTIFY_AUTO);
  static const TextJustify DISTRIBUTE = const TextJustify(Style._TEXT_JUSTIFY_DISTRIBUTE);
  static const TextJustify INTER_CLUSTER = const TextJustify(Style._TEXT_JUSTIFY_INTER_CLUSTER);
  static const TextJustify INTER_IDEOGRAPH = const TextJustify(Style._TEXT_JUSTIFY_INTER_IDEOGRAPH);
  static const TextJustify INTER_WORD = const TextJustify(Style._TEXT_JUSTIFY_INTER_WORD);
  static const TextJustify KASHIDA = const TextJustify(Style._TEXT_JUSTIFY_KASHIDA);
  static const TextJustify NONE = const TextJustify(Style._TEXT_JUSTIFY_NONE);
}

/**
 * Enum for the 'text-overflow' CSS3 property.
 */
class TextOverflow<String> extends Enum<String> {

  const TextOverflow(String type) : super (type);

  static const TextOverflow CLIP = const TextOverflow(Style._TEXT_OVERFLOW_CLIP);
  static const TextOverflow ELLIPSIS = const TextOverflow(Style._TEXT_OVERFLOW_ELLIPSIS);
}

/**
 * Enum for the 'text-transform' CSS property.
 */
class TextTransform<String> extends Enum<String> {

  const TextTransform(String type) : super (type);

  static const TextTransform CAPITALIZE = const TextTransform(Style._TEXT_TRANSFORM_CAPITALIZE);
  static const TextTransform NONE = const TextTransform(Style._TEXT_TRANSFORM_NONE);
  static const TextTransform LOWERCASE = const TextTransform(Style._TEXT_TRANSFORM_LOWERCASE);
  static const TextTransform UPPERCASE = const TextTransform(Style._TEXT_TRANSFORM_UPPERCASE);
}

/**
 * CSS length units.
 */
class Unit<String> extends Enum<String> {

  const Unit(String type) : super (type);

  static const Unit PX = const Unit(Style._UNIT_PX);
  static const Unit PCT = const Unit(Style._UNIT_PCT);
  static const Unit EM = const Unit(Style._UNIT_EM);
  static const Unit EX = const Unit(Style._UNIT_EX);
  static const Unit PT = const Unit(Style._UNIT_PT);
  static const Unit PC = const Unit(Style._UNIT_PC);
  static const Unit IN = const Unit(Style._UNIT_IN);
  static const Unit CM = const Unit(Style._UNIT_CM);
  static const Unit MM = const Unit(Style._UNIT_MM);
}

/**
 * Enum for the 'white-space' CSS property.
 */
class WhiteSpace<String> extends Enum<String> {

  const WhiteSpace(String type) : super (type);

  static const WhiteSpace NORMAL = const WhiteSpace(Style._WHITE_SPACE_NORMAL);
  static const WhiteSpace NOWRAP = const WhiteSpace(Style._WHITE_SPACE_NOWRAP);
  static const WhiteSpace PRE = const WhiteSpace(Style._WHITE_SPACE_PRE);
  static const WhiteSpace PRE_LINE = const WhiteSpace(Style._WHITE_SPACE_PRE_LINE);
  static const WhiteSpace PRE_WRAP = const WhiteSpace(Style._WHITE_SPACE_PRE_WRAP);
}

/**
 * Enum for the text-align property.
 */
class TextAlign<String> extends Enum<String> {

  const TextAlign(String type) : super (type);

  static const TextAlign CENTER = const TextAlign(Style._TEXT_ALIGN_CENTER);
  static const TextAlign JUSTIFY = const TextAlign(Style._TEXT_ALIGN_JUSTIFY);
  static const TextAlign LEFT = const TextAlign(Style._TEXT_ALIGN_LEFT);
  static const TextAlign RIGHT = const TextAlign(Style._TEXT_ALIGN_RIGHT);
}

/**
 * Enum for the vertical-align property.
 */
class VerticalAlign<String> extends Enum<String> {

  const VerticalAlign(String type) : super (type);

  static const VerticalAlign BASELINE = const VerticalAlign(Style._VERTICAL_ALIGN_BASELINE);
  static const VerticalAlign SUB = const VerticalAlign(Style._VERTICAL_ALIGN_SUB);
  static const VerticalAlign SUPER = const VerticalAlign(Style._VERTICAL_ALIGN_SUPER);
  static const VerticalAlign TOP = const VerticalAlign(Style._VERTICAL_ALIGN_TEXT_TOP);
  static const VerticalAlign TEXT_TOP = const VerticalAlign(Style._VERTICAL_ALIGN_BASELINE);
  static const VerticalAlign MIDDLE = const VerticalAlign(Style._VERTICAL_ALIGN_MIDDLE);
  static const VerticalAlign BOTTOM = const VerticalAlign(Style._VERTICAL_ALIGN_BOTTOM);
  static const VerticalAlign TEXT_BOTTOM = const VerticalAlign(Style._VERTICAL_ALIGN_TEXT_BOTTOM);
}

/**
 * Enum for the visibility property.
 */
class Visibility<String> extends Enum<String> {
  
  const Visibility(String type) : super (type);

  static const Visibility VISIBLE = const Visibility(Style._VISIBILITY_VISIBLE);
  static const Visibility HIDDEN = const Visibility(Style._VISIBILITY_HIDDEN);
}

class Style {
  
  static const String _BORDER_STYLE_SOLID = "solid";
  static const String _BORDER_STYLE_DASHED = "dashed";
  static const String _BORDER_STYLE_DOTTED = "dotted";
  static const String _BORDER_STYLE_HIDDEN = "hidden";
  static const String _BORDER_STYLE_NONE = "none";
  
  static const String _CLEAR_BOTH = "both";
  static const String _CLEAR_LEFT = "left";
  static const String _CLEAR_NONE = "none";
  static const String _CLEAR_RIGHT = "right";

  static const String _CURSOR_ROW_RESIZE = "row-resize";
  static const String _CURSOR_COL_RESIZE = "col-resize";
  static const String _CURSOR_HELP = "help";
  static const String _CURSOR_WAIT = "wait";
  static const String _CURSOR_TEXT = "text";
  static const String _CURSOR_W_RESIZE = "w-resize";
  static const String _CURSOR_S_RESIZE = "s-resize";
  static const String _CURSOR_SW_RESIZE = "sw-resize";
  static const String _CURSOR_SE_RESIZE = "se-resize";
  static const String _CURSOR_N_RESIZE = "n-resize";
  static const String _CURSOR_NW_RESIZE = "nw-resize";
  static const String _CURSOR_NE_RESIZE = "ne-resize";
  static const String _CURSOR_E_RESIZE = "e-resize";
  static const String _CURSOR_MOVE = "move";
  static const String _CURSOR_POINTER = "pointer";
  static const String _CURSOR_CROSSHAIR = "crosshair";
  static const String _CURSOR_AUTO = "auto";
  static const String _CURSOR_DEFAULT = "default";

  static const String _DISPLAY_INLINE_BLOCK = "inline-block";
  static const String _DISPLAY_INLINE = "inline";
  static const String _DISPLAY_BLOCK = "block";
  static const String _DISPLAY_NONE = "none";

  static const String _FLOAT_LEFT = "left";
  static const String _FLOAT_RIGHT = "right";
  static const String _FLOAT_NONE = "none";

  static const String _FONT_STYLE_OBLIQUE = "oblique";
  static const String _FONT_STYLE_ITALIC = "italic";
  static const String _FONT_STYLE_NORMAL = "normal";

  static const String _FONT_WEIGHT_LIGHTER = "lighter";
  static const String _FONT_WEIGHT_BOLDER = "bolder";
  static const String _FONT_WEIGHT_BOLD = "bold";
  static const String _FONT_WEIGHT_NORMAL = "normal";

  static const String _LIST_STYLE_TYPE_UPPER_ROMAN = "upper-roman";
  static const String _LIST_STYLE_TYPE_LOWER_ROMAN = "lower-roman";
  static const String _LIST_STYLE_TYPE_UPPER_ALPHA = "upper-alpha";
  static const String _LIST_STYLE_TYPE_LOWER_ALPHA = "lower-alpha";
  static const String _LIST_STYLE_TYPE_DECIMAL = "decimal";
  static const String _LIST_STYLE_TYPE_SQUARE = "square";
  static const String _LIST_STYLE_TYPE_CIRCLE = "circle";
  static const String _LIST_STYLE_TYPE_DISC = "disc";
  static const String _LIST_STYLE_TYPE_NONE = "none";

  static const String _OUTLINE_STYLE_DASHED = "dashed";
  static const String _OUTLINE_STYLE_DOTTED = "dotted";
  static const String _OUTLINE_STYLE_DOUBLE = "double";
  static const String _OUTLINE_STYLE_GROOVE = "groove";
  static const String _OUTLINE_STYLE_INSET = "inset";
  static const String _OUTLINE_STYLE_NONE = "none";
  static const String _OUTLINE_STYLE_OUTSET = "outset";
  static const String _OUTLINE_STYLE_RIDGE = "ridge";
  static const String _OUTLINE_STYLE_SOLID = "solid";
  
  static const String _OVERFLOW_AUTO = "auto";
  static const String _OVERFLOW_SCROLL = "scroll";
  static const String _OVERFLOW_HIDDEN = "hidden";
  static const String _OVERFLOW_VISIBLE = "visible";

  static const String _POSITION_FIXED = "fixed";
  static const String _POSITION_ABSOLUTE = "absolute";
  static const String _POSITION_RELATIVE = "relative";
  static const String _POSITION_STATIC = "static const";

  static const String _STYLE_Z_INDEX = "zIndex";
  static const String _STYLE_WIDTH = "width";
  static const String _STYLE_VISIBILITY = "visibility";
  static const String _STYLE_TOP = "top";
  static const String _STYLE_TEXT_DECORATION = "textDecoration";
  static const String _STYLE_RIGHT = "right";
  static const String _STYLE_POSITION = "position";
  static const String _STYLE_PADDING_TOP = "paddingTop";
  static const String _STYLE_PADDING_RIGHT = "paddingRight";
  static const String _STYLE_PADDING_LEFT = "paddingLeft";
  static const String _STYLE_PADDING_BOTTOM = "paddingBottom";
  static const String _STYLE_PADDING = "padding";
  static const String _STYLE_OVERFLOW = "overflow";
  static const String _STYLE_OVERFLOW_X = "overflowX";
  static const String _STYLE_OVERFLOW_Y = "overflowY";
  static const String _STYLE_OPACITY = "opacity";
  static const String _STYLE_MARGIN_TOP = "marginTop";
  static const String _STYLE_MARGIN_RIGHT = "marginRight";
  static const String _STYLE_MARGIN_LEFT = "marginLeft";
  static const String _STYLE_MARGIN_BOTTOM = "marginBottom";
  static const String _STYLE_MARGIN = "margin";
  static const String _STYLE_LIST_STYLE_TYPE = "listStyleType";
  static const String _STYLE_LEFT = "left";
  static const String _STYLE_HEIGHT = "height";
  static const String _STYLE_FONT_WEIGHT = "fontWeight";
  static const String _STYLE_FONT_STYLE = "fontStyle";
  static const String _STYLE_FONT_SIZE = "fontSize";
  static const String _STYLE_DISPLAY = "display";
  static const String _STYLE_CURSOR = "cursor";
  static const String _STYLE_COLOR = "color";
  static const String _STYLE_CLEAR = "clear";
  static const String _STYLE_BOTTOM = "bottom";
  static const String _STYLE_BORDER_WIDTH = "borderWidth";
  static const String _STYLE_BORDER_STYLE = "borderStyle";
  static const String _STYLE_BORDER_COLOR = "borderColor";
  static const String _STYLE_BACKGROUND_IMAGE = "backgroundImage";
  static const String _STYLE_BACKGROUND_COLOR = "backgroundColor";
  static const String _STYLE_VERTICAL_ALIGN = "verticalAlign";
  static const String _STYLE_TABLE_LAYOUT = "tableLayout";
  static const String _STYLE_TEXT_ALIGN = "textAlign";
  static const String _STYLE_TEXT_INDENT = "textIndent";
  static const String _STYLE_TEXT_JUSTIFY = "textJustify";
  static const String _STYLE_TEXT_OVERFLOW = "textOverflow";
  static const String _STYLE_TEXT_TRANSFORM = "textTransform";
  static const String _STYLE_OUTLINE_WIDTH = "outlineWidth";
  static const String _STYLE_OUTLINE_STYLE = "outlineStyle";
  static const String _STYLE_OUTLINE_COLOR = "outlineColor";
  static const String _STYLE_LINE_HEIGHT = "lineHeight";
  static const String _STYLE_WHITE_SPACE = "whiteSpace";
  
  static const String _TABLE_LAYOUT_AUTO = "auto";
  static const String _TABLE_LAYOUT_FIXED = "fixed";
  
  static const String _TEXT_ALIGN_CENTER = "center";
  static const String _TEXT_ALIGN_JUSTIFY = "justify";
  static const String _TEXT_ALIGN_LEFT = "left";
  static const String _TEXT_ALIGN_RIGHT = "right";

  static const String _TEXT_DECORATION_BLINK = "blink";
  static const String _TEXT_DECORATION_LINE_THROUGH = "line-through";
  static const String _TEXT_DECORATION_NONE = "none";
  static const String _TEXT_DECORATION_OVERLINE = "overline";
  static const String _TEXT_DECORATION_UNDERLINE = "underline";
  
  static const String _TEXT_JUSTIFY_AUTO = "auto";
  static const String _TEXT_JUSTIFY_DISTRIBUTE = "distribute";
  static const String _TEXT_JUSTIFY_INTER_CLUSTER = "inter-cluster";
  static const String _TEXT_JUSTIFY_INTER_IDEOGRAPH = "inter-ideograph";
  static const String _TEXT_JUSTIFY_INTER_WORD = "inter-word";
  static const String _TEXT_JUSTIFY_KASHIDA = "kashida";
  static const String _TEXT_JUSTIFY_NONE = "none";
  
  static const String _TEXT_OVERFLOW_CLIP = "clip";
  static const String _TEXT_OVERFLOW_ELLIPSIS = "ellipsis";

  static const String _TEXT_TRANSFORM_CAPITALIZE = "capitalize";
  static const String _TEXT_TRANSFORM_NONE = "none";
  static const String _TEXT_TRANSFORM_LOWERCASE = "lowercase";
  static const String _TEXT_TRANSFORM_UPPERCASE = "uppercase";
  
  static const String _UNIT_MM = "mm";
  static const String _UNIT_CM = "cm";
  static const String _UNIT_IN = "in";
  static const String _UNIT_PC = "pc";
  static const String _UNIT_PT = "pt";
  static const String _UNIT_EX = "ex";
  static const String _UNIT_EM = "em";
  static const String _UNIT_PCT = "%";
  static const String _UNIT_PX = "px";
  
  static const String _VERTICAL_ALIGN_BASELINE = "baseline";
  static const String _VERTICAL_ALIGN_SUB = "sub";
  static const String _VERTICAL_ALIGN_SUPER = "super";
  static const String _VERTICAL_ALIGN_TOP = "top";
  static const String _VERTICAL_ALIGN_TEXT_TOP = "text-top";
  static const String _VERTICAL_ALIGN_MIDDLE = "middle";
  static const String _VERTICAL_ALIGN_BOTTOM = "bottom";
  static const String _VERTICAL_ALIGN_TEXT_BOTTOM = "text-bottom";

  static const String _VISIBILITY_HIDDEN = "hidden";
  static const String _VISIBILITY_VISIBLE = "visible";
  
  static const String _WHITE_SPACE_NORMAL = "normal";
  static const String _WHITE_SPACE_NOWRAP = "nowrap";
  static const String _WHITE_SPACE_PRE = "pre";
  static const String _WHITE_SPACE_PRE_LINE = "pre-line";
  static const String _WHITE_SPACE_PRE_WRAP = "pre-wrap";
  
  dart_html.Element _el;
  
  void setElement(dart_html.Element el) {
    this._el = el;
  }
  
  /**
   * Clear the background-color css property.
   */
  void clearBackgroundColor() {
     clearProperty(_STYLE_BACKGROUND_COLOR);
  }

  /**
   * Clear the background-image css property.
   */
  void clearBackgroundImage() {
     clearProperty(_STYLE_BACKGROUND_IMAGE);
  }

  /**
   * Clear the border-color css property.
   */
  void clearBorderColor() {
     clearProperty(_STYLE_BORDER_COLOR);
  }

  /**
   * Clears the border-style CSS property.
   */
  void clearBorderStyle() {
    clearProperty(_STYLE_BORDER_STYLE);
  }

  /**
   * Clear the border-width css property.
   */
  void clearBorderWidth() {
     clearProperty(_STYLE_BORDER_WIDTH);
  }

  /**
   * Clear the bottom css property.
   */
  void clearBottom() {
     clearProperty(_STYLE_BOTTOM);
  }

  /**
   * Clear the 'clear' CSS property.
   */
  void clearClear() {
     clearProperty(_STYLE_CLEAR);
  }

  /**
   * Clear the color css property.
   */
  void clearColor() {
     clearProperty(_STYLE_COLOR);
  }

  /**
   * Clears the cursor CSS property.
   */
  void clearCursor() {
    clearProperty(_STYLE_CURSOR);
  }

  /**
   * Clears the display CSS property.
   */
  void clearDisplay() {
    clearProperty(_STYLE_DISPLAY);
  }

  /**
   * Clear the float css property.
   */
  void clearFloat() {
    clearProperty(event.Dom.cssFloatPropertyName());
  }

  /**
   * Clear the font-size css property.
   */
  void clearFontSize() {
    clearProperty(_STYLE_FONT_SIZE);
  }

  /**
   * Clears the font-style CSS property.
   */
  void clearFontStyle() {
    clearProperty(_STYLE_FONT_STYLE);
  }

  /**
   * Clears the font-weight CSS property.
   */
  void clearFontWeight() {
    clearProperty(_STYLE_FONT_WEIGHT);
  }

  /**
   * Clear the height css property.
   */
  void clearHeight() {
     clearProperty(_STYLE_HEIGHT);
  }

  /**
   * Clear the left css property.
   */
  void clearLeft() {
     clearProperty(_STYLE_LEFT);
  }

  /**
   * Clear the line-height css property.
   */
  void clearLineHeight() {
     clearProperty(_STYLE_LINE_HEIGHT);
  }

  /**
   * Clears the list-style-type CSS property.
   */
  void clearListStyleType() {
    clearProperty(_STYLE_LIST_STYLE_TYPE);
  }

  /**
   * Clear the margin css property.
   */
  void clearMargin() {
     clearProperty(_STYLE_MARGIN);
  }

  /**
   * Clear the margin-bottom css property.
   */
  void clearMarginBottom() {
     clearProperty(_STYLE_MARGIN_BOTTOM);
  }

  /**
   * Clear the margin-left css property.
   */
  void clearMarginLeft() {
     clearProperty(_STYLE_MARGIN_LEFT);
  }

  /**
   * Clear the margin-right css property.
   */
  void clearMarginRight() {
     clearProperty(_STYLE_MARGIN_RIGHT);
  }

  /**
   * Clear the margin-top css property.
   */
  void clearMarginTop() {
     clearProperty(_STYLE_MARGIN_TOP);
  }

  /**
   * Clear the opacity css property.
   */
  void clearOpacity() {
    event.Dom.cssClearOpacity(_el);
  }

  /**
   * Clear the outline-color css property.
   */
  void clearOutlineColor() {
     clearProperty(_STYLE_OUTLINE_COLOR);
  }

  /**
   * Clears the outline-style CSS property.
   */
  void clearOutlineStyle() {
    clearProperty(_STYLE_OUTLINE_STYLE);
  }

  /**
   * Clear the outline-width css property.
   */
  void clearOutlineWidth() {
     clearProperty(_STYLE_OUTLINE_WIDTH);
  }

  /**
   * Clears the overflow CSS property.
   */
  void clearOverflow() {
    clearProperty(_STYLE_OVERFLOW);
  }

  /**
   * Clears the overflow-x CSS property.
   */
  void clearOverflowX() {
    clearProperty(_STYLE_OVERFLOW_X);
  }
  
  /**
   * Clears the overflow-y CSS property.
   */
  void clearOverflowY() {
    clearProperty(_STYLE_OVERFLOW_Y);
  }
  
  /**
   * Clear the padding css property.
   */
  void clearPadding() {
     clearProperty(_STYLE_PADDING);
  }

  /**
   * Clear the padding-bottom css property.
   */
  void clearPaddingBottom() {
     clearProperty(_STYLE_PADDING_BOTTOM);
  }

  /**
   * Clear the padding-left css property.
   */
  void clearPaddingLeft() {
     clearProperty(_STYLE_PADDING_LEFT);
  }

  /**
   * Clear the padding-right css property.
   */
  void clearPaddingRight() {
     clearProperty(_STYLE_PADDING_RIGHT);
  }

  /**
   * Clear the padding-top css property.
   */
  void clearPaddingTop() {
     clearProperty(_STYLE_PADDING_TOP);
  }

  /**
   * Clears the position CSS property.
   */
  void clearPosition() {
    clearProperty(_STYLE_POSITION);
  }

  /**
   * Clears the value of a named property, causing it to revert to its default.
   */
  void clearProperty(String name) {
    setProperty(name, "");
  }

  /**
   * Clear the right css property.
   */
  void clearRight() {
     clearProperty(_STYLE_RIGHT);
  }

  /**
   * Clear the table-layout css property.
   */
  void clearTableLayout() {
    clearProperty(_STYLE_TABLE_LAYOUT);
  }

  /**
   * Clear the 'text-align' CSS property.
   */
  void clearTextAlign() {
    clearProperty(_STYLE_TEXT_ALIGN);
  }

  /**
   * Clears the text-decoration CSS property.
   */
  void clearTextDecoration() {
    clearProperty(_STYLE_TEXT_DECORATION);
  }
  
  /**
   * Clear the 'text-indent' CSS property.
   */
  void clearTextIndent() {
    clearProperty(_STYLE_TEXT_INDENT);
  }
  
  /**
   * Clear the 'text-justify' CSS3 property.
   */
  void clearTextJustify() {
    clearProperty(_STYLE_TEXT_JUSTIFY);
  }
  
  /**
   * Clear the 'text-overflow' CSS3 property.
   */
  void clearTextOverflow() {
    clearProperty(_STYLE_TEXT_OVERFLOW);
  }
  
  /**
   * Clear the 'text-transform' CSS property.
   */
  void clearTextTransform() {
    clearProperty(_STYLE_TEXT_TRANSFORM);
  }

  /**
   * Clear the top css property.
   */
  void clearTop() {
     clearProperty(_STYLE_TOP);
  }

  /**
   * Clears the visibility CSS property.
   */
  void clearVisibility() {
    clearProperty(_STYLE_VISIBILITY);
  }

  /**
   * Clear the 'white-space' CSS property.
   */
  void clearWhiteSpace() {
    clearProperty(_STYLE_WHITE_SPACE);
  }

  /**
   * Clear the width css property.
   */
  void clearWidth() {
     clearProperty(_STYLE_WIDTH);
  }

  /**
   * Clear the z-index css property.
   */
  void clearZIndex() {
     clearProperty(_STYLE_Z_INDEX);
  }

  /**
   * Get the background-color css property.
   */
  String getBackgroundColor() {
    return getProperty(_STYLE_BACKGROUND_COLOR);
  }

  /**
   * Get the background-image css property.
   */
  String getBackgroundImage() {
    return getProperty(_STYLE_BACKGROUND_IMAGE);
  }

  /**
   * Get the border-color css property.
   */
  String getBorderColor() {
    return getProperty(_STYLE_BORDER_COLOR);
  }

  /**
   * Gets the border-style CSS property.
   */
  String getBorderStyle() {
    return getProperty(_STYLE_BORDER_STYLE);
  }

  /**
   * Get the border-width css property.
   */
  String getBorderWidth() {
    return getProperty(_STYLE_BORDER_WIDTH);
  }

  /**
   * Get the bottom css property.
   */
  String getBottom() {
    return getProperty(_STYLE_BOTTOM);
  }

  /**
   * Get the 'clear' CSS property.
   */
  String getClear() {
    return getProperty(_STYLE_CLEAR);
  }

  /**
   * Get the color css property.
   */
  String getColor() {
    return getProperty(_STYLE_COLOR);
  }

  /**
   * Gets the cursor CSS property.
   */
  String getCursor() {
    return getProperty(_STYLE_CURSOR);
  }

  /**
   * Gets the display CSS property.
   */
  String getDisplay() {
    return getProperty(_STYLE_DISPLAY);
  }

  /**
   * Get the font-size css property.
   */
  String getFontSize() {
    return getProperty(_STYLE_FONT_SIZE);
  }

  /**
   * Gets the font-style CSS property.
   */
  String getFontStyle() {
    return getProperty(_STYLE_FONT_STYLE);
  }

  /**
   * Gets the font-weight CSS property.
   */
  String getFontWeight() {
    return getProperty(_STYLE_FONT_WEIGHT);
  }

  /**
   * Get the height css property.
   */
  String getHeight() {
    return getProperty(_STYLE_HEIGHT);
  }

  /**
   * Get the left css property.
   */
  String getLeft() {
    return getProperty(_STYLE_LEFT);
  }

  /**
   * Get the line-height css property.
   */
  String getLineHeight() {
    return getProperty(_STYLE_LINE_HEIGHT);
  }

  /**
   * Gets the list-style-type CSS property.
   */
  String getListStyleType() {
    return getProperty(_STYLE_LIST_STYLE_TYPE);
  }

  /**
   * Get the margin css property.
   */
  String getMargin() {
    return getProperty(_STYLE_MARGIN);
  }

  /**
   * Get the margin-bottom css property.
   */
  String getMarginBottom() {
    return getProperty(_STYLE_MARGIN_BOTTOM);
  }

  /**
   * Get the margin-left css property.
   */
  String getMarginLeft() {
    return getProperty(_STYLE_MARGIN_LEFT);
  }

  /**
   * Get the margin-right css property.
   */
  String getMarginRight() {
    return getProperty(_STYLE_MARGIN_RIGHT);
  }

  /**
   * Get the margin-top css property.
   */
  String getMarginTop() {
    return getProperty(_STYLE_MARGIN_TOP);
  }

  /**
   * Get the opacity css property.
   */
  String getOpacity() {
    return getProperty(_STYLE_OPACITY);
  }

  /**
   * Gets the overflow CSS property.
   */
  String getOverflow() {
    return getProperty(_STYLE_OVERFLOW);
  }

  /**
   * Gets the overflow-x CSS property. 
   */
  String getOverflowX() {
    return getProperty(_STYLE_OVERFLOW_X);
  }

  /**
   * Gets the overflow-y CSS property. 
   */
  String getOverflowY() {
    return getProperty(_STYLE_OVERFLOW_Y);
  }

  /**
   * Get the padding css property.
   */
  String getPadding() {
    return getProperty(_STYLE_PADDING);
  }

  /**
   * Get the padding-bottom css property.
   */
  String getPaddingBottom() {
    return getProperty(_STYLE_PADDING_BOTTOM);
  }

  /**
   * Get the padding-left css property.
   */
  String getPaddingLeft() {
    return getProperty(_STYLE_PADDING_LEFT);
  }

  /**
   * Get the padding-right css property.
   */
  String getPaddingRight() {
    return getProperty(_STYLE_PADDING_RIGHT);
  }

  /**
   * Get the padding-top css property.
   */
  String getPaddingTop() {
    return getProperty(_STYLE_PADDING_TOP);
  }

  /**
   * Gets the position CSS property.
   */
  String getPosition() {
    return getProperty(_STYLE_POSITION);
  }

  /**
   * Gets the value of a named property.
   */
  String getProperty(String name) {
    _assertCamelCase(name);
    return _getPropertyImpl(name);
  }

  /**
   * Get the right css property.
   */
  String getRight() {
    return getProperty(_STYLE_RIGHT);
  }

  /**
   * Gets the table-layout property.
   */
  String getTableLayout() {
    return getProperty(_STYLE_TABLE_LAYOUT);
  }

  /**
   * Get the 'text-align' CSS property.
   */
  String getTextAlign() {
    return getProperty(_STYLE_TEXT_ALIGN);
  }

  /**
   * Gets the text-decoration CSS property.
   */
  String getTextDecoration() {
    return getProperty(_STYLE_TEXT_DECORATION);
  }
  
  /**
   * Get the 'text-indent' CSS property.
   */
  String getTextIndent() {
    return getProperty(_STYLE_TEXT_INDENT);
  }
  
  /**
   * Get the 'text-justify' CSS3 property.
   */
  String getTextJustify() {
    return getProperty(_STYLE_TEXT_JUSTIFY);
  }

  /**
   * Get the 'text-overflow' CSS3 property.
   */
  String getTextOverflow() {
    return getProperty(_STYLE_TEXT_OVERFLOW);
  }

  /**
   * Get the 'text-transform' CSS property.
   */
  String getTextTransform() {
    return getProperty(_STYLE_TEXT_TRANSFORM);
  }

  /**
   * Get the top css property.
   */
  String getTop() {
    return getProperty(_STYLE_TOP);
  }

  /**
   * Gets the vertical-align CSS property.
   */
  String getVerticalAlign() {
    return getProperty(_STYLE_VERTICAL_ALIGN);
  }

  /**
   * Gets the visibility CSS property.
   */
  String getVisibility() {
    return getProperty(_STYLE_VISIBILITY);
  }

  /**
   * Get the 'white-space' CSS property.
   */
  String getWhiteSpace() {
    return getProperty(_STYLE_WHITE_SPACE);
  }

  /**
   * Get the width css property.
   */
  String getWidth() {
    return getProperty(_STYLE_WIDTH);
  }

  /**
   * Get the z-index css property.
   */
  String getZIndex() {
    return event.Dom.getStyleProperty(_el, _STYLE_Z_INDEX);
  }

  /**
   * Set the background-color css property.
   */
  void setBackgroundColor(String value) {
    setProperty(_STYLE_BACKGROUND_COLOR, value);
  }

  /**
   * Set the background-image css property.
   */
  void setBackgroundImage(String value) {
    setProperty(_STYLE_BACKGROUND_IMAGE, value);
  }

  /**
   * Set the border-color css property.
   */
  void setBorderColor(String value) {
    setProperty(_STYLE_BORDER_COLOR, value);
  }

  /**
   * Sets the border-style CSS property.
   */
  void setBorderStyle(BorderStyle value) {
    setProperty(_STYLE_BORDER_STYLE, value.value);
  }

  /**
   * Set the border-width css property.
   */
  void setBorderWidth(double value, Unit unit) {
    setProperty(_STYLE_BORDER_WIDTH, value, unit);
  }

  /**
   * Set the bottom css property.
   */
  void setBottom(double value, Unit unit) {
    setProperty(_STYLE_BOTTOM, value, unit);
  }

  /**
   * Sets the 'clear' CSS property.
   */
  void setClear(Clear value) {
    setProperty(_STYLE_CLEAR, value.value);
  }

  /**
   * Sets the color CSS property.
   */
  void setColor(String value) {
    setProperty(_STYLE_COLOR, value);
  }

  /**
   * Sets the cursor CSS property.
   */
  void setCursor(Cursor value) {
    setProperty(_STYLE_CURSOR, value.value);
  }

  /**
   * Sets the display CSS property.
   */
  void setDisplay(Display value) {
    setProperty(_STYLE_DISPLAY, value.value);
  }

  /**
   * Set the float css property.
   */
  void setFloat(Float value) {
    setProperty(event.Dom.cssFloatPropertyName(), value.value);
  }

  /**
   * Set the font-size css property.
   */
  void setFontSize(double value, Unit unit) {
    setProperty(_STYLE_FONT_SIZE, value, unit);
  }

  /**
   * Sets the font-style CSS property.
   */
  void setFontStyle(FontStyle value) {
    setProperty(_STYLE_FONT_STYLE, value.value);
  }

  /**
   * Sets the font-weight CSS property.
   */
  void setFontWeight(FontWeight value) {
    setProperty(_STYLE_FONT_WEIGHT, value.value);
  }

  /**
   * Set the height css property.
   */
  void setHeight(double value, Unit unit) {
    setProperty(_STYLE_HEIGHT, value, unit);
  }

  /**
   * Set the left css property.
   */
  void setLeft(double value, Unit unit) {
    setProperty(_STYLE_LEFT, value, unit);
  }

  /**
   * Set the line-height css property.
   */
  void setLineHeight(double value, Unit unit) {
    setProperty(_STYLE_LINE_HEIGHT, value, unit);
  }

  /**
   * Sets the list-style-type CSS property.
   */
  void setListStyleType(ListStyleType value) {
    setProperty(_STYLE_LIST_STYLE_TYPE, value.value);
  }

  /**
   * Set the margin css property.
   */
  void setMargin(double value, Unit unit) {
    setProperty(_STYLE_MARGIN, value, unit);
  }

  /**
   * Set the margin-bottom css property.
   */
  void setMarginBottom(double value, Unit unit) {
    setProperty(_STYLE_MARGIN_BOTTOM, value, unit);
  }

  /**
   * Set the margin-left css property.
   */
  void setMarginLeft(double value, Unit unit) {
    setProperty(_STYLE_MARGIN_LEFT, value, unit);
  }

  /**
   * Set the margin-right css property.
   */
  void setMarginRight(double value, Unit unit) {
    setProperty(_STYLE_MARGIN_RIGHT, value, unit);
  }

  /**
   * Set the margin-top css property.
   */
  void setMarginTop(double value, Unit unit) {
    setProperty(_STYLE_MARGIN_TOP, value, unit);
  }

  /**
   * Set the opacity css property.
   */
  void setOpacity(double value) {
    event.Dom.cssSetOpacity(_el, value);
  }

  /**
   * Set the outline-color css property.
   */
  void setOutlineColor(String value) {
    setProperty(_STYLE_OUTLINE_COLOR, value);
  }

  /**
   * Sets the outline-style CSS property.
   */
  void setOutlineStyle(OutlineStyle value) {
    setProperty(_STYLE_OUTLINE_STYLE, value.value);
  }

  /**
   * Set the outline-width css property.
   */
  void setOutlineWidth(double value, Unit unit) {
    setProperty(_STYLE_OUTLINE_WIDTH, value, unit);
  }

  /**
   * Sets the overflow CSS property.
   */
  void setOverflow(Overflow value) {
    setProperty(_STYLE_OVERFLOW, value.value);
  }

  /**
   * Sets the overflow-x CSS property.
   */
  void setOverflowX(Overflow value) {
    setProperty(_STYLE_OVERFLOW_X, value.value);
  }

  /**
   * Sets the overflow-y CSS property.
   */
  void setOverflowY(Overflow value) {
    setProperty(_STYLE_OVERFLOW_Y, value.value);
  }

  /**
   * Set the padding css property.
   */
  void setPadding(double value, Unit unit) {
    setProperty(_STYLE_PADDING, value, unit);
  }

  /**
   * Set the padding-bottom css property.
   */
  void setPaddingBottom(double value, Unit unit) {
    setProperty(_STYLE_PADDING_BOTTOM, value, unit);
  }

  /**
   * Set the padding-left css property.
   */
  void setPaddingLeft(double value, Unit unit) {
    setProperty(_STYLE_PADDING_LEFT, value, unit);
  }

  /**
   * Set the padding-right css property.
   */
  void setPaddingRight(double value, Unit unit) {
    setProperty(_STYLE_PADDING_RIGHT, value, unit);
  }

  /**
   * Set the padding-top css property.
   */
  void setPaddingTop(double value, Unit unit) {
    setProperty(_STYLE_PADDING_TOP, value, unit);
  }

  /**
   * Sets the position CSS property.
   */
  void setPosition(Position value) {
    setProperty(_STYLE_POSITION, value.value);
  }

  /**
   * Sets the value of a named property in the specified units.
   */
  void setProperty(String name, value, [Unit unit = null]) {
    assert(value != null);
    _assertCamelCase(name);
    if (unit == null) {
      _setPropertyImpl(name, value.toString());
    } else {
      _setPropertyImpl(name, value.toString() + unit.value);
    }
  }

  /**
   * Sets the value of a named property, in pixels.
   * 
   * This is shorthand for <code>value + "px"</code>.
   */
  void setPropertyPx(String name, int value) {
    setProperty(name, value, Unit.PX);
  }

  /**
   * Set the right css property.
   */
  void setRight(double value, Unit unit) {
    setProperty(_STYLE_RIGHT, value, unit);
  }

  /**
   * Set the table-layout CSS property.
   */
  void setTableLayout(TableLayout value) {
    setProperty(_STYLE_TABLE_LAYOUT, value.value);
  }

  /**
   * Set the 'text-align' CSS property.
   */
  void setTextAlign(TextAlign value) {
    setProperty(_STYLE_TEXT_ALIGN, value.value);
  }

  /**
   * Sets the text-decoration CSS property.
   */
  void setTextDecoration(TextDecoration value) {
    setProperty(_STYLE_TEXT_DECORATION, value.value);
  }
  
  /**
   * Set the 'text-indent' CSS property.
   */
  void setTextIndent(double value, Unit unit) {
    setProperty(_STYLE_TEXT_INDENT, value, unit);
  }

  /**
   * Set the 'text-justify' CSS3 property.
   */
  void setTextJustify(TextJustify value) {
    setProperty(_STYLE_TEXT_JUSTIFY, value.value);
  }

  /**
   * Set the 'text-overflow' CSS3 property.
   */
  void setTextOverflow(TextOverflow value) {
    setProperty(_STYLE_TEXT_OVERFLOW, value.value);
  }

  /**
   * Set the 'text-transform' CSS property.
   */
  void setTextTransform(TextTransform value) {
    setProperty(_STYLE_TEXT_TRANSFORM, value.value);
  }

  /**
   * Set the top css property.
   */
  void setTop(double value, Unit unit) {
    setProperty(_STYLE_TOP, value, unit);
  }

  /**
   * Sets the vertical-align CSS property.
   */
  void setVerticalAlign(value, [Unit unit = null]) {
    if (value is VerticalAlign) {
      setProperty(_STYLE_VERTICAL_ALIGN, value.value);
    } else {
      setProperty(_STYLE_VERTICAL_ALIGN, value, unit);
    }
  }

  /**
   * Sets the visibility CSS property.
   */
  void setVisibility(Visibility value) {
    setProperty(_STYLE_VISIBILITY, value.value);
  }

  /**
   * Set the 'white-space' CSS property.
   */
  void setWhiteSpace(WhiteSpace value) {
    setProperty(_STYLE_WHITE_SPACE, value.value);
  }

  /**
   * Set the width css property.
   */
  void setWidth(double value, Unit unit) {
    setProperty(_STYLE_WIDTH, value, unit);
  }

  /**
   * Set the z-index css property.
   */
  void setZIndex(int value) {
    setProperty(_STYLE_Z_INDEX, "%value");
  }

  /**
   * Assert that the specified property does not contain a hyphen.
   * 
   * @param name the property name
   */
  void _assertCamelCase(String name) {
    assert (!name.contains("-")); // : "The style name '" + name + "' should be in camelCase format";
  }

  /**
   * Gets the value of a named property.
   */
  String _getPropertyImpl(String name) {
    return event.Dom.getStyleProperty(_el, name); 
  }

  /**
   * Sets the value of a named property.
   */
  void _setPropertyImpl(String name, String value) {
    event.Dom.setStyleProperty(_el, name, value);
  }
}