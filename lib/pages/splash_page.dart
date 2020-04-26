import 'package:flutter/material.dart';
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
    Future.delayed(Duration(milliseconds: 0), () {
      AppNavigator.toPushReplacementNamed(context, "../pages/_loginPage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
