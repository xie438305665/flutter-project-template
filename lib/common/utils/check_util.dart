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

  static bool isStringNull(String text) {
    return isObjectNull(text) || isStringEmpty(text);
  }

  static bool isObjectNull(Object text) {
    return text == null;
  }

  static bool isStringEmpty(String text) {
    return text.length == 0 || text == "";
  }

  static bool isStringEqual(String firstText, String secondText) {
    if (isStringNull(firstText) || isStringNull(secondText)) return false;
    return firstText == secondText;
  }

  static bool isListEmpty(List<dynamic> list) {
    return isObjectNull(list) || list.length == 0;
  }
}
