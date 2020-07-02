import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/global/global_config.dart';
import 'package:flutter_project/common/net/net_request.dart';
import 'package:flutter_project/common/utils/sp_util.dart';
import 'package:flutter_project/common/utils/text_util.dart';
import 'package:flutter_project/constant.dart';
import 'package:flutter_project/generated/json/base/json_convert_content.dart';

import '../utils/sp_util.dart';

/// @description: 全局共享状态
/// @author xcl qq:244672784
/// @Date 2020/4/29 21:29
class GlobalProvider {
  // 是否release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 配置相关类
  static GlobalConfig globalConfig = GlobalConfig();

  ///初始化
  static Future init() async {
    String configValue = await SpUtil.getString(Constant.SP_CONFIG_KEY, "");
    if (!TextUtil.isStringNull(configValue)) {
      globalConfig =
          JsonConvert.fromJsonAsT<GlobalConfig>(jsonDecode(configValue));
    }
    debugPrint(jsonEncode(globalConfig));
    NetRequest.init();
  }

  /// 更新GlobalConfig类
  static updateConfig(GlobalConfig config) {
    if (config == null) return;
    debugPrint(jsonEncode(config));
    globalConfig = config;
    SpUtil.putString(Constant.SP_CONFIG_KEY, jsonEncode(config));
  }

  ///释放
  static clear() {
    globalConfig = null;
    SpUtil.clear();
  }
}
