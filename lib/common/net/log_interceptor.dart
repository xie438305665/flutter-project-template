import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// @description:请求日志  拦截器
/// @author xcl qq:244672784
/// @Date 2020/5/5 15:57
class LogInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    debugPrint(options.toString());
    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) {
    debugPrint(err.toString());
    return super.onError(err);
  }

  @override
  Future onResponse(Response response) {
    debugPrint(response.toString());
    return super.onResponse(response);
  }
}
