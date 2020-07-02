import 'package:flutter_project/entity/upgrade_entity.dart';

upgradeEntityFromJson(UpgradeEntity data, Map<String, dynamic> json) {
  if (json['success'] != null) {
    data.success = json['success']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  if (json['object'] != null) {
    data.object = new UpgradeObject().fromJson(json['object']);
  }
  return data;
}

Map<String, dynamic> upgradeEntityToJson(UpgradeEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['success'] = entity.success;
  data['message'] = entity.message;
  if (entity.object != null) {
    data['object'] = entity.object.toJson();
  }
  return data;
}

upgradeObjectFromJson(UpgradeObject data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toString();
  }
  if (json['description'] != null) {
    data.description = json['description']?.toString();
  }
  if (json['software_id'] != null) {
    data.softwareId = json['software_id']?.toString();
  }
  if (json['force_update'] != null) {
    data.forceUpdate = json['force_update']?.toString();
  }
  if (json['file_url'] != null) {
    data.fileUrl = json['file_url']?.toString();
  }
  if (json['file_size'] != null) {
    data.fileSize = json['file_size']?.toString();
  }
  if (json['version_number'] != null) {
    data.versionNumber = json['version_number']?.toString();
  }
  if (json['change_log'] != null) {
    data.changeLog = json['change_log']?.toString();
  }
  if (json['release_time'] != null) {
    data.releaseTime = json['release_time']?.toString();
  }
  if (json['release_date_string'] != null) {
    data.releaseDateString = json['release_date_string']?.toString();
  }
  return data;
}

Map<String, dynamic> upgradeObjectToJson(UpgradeObject entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['description'] = entity.description;
  data['software_id'] = entity.softwareId;
  data['force_update'] = entity.forceUpdate;
  data['file_url'] = entity.fileUrl;
  data['file_size'] = entity.fileSize;
  data['version_number'] = entity.versionNumber;
  data['change_log'] = entity.changeLog;
  data['release_time'] = entity.releaseTime;
  data['release_date_string'] = entity.releaseDateString;
  return data;
}
