import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsy/utils/toast_util.dart';

///@author xcl
///@Da 2020/4/26
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    final screenValue = window.physicalSize;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
              Card(
                  elevation: 2.0,
                  margin: EdgeInsets.only(top: 80.0),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "images/2.0x/ic_2x_login_user.png",
                              width: 18,
                              height: 18,
                            ),
                            Expanded(
                                child: Center(
                              child: TextField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    border: InputBorder.none,
                                    hintText: "请输入账号"),
                                controller: _userController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                              ),
                            ))
                          ],
                        ),
                        Offstage(
                          offstage: true,
                          child: Text(
                            "输入账号错误",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              "images/2.0x/ic_2x_login_password.png",
                              width: 18,
                              height: 18,
                            ),
                            Expanded(
                                child: TextField(
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  border: InputBorder.none,
                                  hintText: "请输入密码"),
                              controller: _passwordController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                            ))
                          ],
                        ),
                        Offstage(
                          offstage: false,
                          child: Text(
                            "输入密码错误",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  )),
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 30),
                width: double.infinity,
                child: RaisedButton(
                  elevation: 2.0,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    "登录",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => ToastUtil.show("登录"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
