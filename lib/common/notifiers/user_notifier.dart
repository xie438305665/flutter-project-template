import 'package:zsy/common/notifiers/base_notiier.dart';
import 'package:zsy/entitys/user_entity.dart';

/// @description: 用户信息变更 通知类
/// @author xcl qq:244672784
/// @Date 2020/5/5 11:22
class UserNotifier extends BaseNotifier {
  set(UserEntity userEntity) {
    if (userEntity == null) return;
    globalConfig.userEntity = userEntity;
    notifyListeners();
  }
}
