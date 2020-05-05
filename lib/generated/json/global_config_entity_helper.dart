import 'package:zsy/common/global/global_config.dart';
import 'package:zsy/entitys/user_entity.dart';

globalConfigEntityFromJson(GlobalConfig data, Map<String, dynamic> json) {
  if (json['usereEntity'] != null) {
    data.userEntity = new UserEntity().fromJson(json['usereEntity']);
  }
  return data;
}

Map<String, dynamic> globalConfigEntityToJson(GlobalConfig entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.userEntity != null) {
    data['usereEntity'] = entity.userEntity.toJson();
  }
  return data;
}
