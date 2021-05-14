import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
import 'package:flutter_project/common/global/global_config.dart';
import 'package:flutter_project/common/global/global_provider.dart';
import 'package:flutter_project/common/net/net_manager.dart';
import 'package:flutter_project/common/net/net_url.dart';
import 'package:flutter_project/common/utils/check_util.dart';
import 'package:flutter_project/common/utils/package_info_util.dart';
import 'package:flutter_project/entity/sign_entity.dart';
import 'package:flutter_project/entity/upgrade_entity.dart';
import 'package:flutter_project/entity/user_entity.dart';
import 'package:flutter_project/generated/json/base/json_convert_content.dart';

import '../../constant.dart';

/// @description:请求封装类
/// @author xcl qq:244672784
/// @Date 2020/5/5 15:01
class NetRequest {
  /// 登录
  static Future<UserEntity> login(String userName, String pwd) async {
    try {
      Response response = await NetManager.postHttp(NetUrl.LOGIN, {
        "userName": userName,
        "userPassword": pwd,
        "version": PackageInfoUtil.getVersion()
      });
      UserEntity userEntity =
          JsonConvert.fromJsonAsT<UserEntity>(response.data);
      if (!CheckUtil.isObjectNull(userEntity) &&
          !CheckUtil.isObjectNull(userEntity.object) &&
          userEntity.success == 1) {
        UserObject userObject = userEntity.object;
        UserObjectUser userObjectUser = userObject.user;
        String token =
            "userid=${userObjectUser.id}&session=${userObject.sessionId}&sig=${userObjectUser.sig}&time=${userObjectUser.time}";
        NetManager.addHeaders({NetManager.HEADER: token});
        GlobalConfig globalConfig = await NetManager.getGlobalConfig();
        globalConfig.userEntity = userEntity;
        globalConfig.token = token;
        GlobalProvider.updateConfig(globalConfig);
      }
      return userEntity;
    } on DioError catch (e) {
      return null;
    }
  }

  /// 获取产品信息
  static Future<SignEntity> getProductDetail(
    String type,
    String id,
  ) async {
    try {
      Response response = await NetManager.postHttp(
          NetUrl.GET_PRODUCT_DETAIL, {"type": type, "id": id});
      String dataValue = jsonEncode(response.data);
      if (!dataValue.contains("data")) return null;
      SignEntity singEntity =
          JsonConvert.fromJsonAsT<SignEntity>(response.data);
      return singEntity;
    } on DioError catch (e) {
      return null;
    }
  }

  ///保存签名数据
  static Future<Response> saveSignData(String name, String id, String grade,
      List<SignDataClass> cls, String filePath) async {
    try {
      Response response = await NetManager.postHttp(NetUrl.SAVE_SIGN_DATA, {
        "name": name,
        "id": id,
        "grade": grade,
        "classes": jsonEncode(cls),
        "fileList": [await MultipartFile.fromFile(filePath, filename: ".png")]
      });
      return response;
    } on DioError catch (e) {
      return null;
    }
  }

  ///升级App
  static Future appUpgrade(BuildContext context, List<String> contents,
      String title, String apkDownloadUrl, bool force) async {
    Future<AppUpgradeInfo> _upgradeInfo = Future.value(AppUpgradeInfo(
      title: title,
      contents: contents,
      apkDownloadUrl: apkDownloadUrl,
      force: force,
    ));
    AppUpgrade.appUpgrade(
      context,
      _upgradeInfo,
      iosAppId: 'id1514565149',
      progressBarColor: Color.fromRGBO(0, 175, 102, 6),
      okBackgroundColors: [
        Color.fromRGBO(0, 175, 102, 6),
        Color.fromRGBO(0, 175, 102, 6)
      ],
    );
  }

  ///获取服务器App相关信息
  static Future<UpgradeEntity> getUpgradeEntity(String version) async {
    Response response = await NetManager.postHttp(NetUrl.UPGRADE_APP,
        {"versionNum": version, "softwareId": Constant.uploadKey});
    if (CheckUtil.isObjectNull(response) || CheckUtil.isObjectNull(response.data))
      return null;
    final UpgradeEntity _upgradeEntity =
        JsonConvert.fromJsonAsT<UpgradeEntity>(response.data);
    if (CheckUtil.isObjectNull(_upgradeEntity) ||
        CheckUtil.isObjectNull(_upgradeEntity.object)) return null;
    return _upgradeEntity;
  }
}
