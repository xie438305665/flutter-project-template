import 'package:flutter/material.dart';
import 'package:zsy/widgets/pages/canvas_page.dart';
import 'package:zsy/widgets/pages/login_page.dart';
import 'package:zsy/widgets/pages/scan_page.dart';
import 'package:zsy/widgets/pages/sign_page.dart';
import 'package:zsy/widgets/pages/splash_page.dart';

///Route
class AppRoute {
  AppRoute._();

  static String splashPage = "/"; //启动页
  static String loginPage = "/loginPage"; //登录
  static String scanPage = "/scanPage"; //扫描
  static String signPage = "/signPage"; //签名
  static String canvasPage = "/canvasPage"; //画布签名

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
