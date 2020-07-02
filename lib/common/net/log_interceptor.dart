import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

/// @description:请求日志  拦截器
/// @author xcl qq:244672784
/// @Date 2020/5/5 15:57
class HttpLogInterceptor extends LogInterceptor {
  ///请求
  @override
  Future onRequest(RequestOptions options) {
    return super.onRequest(options);
  }

  ///响应
  @override
  Future onResponse(Response response) {
    debugPrint(jsonEncode(response.data));
    return super.onResponse(response);
  }

  ///失败
  @override
  Future onError(DioError err) {
    return super.onError(err);
  }
}
