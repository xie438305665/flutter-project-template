import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsy/routes/app_navigator.dart';

/// @description: Flutter 渠道通信
/// @author xcl qq:244672784
/// @Date 2020/5/1 14:19
class ChannelUtil {
  ChannelUtil._internal();

  static ChannelUtil _channelUtil;

  static ChannelUtil get instance => _getInstance();

  factory ChannelUtil() => _getInstance();

  static ChannelUtil _getInstance() {
    if (_channelUtil == null) {
      _channelUtil = new ChannelUtil();
    }
    return _channelUtil;
  }

  ///通信管道 (Flutter发送 原生)
  static const String METHOD_CHANNEL = "method.com.verify.zsy";

  ///通信管道(原生 发送 Flutter)
  static const String EVENT_CHANNEL = "event.com.verify.zsy";

  ///返回手机桌面 Method
  static const String BACK_DESKTOP_METHOD = "backDesktop";

  ///二维码扫描 Method
  static const String QR_SCAN_METHOD = "qrScan";

  ///Flutter 数据给原生
  static Future<bool> sendChannel(String method) async {
    final platform = MethodChannel(METHOD_CHANNEL);
    final Object arguments = await platform.invokeMethod(method);
    try {
      switch (method) {
        case BACK_DESKTOP_METHOD:
          if (arguments) {
            AppNavigator.toExit();
            debugPrint('返回手机桌面');
          }
          break;
        case QR_SCAN_METHOD:
          debugPrint('开启扫描');
          break;
      }
    } on PlatformException catch (e) {
      switch (method) {
        case BACK_DESKTOP_METHOD:
          debugPrint("返回手机桌面失败");
          break;
        case QR_SCAN_METHOD:
          debugPrint("开启失败");
          break;
      }
    }
    return Future.value(false);
  }

  ///Flutter 接收原生数据
  static Future<bool> getChannel(String method) async {
    final platform = EventChannel(EVENT_CHANNEL);
    platform
        .receiveBroadcastStream()
        .listen((event) => _onListenData(event, method));
    return Future.value(false);
  }

  static void _onListenData(Object event, String method) {
    try {
      switch (method) {
        case QR_SCAN_METHOD:
          debugPrint('扫描成功');
          break;
      }
    } on PlatformException catch (e) {
      switch (method) {
        case QR_SCAN_METHOD:
          debugPrint("扫描失败");
          break;
      }
    }
  }
}
