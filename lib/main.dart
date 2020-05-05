import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';
import 'package:zsy/common/global/global_provider.dart';

import 'routes/app_route.dart';

/// @description: 入口
/// @author xcl qq:244672784
/// @Date 2020/4/25 10:42
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoute.LOGIN_PAGEl,
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
    if (previousRoute != null && route.settings.name == AppRoute.CANVAS_PAGE) {
      OrientationPlugin.forceOrientation(DeviceOrientation.landscapeLeft);
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    map.remove(route.settings.name);
    if (previousRoute != null &&
        previousRoute.settings.name == AppRoute.SIGN_PAGE) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}

void main() => GlobalProvider.init().then((e) => runApp(new App()));
