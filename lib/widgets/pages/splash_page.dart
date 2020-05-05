import 'package:flutter/material.dart';
import 'package:zsy/routes/app_navigator.dart';
import 'package:zsy/routes/app_route.dart';

///启动页
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
      AppNavigator.toPushReplacementNamed(context, AppRoute.LOGIN_PAGEl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset("images/ic_splash.jpg");
  }
}
