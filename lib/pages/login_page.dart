import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///@author xcl
///@Da 2020/4/26
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    final screenValue = window.physicalSize;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          width: screenValue.width,
          height: screenValue.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/2.0x/ic_2x_login_bg.png'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/ic_ims_log.png",
                width: 100.0,
                height: 100.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2.0,
                  margin: EdgeInsets.only(top: 80.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            "images/2.0x/ic_2x_login_user.png",
                            width: 18,
                            height: 18,
                          ),
//                          TextField(
//                            maxLines: 1,
//                            decoration: InputDecoration(),
//                            controller: _controller,
//                            keyboardType: TextInputType.number,
//                            focusNode: FocusNode(
//                              skipTraversal: false,
//                              canRequestFocus: false,
//                              onKey: (node, event) {
//                                return false;
//                              },
//                            ),
//                            textInputAction: TextInputAction.done,
//                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            "images/2.0x/ic_2x_login_password.png",
                            width: 18,
                            height: 18,
                          ),
                        ],
                      ),
                      Text(
                        "输入密码错误",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
