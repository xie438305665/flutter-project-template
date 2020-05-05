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

  static initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putString(String key, String value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setString(key, value);
  }

  static putInt(String key, int value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setInt(key, value);
  }

  static putDouble(String key, double value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setDouble(key, value);
  }

  static putBool(String key, bool value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setBool(key, value);
  }

  static putStringList(String key, List<String> value) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setStringList(key, value);
  }

  static getString(String key, String defaultValue) {
    if (sharedPreferences == null) return defaultValue;
    sharedPreferences.getString(key);
  }

  static getInt(String key, int defaultValue) {
    if (sharedPreferences == null) return defaultValue;
    sharedPreferences.getInt(key);
  }

  static getDouble(String key, double defaultValue) {
    if (sharedPreferences == null) return defaultValue;
    sharedPreferences.getDouble(key);
  }

  static getBool(String key, bool defaultValue) {
    if (sharedPreferences == null) return defaultValue;
    sharedPreferences.getBool(key);
  }

  static getStringList(String key, List<String> defaultValue) {
    if (sharedPreferences == null) return defaultValue;
    sharedPreferences.getStringList(key);
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
