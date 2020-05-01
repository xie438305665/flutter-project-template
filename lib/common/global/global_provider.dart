import 'package:flutter/material.dart';

/// @description: 全局配置数据源
/// @author xcl qq:244672784
/// @Date 2020/4/29 21:29
class GlobalProvider {
  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
}