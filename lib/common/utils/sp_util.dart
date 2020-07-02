import 'package:shared_preferences/shared_preferences.dart';

/// @description:本地轻量级存储 工具类
/// @author xcl qq:244672784
/// @Date 2020/4/18 12:59
class SpUtil {
  SpUtil._internal();

  static SpUtil spUtils;

  static SpUtil get instance => _getInstance();

  factory SpUtil() => _getInstance();

  static SpUtil _getInstance() {
    if (spUtils == null) {
      spUtils = new SpUtil();
    }
    return spUtils;
  }

  static SharedPreferences sharedPreferences;

  static Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future putString(String key, String value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setString(key, value);
  }

  static Future putInt(String key, int value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setInt(key, value);
  }

  static Future putDouble(String key, double value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setDouble(key, value);
  }

  static Future putBool(String key, bool value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setBool(key, value);
  }

  static Future putStringList(String key, List<String> value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setStringList(key, value);
  }

  static Future<String> getString(String key, String defaultValue) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    if (!isContainsKey(key)) return defaultValue;
    return sharedPreferences.getString(key);
  }

  static Future<int> getInt(String key, int defaultValue) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    if (!isContainsKey(key)) return defaultValue;
    return sharedPreferences.getInt(key);
  }

  static Future<double> getDouble(String key, double defaultValue) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    if (!isContainsKey(key)) return defaultValue;
    return sharedPreferences.getDouble(key);
  }

  static Future<bool> getBool(String key, bool defaultValue) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    if (!isContainsKey(key)) return defaultValue;
    return sharedPreferences.getBool(key);
  }

  static Future<List<String>> getStringList(
      String key, List<String> defaultValue) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    if (!isContainsKey(key)) return defaultValue;
    return sharedPreferences.getStringList(key);
  }

  static bool isContainsKey(String key) => sharedPreferences.containsKey(key);

  static removeValue(String key) {
    if (sharedPreferences == null) return;
    sharedPreferences.remove(key);
  }

  static clear() {
    if (sharedPreferences == null) return;
    sharedPreferences.clear();
  }
}
