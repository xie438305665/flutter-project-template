import 'package:flutter/material.dart';
import 'package:flutter_project/routes/app_navigator.dart';
import 'package:flutter_project/routes/app_route.dart';

///@description: 广告页
///@author xcl qq:244672784
///@Date 2020/4/27 14:38
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1), () {
      AppNavigator.toPushReplacementNamed(context, AppRoute.LOGIN_PAGE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset("images/ic_splash.png");
  }
}
