import 'package:flutter/material.dart';
import 'package:flutter_project/common/global/global_config.dart';
import 'package:flutter_project/common/global/global_provider.dart';

/// @description:基类
/// @author xcl qq:244672784
/// @Date 2020/5/5 12:22
class BaseNotifier extends ChangeNotifier {
  GlobalConfig get globalConfig => GlobalProvider.globalConfig;

  ///数据变更 通知widget更新
  @override
  void notifyListeners() {
    GlobalProvider.updateConfig(globalConfig);
    super.notifyListeners();
  }
}
