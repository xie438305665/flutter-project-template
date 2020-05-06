import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zsy/common/net/net_request.dart';
import 'package:zsy/common/notifiers/user_notifier.dart';
import 'package:zsy/common/utils/crypto_util.dart';
import 'package:zsy/common/utils/text_util.dart';
import 'package:zsy/entitys/user_entity.dart';
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

  String _msg;

  UserEntity _userEntity;

  @override
  void initState() {
    super.initState();
    _msg = "";
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserNotifier>.value(
        value: UserNotifier().set(_userEntity),
        child: Scaffold(
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
                                      controller: TextEditingController
                                          .fromValue(TextEditingValue(
                                              text:
                                                  '${this._userName == null ? "" : this._userName}',
                                              selection: TextSelection
                                                  .fromPosition(TextPosition(
                                                      affinity: TextAffinity
                                                          .downstream,
                                                      offset:
                                                          '${this._userName}'
                                                              .length)))),
                                      onChanged: (text) {
                                        this.setState(() {
                                          this._userName = text;
                                          this._msg = "";
                                        });
                                      },
                                      keyboardType: TextInputType.text,
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
                                      controller: TextEditingController
                                          .fromValue(TextEditingValue(
                                              text:
                                                  '${this._password == null ? "" : this._password}',
                                              selection: TextSelection
                                                  .fromPosition(TextPosition(
                                                      affinity: TextAffinity
                                                          .downstream,
                                                      offset:
                                                          '${this._password}'
                                                              .length)))),
                                      onChanged: (text) {
                                        this.setState(() {
                                          this._password = text;
                                          this._msg = "";
                                        });
                                      },
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                    ),
                                    Offstage(
                                        offstage: TextUtil.isStringNull(_msg),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 30),
                                          child: Text(
                                            _msg,
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
                          onPressed: () async => {
                                NetRequest(context)
                                    .login(
                                        this._userName,
                                        CryptoUtil.cryptoPassword(
                                            this._password))
                                    .then((userEntity) {
                                  if (userEntity.success != 1) {
                                    setState(() {
                                      _msg = userEntity.message;
                                    });
                                  } else {
                                    setState(() {
                                      _msg = "";
                                    });
                                    AppNavigator.toPushReplacementNamed(
                                        context, AppRoute.SCAN_PAGE);
                                  }
                                })
                              }),
                    )
                  ],
                ),
              ),
            ],
          )),
        ));
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
