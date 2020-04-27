import 'package:flutter/material.dart';
import 'package:zsy/pages/login_page.dart';
import 'package:zsy/pages/scan_page.dart';
import 'package:zsy/pages/sign_page.dart';
import 'package:zsy/pages/splash_page.dart';

///Route
class AppRoute {
  AppRoute._();

  static String splashPage = "/"; //启动页
  static String loginPage = "/loginPage"; //登录
  static String scanPage = "/scanPage"; //扫描
  static String signPage = "/signPage"; //签名

  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      splashPage: (context) => SplashPage(),
      loginPage: (context) => LoginPage(),
      scanPage: (context) => ScanPage(),
      signPage: (context) => SignPage(),
    };
  }
}
