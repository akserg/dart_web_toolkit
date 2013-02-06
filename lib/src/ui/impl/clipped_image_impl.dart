//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;


class ClippedImageImpl {

  String clearImage = "resource/images/clear.gif";

  dart_html.Element createStructure(SafeUri url, int left, int top, int width, int height) {
    dart_html.SpanElement tmp = new dart_html.SpanElement();
    tmp.innerHtml = getSafeHtml(url, left, top, width, height).toString();
    return tmp.$dom_firstElementChild;
  }

  SafeHtml getSafeHtml(SafeUri url, int left, int top, int width, int height) {

    StringBuffer sb = new StringBuffer();
    sb.add("width: ");
    sb.add(width);
    sb.add(Unit.PX.value);
    sb.add("; ");
    //
    sb.add("height: ");
    sb.add(height);
    sb.add(Unit.PX.value);
    sb.add("; ");
    //
    sb.add("background: url(");
    sb.add(url.asString());
    sb.add(") no-repeat ");
    sb.add("-");
    sb.add(left.toString());
    sb.add("px ");
    sb.add("-");
    sb.add(top.toString());
    sb.add("px");

    return new SafeHtmlString("<img onload='this.__gwtLastUnhandledEvent=\"load\";' src='${clearImage}' style='${sb.toString()}' border='0'>");
  }

  dart_html.ImageElement getImgElement(Image image) {
    return image.getElement() as dart_html.ImageElement;
  }

  void adjust(dart_html.ImageElement img, SafeUri url, int left, int top, int width, int height) {
    String style = "url(\"${url.asString()}\") no-repeat -${left}px -${top}px";
    img.style.background = style;
    img.style.width = width.toString().concat(Unit.PX.value);
    img.style.height = height.toString().concat(Unit.PX.value);
  }
}
