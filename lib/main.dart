import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';

import 'routes/app_route.dart';

/// @description: 入口
/// @author xcl qq:244672784
/// @Date 2020/4/25 10:42
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return MaterialApp(
      initialRoute: "/loginPage",
      routes: AppRoute.getRoutes(context),
      navigatorObservers: [GLObserver()],
    );
  }
}

class GLObserver extends NavigatorObserver {
// 添加导航监听后，跳转的时候需要使用Navigator.push路由
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null && route.settings.name == "/canvasPage") {
      OrientationPlugin.forceOrientation(DeviceOrientation.landscapeLeft);
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null && previousRoute.settings.name == "/signPage") {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}

void main() => (runApp(new App()));
