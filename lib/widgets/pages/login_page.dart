import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_project/common/net/net_request.dart';
import 'package:flutter_project/common/res/res_colors.dart';
import 'package:flutter_project/common/utils/crypto_util.dart';
import 'package:flutter_project/common/utils/global_config_util.dart';
import 'package:flutter_project/common/utils/package_info_util.dart';
import 'package:flutter_project/common/utils/text_util.dart';
import 'package:flutter_project/common/utils/toast_util.dart';
import 'package:flutter_project/entity/upgrade_entity.dart';
import 'package:flutter_project/entity/user_entity.dart';
import 'package:flutter_project/routes/app_navigator.dart';
import 'package:flutter_project/routes/app_route.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

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
  bool _isShowLoading = true;
  bool _keyboardState;
  bool _isForce = false;
  bool _upgrade = false;

  UpgradeEntity _upgradeEntity;

  @override
  void initState() {
    GlobalConfigUtil.getGlobalConfig().then((value) => {
          if (TextUtil.isStringNull(value.token)) {_checkedAppUpgrade()}
        });
    super.initState();
    _msg = "";
    //监听键盘状态
    _keyboardState = KeyboardVisibility.isVisible;
    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        _keyboardState = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(bottom: _keyboardState ? 100 : 0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/ic_login_bg.png"), fit: BoxFit.fill),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(
                  image: AssetImage("images/ic_ims_log.png"),
                  width: 100.0,
                  height: 100.0,
                ),
                Card(
                    elevation: 2.0,
                    margin: EdgeInsets.only(top: 70, left: 20, right: 20),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      icon: Image(
                                        image: AssetImage(
                                            'images/ic_login_user.png'),
                                        width: 18,
                                        height: 18,
                                      ),
                                      border: InputBorder.none,
                                      hintText: "请输入账号"),
                                  onChanged: (text) {
                                    this.setState(() {
                                      this._userName = text;
                                      this._msg = "";
                                    });
                                  },
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                ),
                                TextFormField(
                                  textAlign: TextAlign.start,
                                  obscureText: true,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      icon: Image(
                                        image: AssetImage(
                                            'images/ic_login_password.png'),
                                        width: 18,
                                        height: 18,
                                      ),
                                      border: InputBorder.none,
                                      hintText: "请输入密码"),
                                  onChanged: (text) {
                                    this.setState(() {
                                      this._password = text;
                                      this._msg = "";
                                    });
                                  },
                                  keyboardType: TextInputType.visiblePassword,
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
                  margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                  width: double.infinity,
                  child: RaisedButton(
                      elevation: 2.0,
                      color: ResColors.greenColor,
                      textColor: Colors.white,
                      child: Text(
                        "登录",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        if (!_isShowLoading) return;
                        if (_isForce &&
                            !TextUtil.isObjectNull(_upgradeEntity)) {
                          ToastUtil.show("请先更新版本");
                          NetRequest.appUpgrade(
                              context,
                              [_upgradeEntity.object.changeLog],
                              "发现新版本:${_upgradeEntity.object.versionNumber}",
                              _upgradeEntity.object.fileUrl,
                              this._isForce);
                          return;
                        }
                        if (TextUtil.isStringNull(this._userName) ||
                            TextUtil.isStringNull(this._password)) {
                          ToastUtil.show("账号密码为空");
                          return;
                        }
                        setState(() {
                          _isShowLoading = false;
                        });
                        UserEntity userEntity = await NetRequest.login(
                            this._userName,
                            CryptoUtil.cryptoPassword(this._password));
                        if (TextUtil.isObjectNull(userEntity)) {
                          ToastUtil.show("网络异常，请求失败");
                          setState(() {
                            _isShowLoading = true;
                          });
                          return;
                        }
                        setState(() {
                          _msg = userEntity.message;
                          _isShowLoading = true;
                        });
                        if (userEntity.success == 1) {
                          AppNavigator.toPushReplacementNamed(
                              context, AppRoute.SCAN_PAGE, arguments: this._upgrade);
                          return;
                        }
                      }),
                )
              ],
            ),
            Offstage(
              offstage: _isShowLoading,
              child: Loading(
                color: Colors.black38,
                indicator: BallSpinFadeLoaderIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///app检测版本升级
  _checkedAppUpgrade() async {
    final String _version = await PackageInfoUtil.getVersion();
    final UpgradeEntity _upgradeEntity =
        await NetRequest.getUpgradeEntity(_version);
    // 是否需要更新
    final bool isUpgrade = !TextUtil.isStringEmpty(
            _upgradeEntity.object.versionNumber) &&
        !TextUtil.isStringEqual(_upgradeEntity.object.versionNumber, _version);
    this._upgrade = true;
    if (!isUpgrade) return;
    // 是否强制更新
    this._isForce =
        TextUtil.isStringEqual(_upgradeEntity.object.forceUpdate, "1");
    this._upgradeEntity = _upgradeEntity;
    NetRequest.appUpgrade(
        context,
        [_upgradeEntity.object.changeLog],
        "发现新版本:${_upgradeEntity.object.versionNumber}",
        _upgradeEntity.object.fileUrl,
        this._isForce);
  }
}
