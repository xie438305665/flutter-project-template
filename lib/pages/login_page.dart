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
  final _cardWidget = CardWidget();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
            child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('images/2.0x/ic_2x_login_bg.png'),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "images/ic_ims_log.png",
                    width: 100.0,
                    height: 100.0,
                  ),
                  _cardWidget,
                  Container(
                    height: 50,
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
                      onPressed: () => ToastUtil.show("${_cardWidget}"),
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  String _userName;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        margin: EdgeInsets.only(top: 80.0),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
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
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: '${this._userName == null ? "" : this._userName}',
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: '${this._userName}'.length)))),
                onChanged: (text) {
                  this.setState(() {
                    _userName = text;
                  });
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              Offstage(
                offstage: true,
                child: Text(
                  "输入账号错误",
                  style: TextStyle(color: Colors.red),
                ),
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
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: '${this._password == null ? "" : this._password}',
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: '${this._password}'.length)))),
                onChanged: (text) {
                  this.setState(() {
                    this._password = text;
                  });
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              Offstage(
                offstage: false,
                child: Text(
                  '${this._password == null ? "" : this._password}',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ));
  }
}
