//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_layout;

/**
 * Helper class for laying out a container element and its children.
 *
 * <p>
 * This class is typically used by higher-level widgets to implement layout on
 * their behalf. It is intended to wrap an element (usually a &lt;div&gt;), and
 * lay its children out in a predictable fashion, automatically accounting for
 * changes to the parent's size, and for all elements' margins, borders, and
 * padding.
 * </p>
 *
 * <p>
 * To use this class, create a container element (again, usually a &lt;div&gt;)
 * and pass it to {@link #Layout(Element)}. Rather than attaching child elements
 * directly to the element managed by this {@link Layout}, use the
 * {@link Layout#attachChild(Element)} method. This will attach the child
 * element and return a {@link Layout.Layer} object which is used to manage the
 * child.
 * </p>
 *
 * <p>
 * A separate {@link Layout.Layer} instance is associated with each child
 * element. There is a set of methods available on this class to manipulate the
 * child element's position and size. In order for changes to a layer to take
 * effect, you must finally call one of {@link #layout()} or
 * {@link #layout(int)}. This allows many changes to different layers to be
 * applied efficiently, and to be animated.
 * </p>
 *
 * <p>
 * On most browsers, this is implemented using absolute positioning. It also
 * contains extra logic to make IE6 work properly.
 * </p>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.LayoutExample}
 * </p>
 *
 * <p>
 * NOTE: This class will <em>only</em> work in standards mode, which requires
 * that the HTML page in which it is run have an explicit &lt;!DOCTYPE&gt;
 * declaration.
 * </p>
 *
 * <p>
 * NOTE: This class is still very new, and its interface may change without
 * warning. Use at your own risk.
 * </p>
 */
class Layout {

  LayoutImpl impl = new LayoutImpl.browserDependent();

  List<Layer> layers = new List<Layer>();
  dart_html.Element parentElem;
  Animation animation;

  /**
   * Constructs a new layout associated with the given parent element.
   *
   * @param parent the element to serve as the layout parent
   */
  Layout(dart_html.Element parent) {
    this.parentElem = parent;
    impl.initParent(parent);
  }

  /**
   * Asserts that the given child element is managed by this layout.
   *
   * @param elem the element to be tested
   */
  void assertIsChild(dart_html.Element elem) {
    assert (elem.parent.parent == this.parentElem); // : "Element is not a child of this layout";
  }

  /**
   * Attaches a child element to this layout.
   *
   * <p>
   * This method will attach the child to the layout, removing it from its
   * current parent element. Use the {@link Layer} it returns to manipulate the
   * child.
   * </p>
   *
   * @param child the child to be attached
   * @param before the child element before which to insert
   * @param userObject an arbitrary object to be associated with this layer
   * @return the {@link Layer} associated with the element
   */
  Layer attachChild(dart_html.Element child, {dart_html.Element before:null, Object userObject}) {
    dart_html.Element container = impl.attachChild(parentElem, child, before);
    Layer layer = new Layer(container, child, userObject);
    layers.add(layer);
    return layer;
  }

  /**
   * Causes the parent element to fill its own parent.
   *
   * <p>
   * This is most useful for top-level layouts that need to follow the size of
   * another element, such as the &lt;body&gt;.
   * </p>
   */
  void fillParent() {
    impl.fillParent(parentElem);
  }

  /**
   * Returns the size of one unit, in pixels, in the context of this layout.
   *
   * <p>
   * This will work for any unit type, but be aware that certain unit types,
   * such as {@link Unit#EM}, and {@link Unit#EX}, will return different values
   * based upon the parent's associated font size. {@link Unit#PCT} is dependent
   * upon the parent's actual size, and the axis to be measured.
   * </p>
   *
   * @param unit the unit type to be measured
   * @param vertical whether the unit to be measured is on the vertical or
   *          horizontal axis (this matters only for {@link Unit#PCT})
   * @return the unit size, in pixels
   */
  double getUnitSize(Unit unit, bool vertical) {
    return impl.getUnitSizeInPixels(parentElem, unit, vertical);
  }

