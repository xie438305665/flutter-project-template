import 'package:flutter_project/common/global/global_config.dart';
import 'package:flutter_project/entity/user_entity.dart';

globalConfigFromJson(GlobalConfig data, Map<String, dynamic> json) {
  if (json['usereEntity'] != null) {
    data.userEntity = new UserEntity().fromJson(json['usereEntity']);
  }
  return data;
}

Map<String, dynamic> globalConfigToJson(GlobalConfig entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.userEntity != null) {
    data['usereEntity'] = entity.userEntity.toJson();
  }
  return data;
}
