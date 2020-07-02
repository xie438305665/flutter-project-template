import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  static Future<Object> toPushThen(BuildContext context, String routeName,
      {Object arguments}) async {
    return await Navigator.of(context)
        .pushNamed(routeName, arguments: arguments);
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
  static Future<Object> toPushNameAndRemoveUtilThen(
      BuildContext context, String newRouteName, RoutePredicate predicate,
      {Object arguments}) async {
    return await Navigator.of(context)
        .pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  ///跳转到routeName 界面  当前界面销毁
  static void toPushReplacementNamed(BuildContext context, String routeName,
      {Object arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  ///一直退出直到routeName界面
  static void toPopUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  ///当前界面退出，跳到指定routeName
  static void toPopAndPushNamed(BuildContext context, String routeName,
      {Object arguments}) {
    Navigator.of(context).popAndPushNamed(routeName, arguments: arguments);
  }

  ///当前界面退出，跳到指定routeName 带返回值
  static Future<Object> toPopAndPushNamedThen(
      BuildContext context, String routeName, RoutePredicate predicate,
      {Object arguments}) async {
    return await Navigator.of(context)
        .popAndPushNamed(routeName, arguments: arguments);
  }

  ///退出APP
  static void toExit() {
    SystemNavigator.pop();
  }
}
