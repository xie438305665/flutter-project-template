import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/common/res/res_colors.dart';
import 'package:flutter_project/common/widgets/buidler/clip_builder.dart';
import 'package:flutter_project/common/widgets/x_img.dart';
import 'package:flutter_project/common/widgets/x_text.dart';

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
            type: XImg.ASSET,
            onPressed: () => {debugPrint("点击")},
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset("images/ic_login_password.png",),
        ),
      ),
    );
  }
}
