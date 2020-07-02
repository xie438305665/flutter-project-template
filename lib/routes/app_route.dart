import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/widgets/pages/canvas_page.dart';
import 'package:flutter_project/widgets/pages/login_page.dart';
import 'package:flutter_project/widgets/pages/scan_page.dart';
import 'package:flutter_project/widgets/pages/sign_page.dart';
import 'package:flutter_project/widgets/pages/sign_success_page.dart';
import 'package:flutter_project/widgets/pages/user_page.dart';
import 'package:orientation/orientation.dart';

///Route
class AppRoute {
  static const String LOGIN_PAGE = "/loginPage"; //登录
  static const String SCAN_PAGE = "/scanPage"; //扫描
  static const String SIGN_PAGE = "/signPage"; //签名
  static const String CANVAS_PAGE = "/canvasPage"; //画布签名
  static const String USER_PAGE = "/userPage"; //个人中心
  static const String SIGN_SUCCESS_PAGE = "/signSuccessPage"; //签名成功信息展示

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      LOGIN_PAGE: (context) => LoginPage(),
      SCAN_PAGE: (context, {arguments}) => ScanPage(arguments: arguments),
      USER_PAGE: (context) => UserPage(),
      SIGN_PAGE: (context, {arguments}) => SignPage(arguments: arguments),
      CANVAS_PAGE: (context, {arguments}) => CanvasPage(arguments: arguments),
      SIGN_SUCCESS_PAGE: (context, {arguments}) =>
          SignSuccessPage(arguments: arguments),
    };
  }

  static final onGenerateRoute = (RouteSettings settings) {
    final String name = settings.name;
    final Function pageContentBuilder = AppRoute.getRoutes()[name];
    if (pageContentBuilder != null) {
      debugPrint(settings.name);
      if (settings.name == AppRoute.CANVAS_PAGE) {
        OrientationPlugin.forceOrientation(DeviceOrientation.landscapeLeft);
      }
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments));
        return route;
      } else {
        final Route route = MaterialPageRoute(
            builder: (context) => pageContentBuilder(context));
        return route;
      }
    }
  };
}
