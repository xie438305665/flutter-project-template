import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project/common/global/global_provider.dart';
import 'package:flutter_project/common/net/net_request.dart';
import 'package:flutter_project/common/utils/global_config_util.dart';
import 'package:flutter_project/common/utils/package_info_util.dart';
import 'package:flutter_project/common/utils/sp_util.dart';
import 'package:flutter_project/common/utils/text_util.dart';
import 'package:flutter_project/common/utils/toast_util.dart';
import 'package:flutter_project/entity/upgrade_entity.dart';
import 'package:flutter_project/entity/user_entity.dart';
import 'package:flutter_project/routes/app_navigator.dart';
import 'package:flutter_project/routes/app_route.dart';

///@description: 个人中心
///@author xcl qq:244672784
///@Date 2020/6/23
class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade200,
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade200,
            ),
          ),
          Positioned(
            child: GestureDetector(
              onTap: () async => _checkedAppUpgrade(),
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                  Expanded(child: Text("检查版本更新")),
                  FutureBuilder(
                    builder:
                        (BuildContext context, AsyncSnapshot<String> version) {
                      return Text(
                        "v${version.data}",
                        style: TextStyle(fontSize: 12),
                      );
                    },
                    future: PackageInfoUtil.getVersion(),
                  ),
                  IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      onPressed: () async => _checkedAppUpgrade()),
                ],
              ),
            ),
          ),
          Align(
            child: Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.fromLTRB(20, 220, 20, 0),
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade200, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                highlightElevation: 2,
                textColor: Colors.black,
                child: Text(
                  "退出登录",
                ),
                onPressed: () async => _showDialog(),
              ),
            ),
          ),
          Align(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset("images/ic_avatar_max.png"),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  builder: (BuildContext context,
                      AsyncSnapshot<UserObjectUser> user) {
                    return Column(
                      children: <Widget>[
                        Text(
                          TextUtil.isObjectNull(user.data) ||
                                  TextUtil.isObjectNull(user.data.userName)
                              ? ""
                              : "${user.data.userName}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          TextUtil.isObjectNull(user.data) ||
                                  TextUtil.isObjectNull(user.data.schoolName)
                              ? ""
                              : "${user.data.schoolName}",
                        ),
                      ],
                    );
                  },
                  future: GlobalConfigUtil.getUserInfo(),
                ),
                SizedBox(
                  height: 280,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///退出账号
  Future<bool> _showDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialogWidget();
        });
  }

  ///app检测版本升级
  _checkedAppUpgrade() async {
    final String _version = await PackageInfoUtil.getVersion();
    final UpgradeEntity _upgradeEntity =
        await NetRequest.getUpgradeEntity(_version);
    if (TextUtil.isObjectNull(_upgradeEntity)) {
      ToastUtil.show("网络异常，检查版本失败");
      return;
    }
    // 是否需要更新
    final bool isUpgrade = !TextUtil.isStringEmpty(
            _upgradeEntity.object.versionNumber) &&
        !TextUtil.isStringEqual(_upgradeEntity.object.versionNumber, _version);
    if (!isUpgrade) {
      ToastUtil.show("已经是最新版本了");
      return;
    }
    NetRequest.appUpgrade(
        context,
        [_upgradeEntity.object.changeLog],
        "发现新版本:${_upgradeEntity.object.versionNumber}",
        _upgradeEntity.object.fileUrl,
        false);
  }
}

class AlertDialogWidget extends StatefulWidget {
  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("提示"),
      content: Text("您确定退出？"),
      actions: <Widget>[
        FlatButton(
            child: Text("切换账号"),
            onPressed: () => {
                  AppNavigator.toPop(context, arguments: true),
                  SpUtil.clear(),
                  AppNavigator.toPopAndPushNamed(context, AppRoute.LOGIN_PAGE),
                }),
        FlatButton(
          child: Text("确认退出"),
          onPressed: () {
            AppNavigator.toPop(context, arguments: true);
            GlobalProvider.clear();
            if (Platform.isIOS) {
              exit(0);
            } else {
              AppNavigator.toExit();
            }
          },
        ),
      ],
    );
  }
}
