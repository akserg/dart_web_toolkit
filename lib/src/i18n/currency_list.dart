//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Generated class containing all the CurrencyImpl instances.  This is just
 * the fallback in case the I18N module is not included.
 */
class CurrencyList extends Iterable<CurrencyData> {

  /**
   * Return the singleton instance of CurrencyList.
   */
  static CurrencyList get() {
    return CurrencyListInstance.instance;
  }

  /**
   * Add all entries in {@code override} to the original map, replacing
   * any existing entries.  This is used by subclasses that need to slightly
   * alter the data used by the parent locale.
   */
  //static JavaScriptObject overrideMap(JavaScriptObject original, JavaScriptObject override) /*-{
  static Map overrideMap(Map original, Map override) {
    for (var key in override.keys) {
//      if (override.hasOwnProperty(key)) {
        original[key] = override[key];
//      }
    }
    return original;
  }

  /**
   * Add currency codes contained in the map to an ArrayList.
   */
  //static void loadCurrencyValuesNative(JavaScriptObject map, ArrayList<CurrencyData> collection) /*-{
//  static void loadCurrencyValuesNative(Map map, List<CurrencyData> collection) {
//    for (var key in map.keys) {
////      if (map.hasOwnProperty(key)) {
//        //collection.@java.util.ArrayList::add(Ljava/lang/Object;)(map[key]);
//      collection.add(map[key]);
////      }
//    }
//  }

  /**
   * Directly reference an entry in the currency names map JSO.
   *
   * @param code ISO4217 currency code
   * @return currency name, or the currency code if not known
   */
  //static String lookupNameNative(JavaScriptObject namesMap, String code) {
//  static String lookupNameNative(Map namesMap, String code) {
//    return namesMap[code] == null ? code : namesMap[code];
//  }

  /**
   * Directly reference an entry in the currency map JSO.
   *
   * @param code ISO4217 currency code
   * @return currency data
   */
  //static CurrencyData lookupNative(JavaScriptObject dataMap, String code) /*-{
//  static CurrencyData lookupNative(Map dataMap, String code) {
//    return dataMap[code];
//  }

  /**
   * Map of currency codes to CurrencyData.
   */
  Map<String, CurrencyData> dataMapJava;

  /**
   * JS map of currency codes to CurrencyData objects. Each currency code is
   * assumed to be a valid JS object key.
   */
  //JavaScriptObject dataMapNative;
//  Map dataMapNative;

  /**
   * Map of currency codes to localized currency names. This is kept separate
   * from {@link #dataMapJava} above so that the names can be completely removed by
   * the compiler if they are not used.
   */
  Map<String, String> namesMapJava;

  /**
   * JS map of currency codes to localized currency names. This is kept separate
   * from {@link #dataMapNative} above so that the names can be completely
   * removed by the compiler if they are not used. Each currency code is assumed
   * to be a valid JS object key.
   */
  //JavaScriptObject namesMapNative;
//  Map namesMapNative;

  /**
   * Return the default currency data for this locale.
   *
   * Generated implementations override this method.
   */
  CurrencyData getDefault() {
//    if (GWT.isScript()) {
//      return getDefaultNative();
//    } else {
      return getDefaultJava();
//    }
  }

  /**
   * Returns an iterator for the list of currencies, optionally including
   * deprecated ones.
   *
   * @param includeDeprecated true if deprecated currencies should be included
   */
  Iterator<CurrencyData> get iterator {
    bool includeDeprecated = false;
    ensureCurrencyMap();
    List<CurrencyData> collection = new List<CurrencyData>();
//    if (GWT.isScript()) {
//      loadCurrencyValuesNative(dataMapNative, collection);
//    } else {
      for (CurrencyData item in dataMapJava.values) {
        collection.add(item);
      }
//    }
    if (!includeDeprecated) {
      List<CurrencyData> newCollection = new List<CurrencyData>();
      for (CurrencyData value in collection) {
        if (!value.isDeprecated()) {
          newCollection.add(value);
        }
      }
      collection = newCollection;
    }
    //return Collections.unmodifiableList(collection).iterator();
    return collection.iterator;
  }

  /**
   * Lookup a currency based on the ISO4217 currency code.
   *
   * @param currencyCode ISO4217 currency code
   * @return currency data, or null if code not found
   */
  CurrencyData lookup(String currencyCode) {
    ensureCurrencyMap();
//    if (GWT.isScript()) {
//      return lookupNative(dataMapNative, currencyCode);
//    } else {
      return dataMapJava[currencyCode];
//    }
  }

  /**
   * Lookup a currency name based on the ISO4217 currency code.
   *
   * @param currencyCode ISO4217 currency code
   * @return name of the currency, or null if code not found
   */
  String lookupName(String currencyCode) {
    ensureNamesMap();
//    if (GWT.isScript()) {
//      return lookupNameNative(namesMapNative, currencyCode);
//    } else {
      String result = namesMapJava[currencyCode];
      return (result == null) ? currencyCode : result;
//    }
  }

  /**
   * Return the default currency data for this locale.
   *
   * Generated implementations override this method.
   */
  CurrencyData getDefaultJava() {
    return new CurrencyDataImpl("USD", "\$", 2, "US\$", "\$");
  }

