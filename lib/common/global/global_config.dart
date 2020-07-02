import 'package:flutter_project/entity/user_entity.dart';
import 'package:flutter_project/generated/json/base/json_convert_content.dart';

class GlobalConfig with JsonConvert<GlobalConfig> {
  UserEntity userEntity;
  String token;
}
