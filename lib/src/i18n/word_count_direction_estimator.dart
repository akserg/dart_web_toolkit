//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Direction estimator that uses the "word count" heuristic.
 * 
 * <p> Note: this is probably the recommended estimator for most use cases.
 */
class WordCountDirectionEstimator extends DirectionEstimator {

  /**
   * An instance of WordCountDirectionEstimator, to be returned by {@link #get}.
   */
  static final WordCountDirectionEstimator instance = new WordCountDirectionEstimator();
  
  /**
   * Get an instance of WordCountDirectionEstimator.
   * 
   * @return An instance of WordCountDirectionEstimator.
   */
  static WordCountDirectionEstimator get() {
    return instance;
  }

  /**
   * Estimates the direction of a given string using the "word count" heuristic,
   * as defined at {@link BidiUtils#estimateDirection}.
   *
   * @param str Input string.
   * @return Direction The estimated direction of {@code str}.
   */
  Direction estimateDirection(String str, [bool isHtml = false]) {
    return BidiUtils.get().estimateDirection(str);
  }
}
