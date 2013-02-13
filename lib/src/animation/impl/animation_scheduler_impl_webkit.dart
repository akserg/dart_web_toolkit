//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_animation;

/**
 * Implementation using <code>webkitRequestAnimationFrame</code> and
 * <code>webkitCancelRequestAnimationFrame</code>.
 *
 * @see <a
 *      href="http://www.chromium.org/developers/web-platform-status#TOC-requestAnimationFrame">
 *      Chromium Web Platform Status</a>
 * @see <a href="http://webstuff.nfshost.com/anim-timing/Overview.html"> webkit
 *      draft spec</a>
 */
class AnimationSchedulerImplWebkit extends AnimationSchedulerImpl {

  AnimationSchedulerImplWebkit();

  /**
   * Schedule an animation, letting the browser decide when to trigger the next
   * step in the animation.
   *
   * <p>
   * Using this method instead of a timeout is preferred because the browser is
   * in the best position to decide how frequently to trigger the callback for
   * an animation of the specified element. The browser can balance multiple
   * animations and trigger callbacks at the optimal rate for smooth
   * performance.
   * </p>
   *
   * @param callback the callback to fire
   * @return a handle to the requested animation frame
   * @param element the element being animated
   */
  AnimationHandle requestAnimationFrame(AnimationCallback callback, [dart_html.Element element = null]) {
    int requestId = requestAnimationFrameImpl(callback, element);
    return new AnimationHandleImplWebkit(requestId, this);
  }

  bool isNativelySupported() {
    return (dart_html.window.webkitRequestAnimationFrame != null &&
        dart_html.window.webkitCancelAnimationFrame != null);
  }

  void cancelAnimationFrameImpl(int requestId) {
    dart_html.window.webkitCancelAnimationFrame(requestId);
  }

  int requestAnimationFrameImpl(AnimationCallback callback, dart_html.Element element) {
    Function wrapper = (num highResTime) {
      callback.execute(new DateTime.now().millisecondsSinceEpoch);
    };
    return dart_html.window.webkitRequestAnimationFrame(wrapper);
  }
}

/**
 * Webkit implementation of {@link AnimationScheduler.AnimationHandle}. Webkit
 * provides the request ID as a int.
 */
class AnimationHandleImplWebkit extends AnimationHandle {
  int requestId;
  AnimationSchedulerImplWebkit impl;

  AnimationHandleImplWebkit(this.requestId, this.impl);

  void cancel() {
    this.impl.cancelAnimationFrameImpl(requestId);
  }
}
