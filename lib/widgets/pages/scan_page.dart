import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/common/net/net_request.dart';
import 'package:flutter_project/common/res/res_colors.dart';
import 'package:flutter_project/common/utils/channel_util.dart';
import 'package:flutter_project/common/utils/package_info_util.dart';
import 'package:flutter_project/common/utils/text_util.dart';
import 'package:flutter_project/common/utils/toast_util.dart';
import 'package:flutter_project/entity/upgrade_entity.dart';
import 'package:flutter_project/routes/app_navigator.dart';
import 'package:flutter_project/routes/app_route.dart';

///@description: 扫描
///@author xcl qq:244672784
///@Date 2020/4/27 14:38
class ScanPage extends StatefulWidget {
  ///控制是否检查App更新
  final arguments;

  ScanPage({this.arguments});

  @override
  _ScanPageState createState() => _ScanPageState(arguments: this.arguments);
}

class _ScanPageState extends State<ScanPage> {
  bool arguments;
  DateTime _lastPressedAt; //上次点击时间
  String _scanText;

  _ScanPageState({this.arguments});

  @override
  void initState() {
    super.initState();
    _scanText = "二维码扫描";
    if (!arguments) {
      _checkedAppUpgrade();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isIOS) return false;
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
          ToastUtil.show("再按一次退出");
          return false;
        }
        ChannelUtil.sendChannel(ChannelUtil.BACK_DESKTOP_METHOD);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset("images/ic_avatar_min.png"),
            onPressed: () => AppNavigator.toPush(context, AppRoute.USER_PAGE),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.grey[50],
          centerTitle: true,
          title: Text(
            "扫描",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/ic_scan_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("images/ic_qr_code_log.png"),
                width: 100,
                height: 100,
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: 146,
                height: 46,
                child: RaisedButton(
                  color: ResColors.greenColor,
                  elevation: 2.0,
                  onPressed: (){},
                  child: Text(_scanText),
                  textColor: Colors.white,
                ),
              )
            ],
          ),
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
    if (!isUpgrade) return;
    NetRequest.appUpgrade(
        context,
        [_upgradeEntity.object.changeLog],
        "发现新版本:${_upgradeEntity.object.versionNumber}",
        _upgradeEntity.object.fileUrl,
        TextUtil.isStringEqual(_upgradeEntity.object.forceUpdate, "1"));
  }
}
