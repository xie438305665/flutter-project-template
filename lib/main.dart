import 'package:flutter/material.dart';

import 'navigator/app_route.dart';

/// @description: 入口
/// @author xcl qq:244672784
/// @Date 2020/4/25 10:42
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "../pages/_loginPage",
      routes: AppRoute.getRoutes(context),
    );
  }
}

void main() => (runApp(new App()));
