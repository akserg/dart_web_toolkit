//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_animation;

/**
 * Base class for animation implementations.
 */
abstract class AnimationSchedulerImpl extends AnimationScheduler {

  static AnimationSchedulerImpl impl;

  factory AnimationSchedulerImpl.Instance() {

    impl = new AnimationSchedulerImpl.browserDependent();

    /*
     * If the implementation isn't natively supported, revert back to the timer
     * based implementation.
     *
     * If impl==null (such as with GWTMockUitlities.disarm()), use null. We
     * don't want to create a new AnimationSchedulerImplTimer in this case.
     */
    if (impl is AnimationSchedulerImpl) {
      if (!(impl as AnimationSchedulerImpl).isNativelySupported()) {
        impl = new AnimationSchedulerImplTimer();
      }
    }

    return impl;
  }

  AnimationSchedulerImpl();

  factory AnimationSchedulerImpl.browserDependent() {
    return new AnimationSchedulerImplWebkit();
  }

  /**
   * Check if the implementation is natively supported.
   *
   * @return true if natively supported, false if not
   */
  bool isNativelySupported();
}
