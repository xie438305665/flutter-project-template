import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/widgets/x_app_bar.dart';
import 'package:flutter_project/common/widgets/x_img.dart';
import 'package:flutter_project/common/widgets/x_navigation_bar.dart';

/// @description:
/// @author xcl qq:244672784
/// @Date 22222
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: XImg(
            "images/ic_login_password.png",
            onPressed: () => {debugPrint("点击")},
          ),
        ),
        appBar: XAppBar(titleStr: "测试"),
        bottomNavigationBar: XNavigationBar(isBottomAppBar: true),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.red,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