  /**
   * Updates the layout by animating it over time, with a callback on each frame
   * of the animation, and upon completion.
   *
   * @param duration the duration of the animation
   * @param callback the animation callback
   */
  void layout([int duration = 0, LayoutAnimationCallback callback = null]) {
    // Cancel the old animation, if there is one.
    if (animation != null) {
      animation.cancel();
    }

    // If there's no actual animation going on, don't do any of the expensive
    // constraint calculations or anything like that.
    if (duration == 0) {
      for (Layer l in layers) {
        l.left = l.sourceLeft = l.targetLeft;
        l.top = l.sourceTop = l.targetTop;
        l.right = l.sourceRight = l.targetRight;
        l.bottom = l.sourceBottom = l.targetBottom;
        l.width = l.sourceWidth = l.targetWidth;
        l.height = l.sourceHeight = l.targetHeight;

        l.setLeft = l.setTargetLeft;
        l.setTop = l.setTargetTop;
        l.setRight = l.setTargetRight;
        l.setBottom = l.setTargetBottom;
        l.setWidth = l.setTargetWidth;
        l.setHeight = l.setTargetHeight;

        l.leftUnit = l.targetLeftUnit;
        l.topUnit = l.targetTopUnit;
        l.rightUnit = l.targetRightUnit;
        l.bottomUnit = l.targetBottomUnit;
        l.widthUnit = l.targetWidthUnit;
        l.heightUnit = l.targetHeightUnit;

        impl.layout(l);
      }

      impl.finalizeLayout(parentElem);
      if (callback != null) {
        callback.onAnimationComplete();
      }
      return;
    }

    // Deal with constraint changes (e.g. left-width => right-width, etc)
    int parentWidth = parentElem.clientWidth;
    int parentHeight = parentElem.clientHeight;
    for (Layer l in layers) {
      adjustHorizontalConstraints(parentWidth, l);
      adjustVerticalConstraints(parentHeight, l);
    }

    animation = new LayoutAnimation(this, callback);

    animation.run(duration, element:parentElem);
  }

  /**
   * This method must be called when the parent element becomes attached to the
   * document.
   *
   * @see #onDetach()
   */
  void onAttach() {
    impl.onAttach(parentElem);
  }

  /**
   * This method must be called when the parent element becomes detached from
   * the document.
   *
   * @see #onAttach()
   */
  void onDetach() {
    impl.onDetach(parentElem);
  }

  /**
   * Removes a child element from this layout.
   *
   * @param layer the layer associated with the child to be removed
   */
  void removeChild(Layer layer) {
    impl.removeChild(layer.container, layer.child);
    //
    int indx = layers.indexOf(layer);
    if (indx != -1) {
      layers.removeAt(indx);
    }
  }

  void adjustHorizontalConstraints(int parentWidth, Layer l) {
    double leftPx = l.left * getUnitSize(l.leftUnit, false);
    double rightPx = l.right * getUnitSize(l.rightUnit, false);
    double widthPx = l.width * getUnitSize(l.widthUnit, false);

    if (l.setLeft && !l.setTargetLeft) {
      // -left
      l.setLeft = false;

      if (!l.setWidth) {
        // +width
        l.setTargetWidth = true;
        l.sourceWidth = (parentWidth - (leftPx + rightPx))
            / getUnitSize(l.targetWidthUnit, false);
      } else {
        // +right
        l.setTargetRight = true;
        l.sourceRight = (parentWidth - (leftPx + widthPx))
            / getUnitSize(l.targetRightUnit, false);
      }
    } else if (l.setWidth && !l.setTargetWidth) {
      // -width
      l.setWidth = false;

      if (!l.setLeft) {
        // +left
        l.setTargetLeft = true;
        l.sourceLeft = (parentWidth - (rightPx + widthPx))
            / getUnitSize(l.targetLeftUnit, false);
      } else {
        // +right
        l.setTargetRight = true;
        l.sourceRight = (parentWidth - (leftPx + widthPx))
            / getUnitSize(l.targetRightUnit, false);
      }
    } else if (l.setRight && !l.setTargetRight) {
      // -right
      l.setRight = false;

      if (!l.setWidth) {
        // +width
        l.setTargetWidth = true;
        l.sourceWidth = (parentWidth - (leftPx + rightPx))
            / getUnitSize(l.targetWidthUnit, false);
      } else {
        // +left
        l.setTargetLeft = true;
        l.sourceLeft = (parentWidth - (rightPx + widthPx))
            / getUnitSize(l.targetLeftUnit, false);
      }
    }

    l.setLeft = l.setTargetLeft;
    l.setRight = l.setTargetRight;
    l.setWidth = l.setTargetWidth;

    l.leftUnit = l.targetLeftUnit;
    l.rightUnit = l.targetRightUnit;
    l.widthUnit = l.targetWidthUnit;
  }

