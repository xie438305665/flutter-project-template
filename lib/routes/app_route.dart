import 'package:flutter/material.dart';
import 'package:zsy/widgets/pages/canvas_page.dart';
import 'package:zsy/widgets/pages/login_page.dart';
import 'package:zsy/widgets/pages/scan_page.dart';
import 'package:zsy/widgets/pages/sign_page.dart';
import 'package:zsy/widgets/pages/splash_page.dart';

///Route
class AppRoute {

  static const String SPLASH_PAGE = "/"; //启动页
  static const String LOGIN_PAGEl = "/loginPage"; //登录
  static const String SCAN_PAGE = "/scanPage"; //扫描
  static const String SIGN_PAGE = "/signPage"; //签名
  static const String CANVAS_PAGE = "/canvasPage"; //画布签名

  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      SPLASH_PAGE: (context) => SplashPage(),
      LOGIN_PAGEl: (context) => LoginPage(),
      SCAN_PAGE: (context) => ScanPage(),
      SIGN_PAGE: (context) => SignPage(),
      CANVAS_PAGE: (context) => CanvasPage(),
    };
  }
}
