import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'check_util.dart';

/// @description:加密工具类
/// @author xcl qq:244672784
/// @Date 2020/5/5 21:05
class CryptoUtil {
  CryptoUtil._internal();

  static CryptoUtil _cryptoUtil;

  static CryptoUtil get instance => _getInstance();

  factory CryptoUtil() => _getInstance();

  static CryptoUtil _getInstance() {
    if (_cryptoUtil == null) {
      _cryptoUtil = new CryptoUtil();
    }
    return _cryptoUtil;
  }

  ///加密MD5
  static String valueToMd5(Object object) {
    if (CheckUtil.isObjNull(object)) return "";
    return md5.convert(utf8.encode(object)).toString();
  }

  ///解密MD5
  static String md5ToValue(Object object) {
    if (CheckUtil.isObjNull(object)) return "";
    return utf8.decode(object);
  }

  ///加密SHA1
  static String valueToSha1(Object object) {
    if (CheckUtil.isObjNull(object)) return "";
    return sha1.convert(utf8.encode(object)).toString();
  }

  ///解密SHA1
  static String sha1ToValue(Object object) {
    if (CheckUtil.isObjNull(object)) return "";
    return utf8.decode(object);
  }

  ///登录密码 加密
  static String cryptoPassword(String password) {
    if (CheckUtil.isStrNull(password)) return "";
    return valueToMd5(valueToSha1(password));
  }
}
