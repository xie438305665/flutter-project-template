import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @description: toast类
/// @author xcl qq:244672784
/// @Date 2020/5/5 12:57
class ToastUtil {
  ToastUtil._internal();

  static ToastUtil toastUtil;

  static ToastUtil get instance => _getInstance();

  factory ToastUtil() => _getInstance();

  static ToastUtil _getInstance() {
    if (toastUtil == null) {
      toastUtil = new ToastUtil._internal();
    }
    return toastUtil;
  }

  static show(String msg,
      {Toast toastLength = Toast.LENGTH_SHORT,
      ToastGravity gravity = ToastGravity.BOTTOM,
      int timeInSecForIosWeb = 1,
      Color backgroundColor = Colors.black,
      Color textColor = Colors.white,
      double fontSize = 14.0}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: timeInSecForIosWeb,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }
}
