import 'package:zsy/entitys/user_entity.dart';
import 'package:zsy/generated/json/base/json_convert_content.dart';

class GlobalConfig with JsonConvert<GlobalConfig> {
  UserEntity userEntity;
}
