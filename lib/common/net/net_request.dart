import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zsy/common/global/global_config.dart';
import 'package:zsy/common/global/global_provider.dart';
import 'package:zsy/common/net/net_url.dart';
import 'package:zsy/common/utils/sp_util.dart';
import 'package:zsy/common/utils/text_util.dart';

import '../../constant.dart';

/// @description:请求封装类
/// @author xcl qq:244672784
/// @Date 2020/5/5 15:01
class NetRequest {
  NetRequest([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;

  static Dio dio =
      new Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

  static void init() {
    dio.options.baseUrl = GlobalProvider.isRelease
        ? NetUrl.BASE_RELEASE_URL
        : NetUrl.BASE_DEV_URL;
    // 添加插件
    dio.interceptors.add(LogInterceptor());
    // 添加头部
    String spValue = SpUtil.getString(Constant.SP_CONFIG_KEY, "");
    if (!TextUtil.isStringNull(spValue)) {
      GlobalConfig globalConfig = jsonDecode(spValue);
      dio.options.headers[HttpHeaders.authorizationHeader] =
          globalConfig.userEntity.object.sessionId;
    } else {
      dio.options.headers[HttpHeaders.authorizationHeader] = "";
    }
  }

//  // 登录接口，登录成功后返回用户信息
//  Future<UserEntity> login(String login, String pwd) async {
//    String basic = 'Basic ' + base64.encode(utf8.encode('$login:$pwd'));
//    var r = await dio.get(
//      "/users/$login",
//      options: _options.merge(headers: {
//        HttpHeaders.authorizationHeader: basic
//      }, extra: {
//        "noCache": true, //本接口禁用缓存
//      }),
//    );
//    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
//    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
//    //更新profile中的token信息
//    GlobalProvider.updateConfig(config).profile.token = basic;
//    return User.fromJson(r.data);
//  }
}
