import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zsy/common/global/global_config.dart';
import 'package:zsy/common/global/global_provider.dart';
import 'package:zsy/common/net/log_interceptor.dart';
import 'package:zsy/common/net/net_url.dart';
import 'package:zsy/common/utils/sp_util.dart';
import 'package:zsy/common/utils/text_util.dart';
import 'package:zsy/common/utils/toast_util.dart';
import 'package:zsy/entitys/user_entity.dart';
import 'package:zsy/generated/json/base/json_convert_content.dart';

import '../../constant.dart';

/// @description:请求封装类
/// @author xcl qq:244672784
/// @Date 2020/5/5 15:01
class NetRequest<T> {
  static const HEADER = "mysiginfo";
  BuildContext context;
  Options _options;
  static GlobalConfig _globalConfig;

  NetRequest([this.context]) {
    _options = Options(extra: {"context": context});
  }

  //创建dio
  static Dio dio =
      new Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

  ///初始化 dio
  static void init() {
    dio.options.baseUrl = GlobalProvider.isRelease
        ? NetUrl.BASE_RELEASE_URL
        : NetUrl.BASE_TESTING_URL;
    // 添加插件
    dio.interceptors.add(HttpLogInterceptor());
    // 添加头部
    String spValue = SpUtil.getString(Constant.SP_CONFIG_KEY, "");
    if (!TextUtil.isStringNull(spValue)) {
      _globalConfig = jsonDecode(spValue);
      dio.options.headers[HEADER] = _globalConfig.token;
    } else {
      dio.options.headers[HEADER] = "";
    }
  }

//  ///get
//  void getHttp(String path, FutureOr<Response> onSuccess(Response response),
//      {Map<String, dynamic> queryParameters,
//      FutureOr<Exception> onError(Exception e)}) async {
//    try {
//      Response response = await dio.get(path, queryParameters: queryParameters);
//      onSuccess(response);
//    } on DioError catch (e) {
//      onError(e);
//    }
//  }
//
//  ///post
//  void postHttp(String path, Map<String, dynamic> map) async {
//    try {
//      Response response = await dio.post(path, data: FormData.fromMap(map));
//      return response;
//    } on DioError catch (e) {}
//  }

  // 登录
  Future<UserEntity> login(
    String userName,
    String pwd,
  ) async {
    if (TextUtil.isStringNull(userName) || TextUtil.isStringNull(pwd)) {
      ToastUtil.show("账号密码为空");
      return null;
    } else {
      Response response = await dio.post(NetUrl.LOGIN,
          data: FormData.fromMap(
              {"userName": userName, "userPassword": pwd, "version": "1.0.0"}));
      UserEntity userEntity =
          JsonConvert.fromJsonAsT<UserEntity>(response.data);
      if (!TextUtil.isObjectNull(userEntity) &&
          !TextUtil.isObjectNull(userEntity.object)) {
        UserObject userObject = userEntity.object;
        UserObjectUser userObjectUser = userObject.user;
        String token =
            "userid=${userObjectUser.id}&session=${userObject.sessionId}&sig=${userObjectUser.sig}&time=${userObjectUser.teacherId}";
        dio.options.headers[HEADER] = token;
        //更新profile中的token信息
        if (TextUtil.isObjectNull(_globalConfig)) {
          _globalConfig = GlobalConfig();
        }
        _globalConfig.userEntity = userEntity;
        _globalConfig.token = token;
        GlobalProvider.updateConfig(_globalConfig);
      }
      return userEntity;
    }
  }
}