  void adjustVerticalConstraints(int parentHeight, Layer l) {
    double topPx = l.top * getUnitSize(l.topUnit, true);
    double bottomPx = l.bottom * getUnitSize(l.bottomUnit, true);
    double heightPx = l.height * getUnitSize(l.heightUnit, true);

    if (l.setTop && !l.setTargetTop) {
      // -top
      l.setTop = false;

      if (!l.setHeight) {
        // +height
        l.setTargetHeight = true;
        l.sourceHeight = (parentHeight - (topPx + bottomPx))
            / getUnitSize(l.targetHeightUnit, true);
      } else {
        // +bottom
        l.setTargetBottom = true;
        l.sourceBottom = (parentHeight - (topPx + heightPx))
            / getUnitSize(l.targetBottomUnit, true);
      }
    } else if (l.setHeight && !l.setTargetHeight) {
      // -height
      l.setHeight = false;

      if (!l.setTop) {
        // +top
        l.setTargetTop = true;
        l.sourceTop = (parentHeight - (bottomPx + heightPx))
            / getUnitSize(l.targetTopUnit, true);
      } else {
        // +bottom
        l.setTargetBottom = true;
        l.sourceBottom = (parentHeight - (topPx + heightPx))
            / getUnitSize(l.targetBottomUnit, true);
      }
    } else if (l.setBottom && !l.setTargetBottom) {
      // -bottom
      l.setBottom = false;

      if (!l.setHeight) {
        // +height
        l.setTargetHeight = true;
        l.sourceHeight = (parentHeight - (topPx + bottomPx))
            / getUnitSize(l.targetHeightUnit, true);
      } else {
        // +top
        l.setTargetTop = true;
        l.sourceTop = (parentHeight - (bottomPx + heightPx))
            / getUnitSize(l.targetTopUnit, true);
      }
    }

    l.setTop = l.setTargetTop;
    l.setBottom = l.setTargetBottom;
    l.setHeight = l.setTargetHeight;

    l.topUnit = l.targetTopUnit;
    l.bottomUnit = l.targetBottomUnit;
    l.heightUnit = l.targetHeightUnit;
  }
}

/**
 * Used to specify the alignment of child elements within a layer.
 */
class Alignment<String> extends Enum<String> {

  const Alignment(String type) : super (type);

  /**
   * Positions an element at the beginning of a given axis.
   */
  static const Alignment BEGIN = const Alignment("BEGIN");

  /**
   * Positions an element at the beginning of a given axis.
   */
  static const Alignment END = const Alignment("END");

  /**
   * Stretches an element to fill the layer on a given axis.
   */
  static const Alignment STRETCH = const Alignment("STRETCH");
}

/**
 * Callback interface used by {@link Layout#layout(int, AnimationCallback)}
 * to provide updates on animation progress.
 */
abstract class LayoutAnimationCallback {

  /**
   * Called immediately after the animation is complete, and the entire layout
   * is in its final state.
   */
  void onAnimationComplete();

  /**
   * Called at each step of the animation, for each layer being laid out.
   *
   * @param layer the layer being laid out
   */
  void onLayout(Layer layer, double progress);
}

