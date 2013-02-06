//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * An opaque representation of a particular image such that the image can be
 * accessed either as an HTML fragment or as an {@link Image} object. An image
 * prototype can be thought of as an abstract image factory with additional
 * capabilities.
 * 
 * <p>
 * The {@link #applyTo(Image)} method provides an efficient way to replace the
 * contents of an existing <code>Image</code>. This is useful in cases where an
 * image changes its appearance based on a user's action. Instead of creating
 * two <code>Image</code> objects then alternately hiding/showing them, one can
 * use the {@link #applyTo(Image)} method of two
 * <code>AbstractImagePrototype</code> objects to transform a single
 * <code>Image</code> object between two (or more) visual representations. The
 * use of <code>AbstractImagePrototypes</code> results in an cleaner and more
 * efficient implementation.
 * </p>
 * 
 * <p>
 * This class also provide methods for working with raw elements, using
 * {@link #createElement()} and {@link #applyTo(ImagePrototypeElement)}.
 * </p>
 * 
 * <p>
 * This class is also a useful way to encapsulate complex HTML that represents
 * an image without actually instantiating <code>Image</code> objects. When
 * constructing large HTML fragments, especially those that contain many images,
 * {@link #getHTML()} can be much more efficient.
 * </p>
 */
abstract class AbstractImagePrototype {

  /**
   * Create an AbstractImagePrototype backed by a ClientBundle ImageResource.
   * This method provides an API compatibility mapping for the new ImageResource
   * API.
   * 
   * @param resource an ImageResource produced by a ClientBundle
   * @return an AbstractImagePrototype that displays the contents of the
   *         ImageResource
   */
  static AbstractImagePrototype create(ImageResource resource) {
    return new ClippedImagePrototype(resource.url, resource.left, resource.top,
        resource.width, resource.height);
  }

  /**
   * Transforms an existing {@link Image} into the image represented by this
   * prototype.
   * 
   * @param image the instance to be transformed to match this prototype
   */
  void applyTo(Image image);

  /**
   * Transforms an existing {@link ImagePrototypeElement} into the image
   * represented by this prototype.
   * 
   * @param imageElement an <code>ImagePrototypeElement</code> created by
   *          {@link #createElement()}
   */
  void applyToImageElement(dart_html.ImageElement imageElement) {
    // Because this is a new method on an existing base class, we need to throw
    // UnsupportedOperationException to avoid static errors.
    throw new Exception("UnsupportedOperation");
  }

  /**
   * Creates a new {@link Element} based on the image represented by this
   * prototype. The DOM structure may not necessarily a simple
   * <code>&lt;img&gt;</code> element. It may be a more complex structure that
   * should be treated opaquely.
   * 
   * @return the <code>ImagePrototypeElement</code> corresponding to the image
   *         represented by this prototype
   */
  dart_html.ImageElement createElement() {
    // Because this is a new method on an existing base class, we need to throw
    // UnsupportedOperationException to avoid static errors.
    throw new Exception("UnsupportedOperation");
  }

  /**
   * Creates a new {@link Image} instance based on the image represented by this
   * prototype.
   * 
   * @return a new {@link Image} based on this prototype
   */
  Image createImage();

  /**
   * Gets an HTML fragment that displays the image represented by this
   * prototype. The HTML returned is not necessarily a simple
   * <code>&lt;img&gt;</code> element. It may be a more complex structure that
   * should be treated opaquely.
   * <p>
   * The default implementation calls {@link #getSafeHtml()}.
   * 
   * @return the HTML representation of this prototype
   */
  String getHtml() {
    return getSafeHtml().asString();
  }

  /**
   * Gets an HTML fragment that displays the image represented by this
   * prototype. The HTML returned is not necessarily a simple
   * <code>&lt;img&gt;</code> element. It may be a more complex structure that
   * should be treated opaquely.
   * <p>
   * The default implementation throws an {@link UnsupportedOperationException}.
   * 
   * @return the HTML representation of this prototype
   */
  SafeHtml getSafeHtml() {
    // Because this is a new method on an existing base class, we need to throw
    // UnsupportedOperationException to avoid static errors.
    throw new Exception("UnsupportedOperation");
  }
}

///**
// * This corresponds to the top Element of the DOM structure created by
// * {@link #createElement()}.
// */
//class ImagePrototypeElement { //extends Element {
//  
//  dart_html.Element element;
//  
//  ImagePrototypeElement() {
//  }
//}