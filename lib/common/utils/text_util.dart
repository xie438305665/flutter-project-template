/// @description: 工具类
/// @author xcl qq:244672784
/// @Date 2020/5/5 12:57
class TextUtil {
  TextUtil._internal();

  static TextUtil _textUtil;

  static TextUtil get instance => _getInstance();

  factory TextUtil() => _getInstance();

  static TextUtil _getInstance() {
    if (_textUtil == null) {
      _textUtil = new TextUtil();
    }
    return _textUtil;
  }

  static bool isStringNull(String text) {
    return text == null || isStringEmpty(text);
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
}
