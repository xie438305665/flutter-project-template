import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
import 'package:flutter_project/common/global/global_config.dart';
import 'package:flutter_project/common/global/global_provider.dart';
import 'package:flutter_project/common/net/log_interceptor.dart';
import 'package:flutter_project/common/net/net_url.dart';
import 'package:flutter_project/common/help/data_help.dart';
import 'package:flutter_project/common/utils/package_info_util.dart';
import 'package:flutter_project/common/utils/check_util.dart';
import 'package:flutter_project/entity/sign_entity.dart';
import 'package:flutter_project/entity/upgrade_entity.dart';
import 'package:flutter_project/entity/user_entity.dart';
import 'package:flutter_project/generated/json/base/json_convert_content.dart';

import '../../constant.dart';

/// @description:请求封装类
/// @author xcl qq:244672784
/// @Date 2020/5/5 15:01
class NetManager {
  NetManager._internal();

  static NetManager _netManager;

  static NetManager get instance => _getInstance();

  factory NetManager() => _getInstance();

  static NetManager _getInstance() {
    if (_netManager == null) {
      _netManager = NetManager();
    }
    return _netManager;
  }

  static const HEADER = "mysiginfo";
  static GlobalConfig _globalConfig;

  static Future<GlobalConfig> getGlobalConfig() async {
    if (_globalConfig == null) {
      _globalConfig = await DataHelp.getGlobalConfig();
    }
    return _globalConfig;
  }

  //创建dio
  static Dio dio =
      new Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

  ///初始化 dio
  static void init() async {
    getGlobalConfig().then((config) => _globalConfig = config);
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
    if (!CheckUtil.isObjectNull(_globalConfig) &&
        !CheckUtil.isStringNull(_globalConfig.token)) {
      dio.options.headers[HEADER] = _globalConfig.token;
    } else {
      dio.options.headers[HEADER] = "";
    }
  }

  ///Interceptors
  static void addInterceptor(Interceptors interceptors) {
    interceptors.forEach((interceptor) => dio.interceptors.add(interceptor));
  }

  ///headers
  static void addHeaders(Map<String, String> headers) {
    if (headers.isEmpty) return;
    headers.forEach((key, value) => dio.options.headers[key] = value);
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
}
