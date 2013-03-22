//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Utility class for handling auto-direction adjustment.
 *
 * This class is useful for automatically adjusting the direction of an object
 * that takes text input, while the text is being entered.
 */
class AutoDirectionHandler implements KeyUpHandler, HasDirectionEstimator {

  /**
   * Operates like {@link #addTo(AutoDirectionHandlerTarget, DirectionEstimator)}, but uses a
   * default DirectionEstimator, {@link
   * com.google.gwt.i18n.shared.WordCountDirectionEstimator} if {@code enabled},
   * or else a null DirectionEstimator, which means disabling direction
   * estimation.
   *
   * @param target Object whose direction should be automatically adjusted on
   *     relevant events.
   * @param enabled Whether the handler is enabled upon creation.
   * @return AutoDirectionHandler An instance of AutoDirectionHandler for the
   *     given object.
   */
  static AutoDirectionHandler addToDefault(AutoDirectionHandlerTarget target, [bool enabled = true]) {
    return addTo(target, enabled ? WordCountDirectionEstimator.get() : null);
  }

  /**
   * Adds auto-direction adjustment to a given object:
   * - Creates an AutoDirectionHandler.
   * - Initializes it with the given DirectionEstimator.
   * - Adds it as an event handler for the relevant events on the given object.
   * - Returns the AutoDirectionHandler, so its setAutoDir() method can be
   * called when the object's text changes by means other than the handled
   * events.
   *
   * @param target Object whose direction should be automatically adjusted on
   *     relevant events.
   * @param directionEstimator A DirectionEstimator object used for direction
   *     estimation (use null to disable direction estimation).
   * @return AutoDirectionHandler An instance of AutoDirectionHandler for the
   *     given object.
   */
  static AutoDirectionHandler addTo(AutoDirectionHandlerTarget target, DirectionEstimator directionEstimator) {
    AutoDirectionHandler autoDirHandler = new AutoDirectionHandler(target, directionEstimator);
    return autoDirHandler;
  }

  /**
   * A DirectionEstimator object used for direction estimation.
   */
  DirectionEstimator directionEstimator;

  /**
   * A HandlerRegistration object used to remove this handler.
   */
  HandlerRegistration handlerRegistration;

  /**
   * The object being handled.
   */
  AutoDirectionHandlerTarget target;

  /**
   * Private constructor. Instantiate using one of the addTo() methods.
   *
   * @param target Object whose direction should be automatically adjusted on
   *     relevant events.
   * @param directionEstimator A DirectionEstimator object used for direction
   *     estimation.
   */
  AutoDirectionHandler(AutoDirectionHandlerTarget target, DirectionEstimator
      directionEstimator) {
    this.target = target;
    this.handlerRegistration = null;
    setDirectionEstimator(directionEstimator);
  }

  /**
   * Returns the DirectionEstimator object.
   */
  DirectionEstimator getDirectionEstimator() {
    return directionEstimator;
  }

  /**
   * Automatically adjusts hasDirection's direction on KeyUpEvent events.
   * Implementation of KeyUpHandler interface method.
   */
  void onKeyUp(KeyUpEvent event) {
    refreshDirection();
  }

  /**
   * Adjusts target's direction according to the estimated direction of the text
   * it supplies.
   */
  void refreshDirection() {
    if (directionEstimator != null) {
      Direction dir = directionEstimator.estimateStringDirection(target.text);
      if (dir != target.direction) {
        target.direction = dir;
      }
    }
  }

  /**
   * Toggles direction estimation on (using a default estimator) and off.
   */
  void enableDefaultDirectionEstimator(bool enabled) {
    setDirectionEstimator(enabled ? WordCountDirectionEstimator.get() : null);
  }

  /**
   * Sets the DirectionEstimator object.
   */
  void setDirectionEstimator(DirectionEstimator directionEstimator) {
    this.directionEstimator = directionEstimator;
    if ((directionEstimator == null) != (handlerRegistration == null)) {
      if (directionEstimator == null) {
        handlerRegistration.removeHandler();
        handlerRegistration = null;
      } else {
        handlerRegistration = target.addKeyUpHandler(this);
      }
    }
    refreshDirection();
  }
}
 
/**
 * The interface an object must implement in order to add an
 * AutoDirectionHandler to it.
*
 * TODO(tomerigo): add Paste and Input events once they're available in GWT.
 */
abstract class AutoDirectionHandlerTarget implements HasText, HasDirection, HasKeyUpHandlers {
}
