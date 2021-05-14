import 'dart:ui';

///@description: Colors
///@author xcl qq:244672784
///@Date 2020/5/28
class ResColors {
  static const Color grayColor = Color.fromRGBO(145, 151, 157, 1);
  static const Color blackColor = Color.fromRGBO(32, 31, 28, 1);
  static const Color lineColor = Color.fromRGBO(238, 238, 238, 1);
  static const Color hintColor = Color.fromRGBO(197, 199, 199, 1);
  static const Color greenColor = Color.fromRGBO(87, 234, 193, 1);
  static const Color btnGrayColor = Color.fromRGBO(157, 157, 157, 1);
  static const Color gray10Color = Color.fromRGBO(124,129,138,1);

  ///字符串转16进制
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