/**
 * This class is used to set the position and size of child elements.
 *
 * <p>
 * Each child element has three values associated with each axis: {left,
 * right, width} on the horizontal axis, and {top, bottom, height} on the
 * vertical axis. Precisely two of three values may be set at a time, or the
 * system will be over- or under-contrained. For this reason, the following
 * methods are provided for setting these values:
 * <ul>
 * <li>{@link Layout.Layer#setLeftRight}</li>
 * <li>{@link Layout.Layer#setLeftWidth}</li>
 * <li>{@link Layout.Layer#setRightWidth}</li>
 * <li>{@link Layout.Layer#setTopBottom}</li>
 * <li>{@link Layout.Layer#setTopHeight}</li>
 * <li>{@link Layout.Layer#setBottomHeight}</li>
 * </ul>
 * </p>
 *
 * <p>
 * By default, each layer is set to fill the entire parent (i.e., {left, top,
 * right, bottom} = {0, 0, 0, 0}).
 * </p>
 */
class Layer {
  dart_html.Element container, child;
  Object userObject;

  bool setLeft = false, setRight = false, setTop = false, setBottom = false, setWidth = false, setHeight = false;
  bool setTargetLeft = true, setTargetRight = true, setTargetTop = true,
      setTargetBottom = true, setTargetWidth = false, setTargetHeight = false;
  Unit leftUnit, topUnit, rightUnit, bottomUnit, widthUnit, heightUnit;
  Unit targetLeftUnit = Unit.PX, targetTopUnit = Unit.PX, targetRightUnit = Unit.PX,
      targetBottomUnit = Unit.PX, targetWidthUnit, targetHeightUnit;
  double left = 0.0, top = 0.0, right = 0.0, bottom = 0.0, width = 0.0, height = 0.0;
  double sourceLeft = 0.0, sourceTop = 0.0, sourceRight = 0.0, sourceBottom = 0.0, sourceWidth = 0.0,
  sourceHeight = 0.0;
  double targetLeft = 0.0, targetTop = 0.0, targetRight = 0.0, targetBottom = 0.0, targetWidth = 0.0,
  targetHeight = 0.0;

  Alignment hPos = Alignment.STRETCH, vPos = Alignment.STRETCH;
  bool visible = true;

  Layer(dart_html.Element container, dart_html.Element child, Object userObject) {
    this.container = container;
    this.child = child;
    this.userObject = userObject;
  }

  /**
   * Gets the container element associated with this layer.
   *
   * <p>
   * This is the element that sits between the parent and child elements. It
   * is normally necessary to operate on this element only when you need to
   * modify CSS properties that are not directly modeled by the Layer class.
   * </p>
   *
   * @return the container element
   */
  dart_html.Element getContainerElement() {
    return container;
  }

  /**
   * Gets the user-data associated with this layer.
   *
   * @return the layer's user-data object
   */
  Object getUserObject() {
    return this.userObject;
  }

  /**
   * Sets the layer's bottom and height values.
   *
   * @param bottom
   * @param bottomUnit
   * @param height
   * @param heightUnit
   */
  void setBottomHeight(double bottom, Unit bottomUnit, double height,
                       Unit heightUnit) {
    this.setTargetBottom = this.setTargetHeight = true;
    this.setTargetTop = false;
    this.targetBottom = bottom;
    this.targetHeight = height;
    this.targetBottomUnit = bottomUnit;
    this.targetHeightUnit = heightUnit;
  }

  /**
   * Sets the child element's horizontal position within the layer.
   *
   * @param position
   */
  void setChildHorizontalPosition(Alignment position) {
    this.hPos = position;
  }

  /**
   * Sets the child element's vertical position within the layer.
   *
   * @param position
   */
  void setChildVerticalPosition(Alignment position) {
    this.vPos = position;
  }

