import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
import 'package:flutter_project/common/global/global_config.dart';
import 'package:flutter_project/common/global/global_provider.dart';
import 'package:flutter_project/common/net/log_interceptor.dart';
import 'package:flutter_project/common/net/net_url.dart';
import 'package:flutter_project/common/utils/global_config_util.dart';
import 'package:flutter_project/common/utils/package_info_util.dart';
import 'package:flutter_project/common/utils/text_util.dart';
import 'package:flutter_project/entity/sign_entity.dart';
import 'package:flutter_project/entity/upgrade_entity.dart';
import 'package:flutter_project/entity/user_entity.dart';
import 'package:flutter_project/generated/json/base/json_convert_content.dart';

import '../../constant.dart';

/// @description:请求封装类
/// @author xcl qq:244672784
/// @Date 2020/5/5 15:01
class NetRequest {
  NetRequest._internal();

  static NetRequest _netRequest;

  static NetRequest get instance => _getInstance();

  factory NetRequest() => _getInstance();

  static NetRequest _getInstance() {
    if (_netRequest == null) {
      _netRequest = NetRequest();
    }
    return _netRequest;
  }

  static const HEADER = "mysiginfo";
  static GlobalConfig _globalConfig;

  //创建dio
  static Dio dio = new Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

  ///初始化 dio
  static void init() async {
    _globalConfig = await GlobalConfigUtil.getGlobalConfig();
    if (GlobalProvider.isRelease) {
      dio.options.baseUrl = NetUrl.BASE_RELEASE_URL;
    } else {
      switch (Constant.URL_TYPE) {
        case 0:
          dio.options.baseUrl = NetUrl.BASE_TESTING_URL;
          break;
        case 1:
          dio.options.baseUrl = NetUrl.BASE_DEV_URL;
          break;
        default:
          dio.options.baseUrl = NetUrl.BASE_RELEASE_URL;
          break;
      }
    }

    // 添加插件
    dio.interceptors.add(HttpLogInterceptor());
    // 添加头部
    if (!TextUtil.isObjectNull(_globalConfig) &&
        !TextUtil.isStringNull(_globalConfig.token)) {
      dio.options.headers[HEADER] = _globalConfig.token;
    } else {
      dio.options.headers[HEADER] = "";
    }
  }

  ///get
  static Future<Response> getHttp(String path,
      {Map<String, dynamic> queryParameters}) async {
    try {
      Response response = await dio.get(path, queryParameters: queryParameters);
      String dataValue = jsonEncode(response.data);
      if (!dataValue.contains("success") && !dataValue.contains("message")) {
        return null;
      }
      return response;
    } on DioError catch (e) {
      return null;
    }
  }

  ///post
  static Future<Response> postHttp(
      String path, Map<String, dynamic> map) async {
    try {
      Response response = await dio.post(path, data: FormData.fromMap(map));
      String dataValue = jsonEncode(response.data);
      if (!dataValue.contains("success") && !dataValue.contains("message")) {
        return null;
      }
      return response;
    } on DioError catch (e) {
      return null;
    }
  }

  /// 登录
  static Future<UserEntity> login(
    String userName,
    String pwd,
  ) async {
    try {
      Response response = await dio.post(NetUrl.LOGIN,
          data: FormData.fromMap({
            "userName": userName,
            "userPassword": pwd,
            "version": PackageInfoUtil.getVersion()
          }));
      String dataValue = jsonEncode(response.data);
      if (!dataValue.contains("success") &&
          !dataValue.contains("message") &&
          !dataValue.contains("object")) {
        return null;
      }
      UserEntity userEntity =
          JsonConvert.fromJsonAsT<UserEntity>(response.data);
      if (!TextUtil.isObjectNull(userEntity) &&
          !TextUtil.isObjectNull(userEntity.object) &&
          userEntity.success == 1) {
        UserObject userObject = userEntity.object;
        UserObjectUser userObjectUser = userObject.user;
        String token =
            "userid=${userObjectUser.id}&session=${userObject.sessionId}&sig=${userObjectUser.sig}&time=${userObjectUser.time}";
        dio.options.headers[HEADER] = token;
        if (TextUtil.isObjectNull(_globalConfig)) {
          _globalConfig = GlobalConfig();
        }
        _globalConfig.userEntity = userEntity;
        _globalConfig.token = token;
        GlobalProvider.updateConfig(_globalConfig);
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
      Response response = await dio.post(NetUrl.GET_PRODUCT_DETAIL,
          data: FormData.fromMap({"type": type, "id": id}));
      String dataValue = jsonEncode(response.data);
      if (!dataValue.contains("success") &&
          !dataValue.contains("message") &&
          !dataValue.contains("data")) {
        return null;
      }
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
      Response response = await dio.post(NetUrl.SAVE_SIGN_DATA,
          data: FormData.fromMap({
            "name": name,
            "id": id,
            "grade": grade,
            "classes": jsonEncode(cls),
            "fileList": [
              await MultipartFile.fromFile(filePath, filename: ".png")
            ]
          }));
      String dataValue = jsonEncode(response.data);
      if (!dataValue.contains("success") && !dataValue.contains("message")) {
        return null;
      }
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
    Response response = await NetRequest.postHttp(NetUrl.UPGRADE_APP,
        {"versionNum": version, "softwareId": Constant.uploadKey});
    if (TextUtil.isObjectNull(response) || TextUtil.isObjectNull(response.data))
      return null;
    final UpgradeEntity _upgradeEntity =
        JsonConvert.fromJsonAsT<UpgradeEntity>(response.data);
    if (TextUtil.isObjectNull(_upgradeEntity) ||
        TextUtil.isObjectNull(_upgradeEntity.object)) return null;
    return _upgradeEntity;
  }
}
