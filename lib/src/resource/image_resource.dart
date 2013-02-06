//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_resource;

/**
 * Provides access to image resources at runtime.
 */
//@DefaultExtensions(value = {".png", ".jpg", ".gif", ".bmp"})
//@ResourceGeneratorType(ImageResourceGenerator.class)
abstract class ImageResource extends ResourcePrototype {

  /**
   * Returns the height of the image.
   */
  int get height;

  /**
   * Returns the horizontal position of the image within the composite image.
   */
  int get left;

  /**
   * Returns the URL for the composite image that contains the ImageResource.
   */
  SafeUri get url;

  /**
   * Returns the vertical position of the image within the composite image.
   */
  int get top;

  /**
   * Returns the width of the image.
   */
  int get width;

  /**
   * Return <code>true</code> if the image contains multiple frames.
   */
  bool get animated;
}

/**
 * Specifies additional options to control how an image is bundled.
 */
//  @Documented
//  @Retention(RetentionPolicy.RUNTIME)
//  @Target(ElementType.METHOD)
abstract class ImageOptions {
  /**
   * If <code>true</code>, the image will be flipped about the y-axis when
   * {@link com.google.gwt.i18n.client.LocaleInfo#isRTL()} returns
   * <code>true</code>. This is intended to be used by graphics that are
   * sensitive to layout direction, such as arrows and disclosure indicators.
   */
  bool flipRtl(); // default false;

  /**
   * Set to a positive value to override the image's intrinsic height. The
   * image bundling code will scale the image to the desired height. If only
   * one of <code>width</code> or <code>height</code> are set, the aspect
   * ratio of the image will be maintained.
   */
  int height(); // default -1;

  /**
   * Set to {@code true} to require the ImageResource to be downloaded as a
   * separate resource at runtime. Specifically, this will disable the use of
   * {@code data:} URLs or other bundling optimizations for the image. This
   * can be used for infrequently-displayed images.
   */
  bool preventInlining(); // default false;

  /**
   * This option affects the image bundling optimization to allow the image to
   * be used with the {@link CssResource} {@code @sprite} rule where
   * repetition of the image is desired.
   * 
   * @see "CssResource documentation"
   */
  // http://bugs.sun.com/view_bug.do?bug_id=6512707
  RepeatStyle repeatStyle(); // default com.google.gwt.resources.client.ImageResource.RepeatStyle.None;

  /**
   * Set to a positive value to override the image's intrinsic width. The
   * image bundling code will scale the image to the desired width. If only
   * one of <code>width</code> or <code>height</code> are set, the aspect
   * ratio of the image will be maintained.
   */
  int width(); // default -1;
}

/**
 * Indicates that an ImageResource should be bundled in such a way as to
 * support horizontal or vertical repetition.
 */
class RepeatStyle<int> extends Enum<int> {
  
  const RepeatStyle(int type) : super (type);
  
  /**
   * The image is not intended to be tiled.
   */
  static const RepeatStyle None = const RepeatStyle(0);

  /**
   * The image is intended to be tiled horizontally.
   */
  static const RepeatStyle Horizontal = const RepeatStyle(1);

  /**
   * The image is intended to be tiled vertically.
   */
  static const RepeatStyle Vertical = const RepeatStyle(2);

  /**
   * The image is intended to be tiled both horizontally and vertically. Note
   * that this will prevent compositing of the particular image in most cases.
   */
  static const RepeatStyle Both = const RepeatStyle(3);
}