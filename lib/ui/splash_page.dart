import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsy/navigator/app_navigator.dart';
import 'package:zsy/util/sp_utils.dart';

void main() => runApp(SplashPage());

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashState();
  }
}

class SplashState extends State {
  @override
  void initState() {
    Future.delayed(new Duration(milliseconds: 1000), () {
//AppNavigator.toPop(context)
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    final screenValue = window.physicalSize;
    return Image.asset('images/2.0x/ic_splash.jpg',
        width: screenValue.width, height: screenValue.height);
  }
}
