import 'package:package_info/package_info.dart';

///@description: app 应用信息
///@author xcl qq:244672784
///@Date 2020/5/14 13:39
class PackageInfoUtil {
  PackageInfoUtil._internal();

  static PackageInfoUtil _packageInfoUtil;

  static PackageInfoUtil get instance => _getInstance();

  factory PackageInfoUtil() => _getInstance();

  static PackageInfo packageInfo;

  static PackageInfoUtil _getInstance() {
    if (_packageInfoUtil == null) {
      _packageInfoUtil = new PackageInfoUtil();
    }
    return _packageInfoUtil;
  }

  ///获取包名
  static Future<String> getPackageName() async {
    if (packageInfo == null) {
      packageInfo = await PackageInfo.fromPlatform();
    }
    return packageInfo.packageName;
  }

  ///获取Version
  static Future<String> getVersion() async {
    if (packageInfo == null) {
      packageInfo = await PackageInfo.fromPlatform();
    }
    return packageInfo.version;
  }

  ///获取BuildNumber
  static Future<String> getBuildNumber() async {
    if (packageInfo == null) {
      packageInfo = await PackageInfo.fromPlatform();
    }
    return packageInfo.buildNumber;
  }

  ///获取App应用名
  static Future<String> getAppName() async {
    if (packageInfo == null) {
      packageInfo = await PackageInfo.fromPlatform();
    }
    return packageInfo.appName;
  }
}
