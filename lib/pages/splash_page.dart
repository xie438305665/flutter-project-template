import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsy/navigator/app_navigator.dart';

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
    Future.delayed(Duration(milliseconds: 0), () {
      AppNavigator.toPushReplacementNamed(context, "/loginPage");
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Image.asset("images/ic_splash.jpg");
  }
}