  /**
   * Return the default currency data for this locale.
   *
   * Generated implementations override this method.
   */
//  CurrencyData getDefaultNative() {
//    return [ "USD", "$", 2, "US$" ];
//  }

  /**
   * Loads the currency map.
   *
   * Generated implementations override this method.
   */
  Map<String, CurrencyData> loadCurrencyMapJava() {
    Map<String, CurrencyData> result = {
      "USD": new CurrencyDataImpl("USD", "\$", 2, "US\$", "\$"),
      "EUR": new CurrencyDataImpl("EUR", "в‚¬", 2, "в‚¬", "в‚¬"),
      "GBP": new CurrencyDataImpl("GBP", "UKВЈ", 2, "UKВЈ", "ВЈ"),
      "JPY": new CurrencyDataImpl("JPY", "ВҐ", 0, "JPВҐ", "ВҐ")
    };
    return result;
  }

  /**
   * Loads the currency map from a JS object literal.
   *
   * Generated implementations override this method.
   */
  //JavaScriptObject loadCurrencyMapNative() {
//  Map loadCurrencyMapNative() {
//    return {
//      "USD": [ "USD", "\$", 2 ],
//      "EUR": [ "EUR", "в‚¬", 2 ],
//      "GBP": [ "GBP", "UKВЈ", 2 ],
//      "JPY": [ "JPY", "ВҐ", 0 ],
//    };
//  }

  /**
   * Loads the currency names map.
   *
   * Generated implementations override this method.
   */
  Map<String, String> loadNamesMapJava() {
    Map<String, String> result = {
      "USD": "US Dollar",
      "EUR": "Euro",
      "GBP": "British Pound Sterling",
      "JPY": "Japanese Yen"};
    return result;
  }

  /**
   * Loads the currency names map from a JS object literal.
   *
   * Generated implementations override this method.
   */
  //JavaScriptObject loadNamesMapNative() /*-{
//  Map loadNamesMapNative() {
//    return {
//      "USD": "US Dollar",
//      "EUR": "Euro",
//      "GBP": "British Pound Sterling",
//      "JPY": "Japanese Yen",
//    };
//  }

  /**
   * Ensure that the map of currency data has been initialized.
   */
  void ensureCurrencyMap() {
//    if (GWT.isScript()) {
//      if (dataMapNative == null) {
//        dataMapNative = loadCurrencyMapNative();
//      }
//    } else {
      if (dataMapJava == null) {
        dataMapJava = loadCurrencyMapJava();
      }
//    }
  }

  /**
   * Ensure that the map of currency data has been initialized.
   */
  void ensureNamesMap() {
//    if (GWT.isScript()) {
//      if (namesMapNative == null) {
//        namesMapNative = loadNamesMapNative();
//      }
//    } else {
      if (namesMapJava == null) {
        namesMapJava = loadNamesMapJava();
      }
//    }
  }
  
//**********************
  int get length { throw new UnsupportedError("");}
  bool contains(CurrencyData element) { throw new UnsupportedError("");}
  bool get isEmpty { throw new UnsupportedError("");}
  CurrencyData get first { throw new UnsupportedError("");}
  CurrencyData get last { throw new UnsupportedError("");}
  CurrencyData get single { throw new UnsupportedError("");}
  Iterable map(f(CurrencyData element)) { throw new UnsupportedError("");}
  Iterable<CurrencyData> where(bool f(CurrencyData element)) { throw new UnsupportedError("");}
  Iterable expand(Iterable f(CurrencyData element)) { throw new UnsupportedError("");}
  void forEach(void f(CurrencyData element)) { throw new UnsupportedError("");}
  CurrencyData reduce(CurrencyData combine(CurrencyData value, CurrencyData element)) { throw new UnsupportedError("");}
  dynamic fold(var initialValue, dynamic combine(var previousValue, CurrencyData element)) { throw new UnsupportedError("");}
  bool every(bool f(CurrencyData element)) { throw new UnsupportedError("");}
  bool any(bool f(CurrencyData element)) { throw new UnsupportedError("");}
  List<CurrencyData> toList({ bool growable: true }) { throw new UnsupportedError("");}
  Set<CurrencyData> toSet() { throw new UnsupportedError("");}
  Iterable<CurrencyData> take(int n) { throw new UnsupportedError("");}
  Iterable<CurrencyData> takeWhile(bool test(CurrencyData value)) { throw new UnsupportedError("");}
  Iterable<CurrencyData> skip(int n) { throw new UnsupportedError("");}
  Iterable<CurrencyData> skipWhile(bool test(CurrencyData value)) { throw new UnsupportedError("");}
  CurrencyData firstWhere(bool test(CurrencyData value), { CurrencyData orElse() }) { throw new UnsupportedError("");}
  CurrencyData lastWhere(bool test(CurrencyData value), {CurrencyData orElse()}) { throw new UnsupportedError("");}
  CurrencyData singleWhere(bool test(CurrencyData value)) { throw new UnsupportedError("");}
  CurrencyData elementAt(int index) { throw new UnsupportedError("");}
}

/**
 * Inner class to avoid CurrencyList.clinit calls and allow this to be
 * completely removed from the generated code if instance isn't referenced
 * (such as when all you call is CurrencyList.get().getDefault() ).
 */
class CurrencyListInstance {
  static CurrencyList instance = new CurrencyList();
}