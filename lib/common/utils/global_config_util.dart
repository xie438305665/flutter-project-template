import 'dart:convert';

import 'package:flutter_project/common/global/global_config.dart';
import 'package:flutter_project/common/utils/sp_util.dart';
import 'package:flutter_project/common/utils/text_util.dart';
import 'package:flutter_project/constant.dart';
import 'package:flutter_project/entity/user_entity.dart';
import 'package:flutter_project/generated/json/base/json_convert_content.dart';

/// @description: GlobalConfig类
/// @author xcl qq:244672784
/// @Date 2020/6/23
class GlobalConfigUtil {
  GlobalConfigUtil._internal();

  static GlobalConfigUtil _globalConfigUtil;

  static GlobalConfigUtil get instance => _getInstance();

  factory GlobalConfigUtil() => _getInstance();

  static GlobalConfigUtil _getInstance() {
    if (_globalConfigUtil == null) {
      _globalConfigUtil = new GlobalConfigUtil();
    }
    return _globalConfigUtil;
  }

  ///获取UserEntity
  static Future<UserEntity> getUserEntity() async {
    GlobalConfig _globalConfig = await getGlobalConfig();
    if (_globalConfig == null) return null;
    return _globalConfig.userEntity;
  }

  ///获取UserObject
  static Future<UserObject> getUserObject() async {
    UserEntity _userEntity = await getUserEntity();
    if (_userEntity == null) return null;
    return _userEntity.object;
  }

  ///获取用户信息
  static Future<UserObjectUser> getUserInfo() async {
    UserObject _userObject = await getUserObject();
    if (_userObject == null) return null;
    return _userObject.user;
  }

  ///获取全局配置
  static Future<GlobalConfig> getGlobalConfig() async {
    String str = await SpUtil.getString(Constant.SP_CONFIG_KEY, "");
    GlobalConfig _globalConfig;
    if (TextUtil.isStringEmpty(str)) {
      _globalConfig = new GlobalConfig();
    } else {
      _globalConfig = JsonConvert.fromJsonAsT<GlobalConfig>(jsonDecode(str));
      if (_globalConfig == null) {
        _globalConfig = new GlobalConfig();
      }
    }
    return _globalConfig;
  }
}
