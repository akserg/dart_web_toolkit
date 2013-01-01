//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;


class ClippedImageImpl {
  
  String clearImage = "resource/images/clear.gif";
  
  dart_html.Element createStructure(SafeUri url, int left, int top, int width, int height) {
    dart_html.Element tmp = new dart_html.SpanElement();
    tmp.innerHtml = getSafeHtml(url, left, top, width, height);
    return tmp.$dom_firstElementChild;
  }
  
  String getSafeHtml(SafeUri url, int left, int top, int width, int height) {
    
    StringBuffer sb = new StringBuffer();
    sb.add("width: ").add(width).add(Unit.PX.value).add("; ");
    sb.add("height: ").add(height).add(Unit.PX.value).add("; ");
    sb.add("background: url(").add(url.asString()).add(") no-repeat ");
    sb.add("-").add(left.toString()).add("px ");
    sb.add("-").add(top.toString()).add("px");
    
    return "<img onload='this.__gwtLastUnhandledEvent=\"load\";' src='${clearImage}' style='${sb.toString()}' border='0'>";
  }
  
  dart_html.Element getImgElement(Image image) {
    return image.getElement();
  }
  
  void adjust(dart_html.Element img, SafeUri url, int left, int top, int width, int height) {
    String style = "url(\"${url.asString()}\") no-repeat -${left}px -${top}px";
    img.style.background = style;
    img.style.width = width.toString().concat(Unit.PX.value);
    img.style.height = height.toString().concat(Unit.PX.value);
  }
}
