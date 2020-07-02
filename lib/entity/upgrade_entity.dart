import 'package:flutter_project/generated/json/base/json_convert_content.dart';
import 'package:flutter_project/generated/json/base/json_filed.dart';

class UpgradeEntity with JsonConvert<UpgradeEntity> {
  int success;
  String message;
  UpgradeObject object;
}

class UpgradeObject with JsonConvert<UpgradeObject> {
  String id;
  String description;
  @JSONField(name: "software_id")
  String softwareId;
  @JSONField(name: "force_update")
  String forceUpdate;
  @JSONField(name: "file_url")
  String fileUrl;
  @JSONField(name: "file_size")
  String fileSize;
  @JSONField(name: "version_number")
  String versionNumber;
  @JSONField(name: "change_log")
  String changeLog;
  @JSONField(name: "release_time")
  String releaseTime;
  @JSONField(name: "release_date_string")
  String releaseDateString;
}
