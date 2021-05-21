import 'package:flutter/material.dart';
import 'package:flutter_project/common/global/global_provider.dart';
import 'package:flutter_project/common/help/data_help.dart';
import 'package:flutter_project/pages/login_page.dart';
import 'package:flutter_project/pages/scan_page.dart';
import 'package:flutter_project/routes/app_route.dart';

import 'common/utils/check_util.dart';
import 'pages/test_page.dart';

// void main() => runApp(TestPage());

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
    //获取SP值
    DataHelp.getGlobalConfig().then((value) => {
          setState(() {
            isLog = CheckUtil.isStringNull(value.token);
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //判断是否需要重新登录
      home: isLog
          ? LoginPage()
          : ScanPage(
              arguments: false,
            ),
      //配置命名路由管理器
      onGenerateRoute: AppRoute.onGenerateRoute,
//      //全局的路由
//      routes: AppRoute.getRoutes(),
      navigatorObservers: [NavigatorObserverListener()],
    );
  }
}

/// Navigator监听可以配合（routes）  一般用于路由拦截做某些操作  比如 没有登录 不能跳转到下一页
class NavigatorObserverListener extends NavigatorObserver {
  ///入栈
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
  }

  ///出栈
  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
  }
}
