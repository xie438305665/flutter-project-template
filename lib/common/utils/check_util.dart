/// @description: 工具类
/// @author xcl qq:244672784
/// @Date 2020/5/5 12:57
class CheckUtil {
  CheckUtil._internal();

  static CheckUtil _checkUtil;

  static CheckUtil get instance => _getInstance();

  factory CheckUtil() => _getInstance();

  static CheckUtil _getInstance() {
    if (_checkUtil == null) {
      _checkUtil = new CheckUtil();
    }
    return _checkUtil;
  }

  static bool isStrNull(String value) {
    return isObjNull(value) || isStrEmpty(value);
  }

  static bool isObjNull(Object value) {
    return value == null;
  }

  static bool isStrEmpty(String value) {
    return value.length == 0 || value == "";
  }

  static bool isStrEqual(String firstVal, String secondVal) {
    if (isStrNull(firstVal) || isStrNull(secondVal)) return false;
    return firstVal == secondVal;
  }

  static bool isListEmpty(List<dynamic> value) {
    return isObjNull(value) || value.length == 0;
  }
}
