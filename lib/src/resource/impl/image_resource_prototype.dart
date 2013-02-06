//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_resource;

/**
 * This is part of an implementation of the ImageBundle optimization implemented
 * with ClientBundle.
 */
class ImageResourcePrototype implements ImageResource {

  final bool animated;
  final bool lossy;
  final String name;
  final SafeUri url;
  final int left;
  final int top;
  final int width;
  final int height;

  /**
   * Only called by generated code.
   */
  ImageResourcePrototype(this.name, this.url, this.left, this.top, this.width, this.height,
                         this.animated, this.lossy);

}
