//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implementation of {@link AbstractImagePrototype} for a clipped image. This
 * class is used internally by the image bundle generator and is not intended
 * for general use. It is subject to change without warning.
 */
class ClippedImagePrototype extends AbstractImagePrototype {

  static final ClippedImageImpl _impl = new ClippedImageImpl(); //GWT.create(ClippedImageImpl.class);

  final int height;
  final int left;
  final int top;
  final SafeUri url;
  final int width;

  ClippedImagePrototype(this.url, this.left, this.top, this.width, this.height);


  void applyTo(Image image) {
    image.setSafeUrlAndVisibleRect(url, left, top, width, height);
  }


  void applyToImageElement(dart_html.ImageElement imageElement) {
    _impl.adjust(imageElement, url, left, top, width, height);
  }


  dart_html.ImageElement createElement() {
    return _impl.createStructure(url, left, top, width, height) as dart_html.ImageElement;
  }


  Image createImage() {
    return new Image.fromSafeUriAndMeasure(url, left, top, width, height);
  }


  SafeHtml getSafeHtml() {
    return _impl.getSafeHtml(url, left, top, width, height);
  }
}
