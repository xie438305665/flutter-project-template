import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsy/common/utils/toast_util.dart';

/// @description:导航类
/// @author xcl qq:244672784
/// @Date 2020/4/25 12:59
class AppNavigator {
  static AppNavigator _navigator;

  static AppNavigator get instance => _getInstance();

  factory AppNavigator() => _getInstance();

  static AppNavigator _getInstance() {
    if (_navigator == null) {
      _navigator = new AppNavigator();
    }
    return _navigator;
  }

  ///界面跳转
  static void toPush(BuildContext context, String routeName,
      {Object arguments}) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  ///界面跳转带返回值
  static void toPushThen(
      BuildContext context, String routeName, FutureOr futureOr,
      {Object arguments}) {
    Navigator.of(context)
        .pushNamed(routeName, arguments: arguments)
        .then(futureOr, onError: () {
      ToastUtil.show("返回异常");
    });
  }

  ///返回上一个界面
  static void toPop(BuildContext context, {Object arguments}) {
    if (arguments == null) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pop(arguments);
  }

  ///从routeName -> withName 界面    中间界面全部销毁
  static void toPushNameAndRemoveUtil(
      BuildContext context, String newRouteName, RoutePredicate predicate,
      {Object arguments}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  ///从routeName -> withName 界面    中间界面全部销毁   带返回值
  static void toPushNameAndRemoveUtilThen(
      BuildContext context,
      String newRouteName,
      FutureOr futureOr,
      Function function,
      RoutePredicate predicate,
      {Object arguments}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(newRouteName, predicate)
        .then(futureOr, onError: function);
  }

  ///跳转到routeName 界面  当前界面销毁
  static void toPushReplacementNamed(BuildContext context, String routeName,
      {Object arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  ///退出APP
  static void toExit() {
    SystemNavigator.pop();
  }

  static void onNavigatorRoute(
      BuildContext context, String routeName, Route route,
      {Object arguments}) {
    Navigator.of(context).push(route);
  }

  ///通信管道
  static const String BACK_DESKTOP = "backDesktop";

  ///设置回退到手机桌面
  static Future<bool> backDeskTop() async {
    final platform = MethodChannel(BACK_DESKTOP);
    try {
      final bool out = await platform.invokeMethod(BACK_DESKTOP);
      if (out) {
        toExit();
        debugPrint('返回手机到桌面');
      }
    } on PlatformException catch (e) {
      debugPrint("通信失败(设置回退到安卓手机桌面:设置失败)");
      print(e.toString());
    }
    return Future.value(false);
  }
}
