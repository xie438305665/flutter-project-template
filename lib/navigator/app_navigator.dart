import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  static void toPushThen(BuildContext context, String routeName,
      FutureOr futureOr, Function function,
      {Object arguments}) {
    Navigator.of(context)
        .pushNamed(routeName, arguments: arguments)
        .then(futureOr, onError: function);
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
  static void toPushNameAndRemoveUtil(BuildContext context, String newRouteName,
      String withName, RoutePredicate predicate,
      {Object arguments}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  ///从routeName -> withName 界面    中间界面全部销毁   带返回值
  static void toPushNameAndRemoveUtilThen(
      BuildContext context,
      String newRouteName,
      String withName,
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

  static void onNavigatorRoute(
      BuildContext context, String routeName, Route route,
      {Object arguments}) {
    Navigator.of(context).push(route);
  }
}
