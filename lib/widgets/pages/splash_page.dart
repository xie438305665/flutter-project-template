import 'package:flutter/material.dart';
import 'package:flutter_project/routes/app_navigator.dart';
import 'package:flutter_project/routes/app_route.dart';

///广告页
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
