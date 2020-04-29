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
    print('App.build');
    return MaterialApp(
      initialRoute: AppRoute.loginPage,
      routes: AppRoute.getRoutes(context),
      navigatorObservers: [NavigatorObserverListener()],
    );
  }
}

/// Navigator 监听
class NavigatorObserverListener extends NavigatorObserver {
  Map<String, Route> map = Map();

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    map[route.settings.name] = route;
    if (previousRoute != null && route.settings.name == AppRoute.canvasPage) {
      OrientationPlugin.forceOrientation(DeviceOrientation.landscapeLeft);
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    map.remove(route.settings.name);
    if (previousRoute != null &&
        previousRoute.settings.name == AppRoute.signPage) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}

void main() => (runApp(new App()));
