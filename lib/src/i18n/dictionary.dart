//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Provides dynamic string lookup of key/value string pairs defined in server side JSON file.
 * 
 * <p>
 * Unlike the family of interfaces that extend [Localizable] which support static
 * internationalization, the <code>Dictionary</code> class is fully dynamic.
 * As a result, a variety of error conditions (particularly those involving key
 * mismatches) cannot be caught until runtime. Similarly, the DWT compiler is
 * unable discard unused dictionary values since the structure cannot be
 * statically analyzed.
 * </p>
 * 
 * <h3>A Caveat Regarding Locale</h3>
 * The JSON file completely determines the mappings defined for each
 * dictionary without regard to the <code>locale</code> client property. Thus,
 * <code>Dictionary</code> is the most flexible of the internationalization
 * types and may provide the simplest form of integration with existing
 * localization systems which were not specifically designed to use DWT's
 * <code>locale</code> client property.
 * 
 * <p>
 * See [Localizable] for background on the <code>locale</code> client property.
 * </p>
 * 
 */
class Dictionary {

  static Map<String, Dictionary> _cache = new Map<String, Dictionary>();

  /**
   * Returns the <code>Dictionary</code> object associated with the given
   * [url].
   */
  static Future<Dictionary> getDictionary(String url) {
    Completer<Dictionary> completer = new Completer<Dictionary>();
    Dictionary target = _cache[url];
    if (target == null) {
      target = new Dictionary._internal(completer, url);
      _cache[url] = target;
    } else {
      completer.complete(target);
    }
    return completer.future;
  }

  /**
   * Dictionary pairs.
   */
  Map<String, String> _dict;

  /**
   * Name of dictionary.
   */
  String _label;
  
  /**
   * Constructor for <code>Dictionary</code>.
   */
  Dictionary._internal(Completer<Dictionary> completer, String url) {
    if (url == null || "" == url) {
      throw new Exception("Cannot create a Dictionary with a null or empty url");
    }
    this._label = "Dictionary $url";
    Future<Map> data =_read(url);
    data.catchError((Object error){
      completer.completeError(new Exception(error.toString()));
    });
    data.then((Map<String, String> pairs){
      _dict = pairs;
      completer.complete(this);
    });
  }

  /**
   * Get the value associated with the given Dictionary [key].
   */
  String get(String key) {
    assert(key != null);
    //
    if (_dict == null) {
      throw new Exception("Dictionary has not been created.");
    } else {
      if (_dict.containsKey(key)) {
        return _dict[key];
      } else {
        throw new Exception("Cannot find '$key' in ${this.toString()}");
      }
    }
  }

  /**
   * The set of keys associated with this dictionary.
   */
  Set<String> keySet() {
    if (_dict == null) {
      throw new Exception("Dictionary has not been created.");
    } else {
      Set<String> s = new Set<String>.from(_dict.keys);
      return s;
    }
  }

  String toString() {
    return _label;
  }

  /**
   * Collection of values associated with this dictionary.
   */
  List<String> values() {
    if (_dict == null) {
      throw new Exception("Dictionary has not been created.");
    } else {
      List<String> s = new List<String>.from(_dict.values);
      return s;
    }
  }

  /**
   * Read JSON file from [url], parse it and return as future. 
   */
  Future<Map> _read(String url) {
    Future<String> input = dart_html.HttpRequest.getString('$url');
    Future<Map<String, String>> data = input.then((String jsonString){
      // Parse input json string to map
      return json.parse(jsonString);
    });
    return data;
  }
}
