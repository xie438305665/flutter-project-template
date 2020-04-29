import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsy/routes/app_navigator.dart';
import 'package:zsy/routes/app_route.dart';

///@description:登录
///@author xcl qq:244672784
///@Date 2020/4/27 14:38
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _userName;
  String _password;

  bool _isSuccess;

  @override
  void initState() {
    super.initState();
    _isSuccess = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset('images/2.0x/ic_2x_login_bg.png'),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                LogWidget(),
                Card(
                    elevation: 2.0,
                    margin: EdgeInsets.only(top: 80.0),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextField(
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      icon: Image.asset(
                                        "images/2.0x/ic_2x_login_user.png",
                                        width: 18,
                                        height: 18,
                                      ),
                                      border: InputBorder.none,
                                      hintText: "请输入账号"),
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text:
                                              '${this._userName == null ? "" : this._userName}',
                                          selection: TextSelection.fromPosition(
                                              TextPosition(
                                                  affinity:
                                                      TextAffinity.downstream,
                                                  offset: '${this._userName}'
                                                      .length)))),
                                  onChanged: (text) {
                                    this.setState(() {
                                      _userName = text;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                ),
                                TextField(
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      icon: Image.asset(
                                        "images/2.0x/ic_2x_login_password.png",
                                        width: 18,
                                        height: 18,
                                      ),
                                      border: InputBorder.none,
                                      hintText: "请输入密码"),
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text:
                                              '${this._password == null ? "" : this._password}',
                                          selection: TextSelection.fromPosition(
                                              TextPosition(
                                                  affinity:
                                                      TextAffinity.downstream,
                                                  offset: '${this._password}'
                                                      .length)))),
                                  onChanged: (text) {
                                    this.setState(() {
                                      this._password = text;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                ),
                                Offstage(
                                    offstage: _isSuccess,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 30),
                                      child: Text(
                                        '帐号密码错误',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  child: RaisedButton(
                      elevation: 2.0,
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text(
                        "登录",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async =>
                          AppNavigator.toPushReplacementNamed(
                              context, AppRoute.scanPage)
//                          setState(() {
//                            _isSuccess = false;
//                          })
                      ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

class LogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "images/ic_ims_log.png",
      width: 100.0,
      height: 100.0,
    );
  }
}
