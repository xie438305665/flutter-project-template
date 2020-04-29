import 'package:flutter/material.dart';
import 'package:zsy/widgets/pages/canvas_page.dart';
import 'package:zsy/widgets/pages/login_page.dart';
import 'package:zsy/widgets/pages/scan_page.dart';
import 'package:zsy/widgets/pages/sign_page.dart';
import 'package:zsy/widgets/pages/splash_page.dart';

///Route
class AppRoute {
  AppRoute._();

  static const String splashPage = "/"; //启动页
  static const String loginPage = "/loginPage"; //登录
  static const String scanPage = "/scanPage"; //扫描
  static const String signPage = "/signPage"; //签名
  static const String canvasPage = "/canvasPage"; //画布签名

  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      splashPage: (context) => SplashPage(),
      loginPage: (context) => LoginPage(),
      scanPage: (context) => ScanPage(),
      signPage: (context) => SignPage(),
      canvasPage: (context) => CanvasPage(),
    };
  }
}
