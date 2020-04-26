import 'package:flutter/material.dart';
import 'package:zsy/pages/login_page.dart';
import 'package:zsy/pages/splash_page.dart';

///Route
class AppRoute {
  AppRoute._();

  static String _splashPage = "../pages/_splashPage"; //启动页
  static String _loginPage = "../pages/_loginPage"; //登录

  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      _splashPage: (context) => SplashPage(),
      _loginPage: (context) => LoginPage(),
    };
  }
}
