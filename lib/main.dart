import 'package:flutter/material.dart';
import 'package:flutter_project/common/global/global_provider.dart';
import 'package:flutter_project/common/utils/global_config_util.dart';
import 'package:flutter_project/routes/app_route.dart';
import 'package:flutter_project/widgets/pages/login_page.dart';
import 'package:flutter_project/widgets/pages/scan_page.dart';

import 'common/utils/text_util.dart';

///程序入口
void main() => {runApp(App()), GlobalProvider.init()};

/// @author xcl qq:244672784
/// @Date 2020/4/25
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLog = true;

  @override
  void initState() {
    GlobalConfigUtil.getGlobalConfig().then((value) => {
          setState(() {
            isLog = TextUtil.isStringNull(value.token);
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLog ? LoginPage() : ScanPage(arguments: false,),
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorObservers: [NavigatorObserverListener()],
    );
  }
}

/// Navigator 监听
class NavigatorObserverListener extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
  }
}