  /**
   * Sets the layer's left and right values.
   *
   * @param left
   * @param leftUnit
   * @param right
   * @param rightUnit
   */
  void setLeftRight(double left, Unit leftUnit, double right,
                    Unit rightUnit) {
    this.setTargetLeft = this.setTargetRight = true;
    this.setTargetWidth = false;
    this.targetLeft = left;
    this.targetRight = right;
    this.targetLeftUnit = leftUnit;
    this.targetRightUnit = rightUnit;
  }

  /**
   * Sets the layer's left and width values.
   *
   * @param left
   * @param leftUnit
   * @param width
   * @param widthUnit
   */
  void setLeftWidth(double left, Unit leftUnit, double width,
                    Unit widthUnit) {
    this.setTargetLeft = this.setTargetWidth = true;
    this.setTargetRight = false;
    this.targetLeft = left;
    this.targetWidth = width;
    this.targetLeftUnit = leftUnit;
    this.targetWidthUnit = widthUnit;
  }

  /**
   * Sets the layer's right and width values.
   *
   * @param right
   * @param rightUnit
   * @param width
   * @param widthUnit
   */
  void setRightWidth(double right, Unit rightUnit, double width,
                     Unit widthUnit) {
    this.setTargetRight = this.setTargetWidth = true;
    this.setTargetLeft = false;
    this.targetRight = right;
    this.targetWidth = width;
    this.targetRightUnit = rightUnit;
    this.targetWidthUnit = widthUnit;
  }

  /**
   * Sets the layer's top and bottom values.
   *
   * @param top
   * @param topUnit
   * @param bottom
   * @param bottomUnit
   */
  void setTopBottom(double top, Unit topUnit, double bottom,
                    Unit bottomUnit) {
    this.setTargetTop = this.setTargetBottom = true;
    this.setTargetHeight = false;
    this.targetTop = top;
    this.targetBottom = bottom;
    this.targetTopUnit = topUnit;
    this.targetBottomUnit = bottomUnit;
  }

  /**
   * Sets the layer's top and height values.
   *
   * @param top
   * @param topUnit
   * @param height
   * @param heightUnit
   */
  void setTopHeight(double top, Unit topUnit, double height,
                    Unit heightUnit) {
    this.setTargetTop = this.setTargetHeight = true;
    this.setTargetBottom = false;
    this.targetTop = top;
    this.targetHeight = height;
    this.targetTopUnit = topUnit;
    this.targetHeightUnit = heightUnit;
  }

  /**
   * Sets the layer's visibility.
   *
   * @param visible
   */
  void setVisible(bool visible) {
    this.visible = visible;
  }
}


class LayoutAnimation extends Animation {

  Layout _layout;
  LayoutAnimationCallback _callback;

  LayoutAnimation(this._layout, this._callback);

  void onCancel() {
    onComplete();
  }

  void onComplete() {
    _layout.animation = null;
    _layout.layout();
    if (callback != null) {
      _callback.onAnimationComplete();
    }
  }

  void onUpdate(double progress) {
    for (Layer l in _layout.layers) {
      if (l.setTargetLeft) {
        l.left = l.sourceLeft + (l.targetLeft - l.sourceLeft) * progress;
      }
      if (l.setTargetRight) {
        l.right = l.sourceRight + (l.targetRight - l.sourceRight)
            * progress;
      }
      if (l.setTargetTop) {
        l.top = l.sourceTop + (l.targetTop - l.sourceTop) * progress;
      }
      if (l.setTargetBottom) {
        l.bottom = l.sourceBottom + (l.targetBottom - l.sourceBottom)
            * progress;
      }
      if (l.setTargetWidth) {
        l.width = l.sourceWidth + (l.targetWidth - l.sourceWidth)
            * progress;
      }
      if (l.setTargetHeight) {
        l.height = l.sourceHeight + (l.targetHeight - l.sourceHeight)
            * progress;
      }

      _layout.impl.layout(l);
      if (_callback != null) {
        _callback.onLayout(l, progress);
      }
    }
    _layout.impl.finalizeLayout(_layout.parentElem);
  }

}