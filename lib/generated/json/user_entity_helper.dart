import 'package:flutter_project/entity/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
  if (json['success'] != null) {
    data.success = json['success']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  if (json['object'] != null) {
    data.object = new UserObject().fromJson(json['object']);
  }
  return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['success'] = entity.success;
  data['message'] = entity.message;
  if (entity.object != null) {
    data['object'] = entity.object.toJson();
  }
  return data;
}

userObjectFromJson(UserObject data, Map<String, dynamic> json) {
  if (json['menuFlags'] != null) {
    data.menuFlags = new List<UserObjectmanuFlags>();
    (json['menuFlags'] as List).forEach((v) {
      data.menuFlags.add(new UserObjectmanuFlags().fromJson(v));
    });
  }
  if (json['sessionId'] != null) {
    data.sessionId = json['sessionId']?.toString();
  }
  if (json['user'] != null) {
    data.user = new UserObjectUser().fromJson(json['user']);
  }
  return data;
}

Map<String, dynamic> userObjectToJson(UserObject entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.menuFlags != null) {
    data['menuFlags'] = entity.menuFlags.map((v) => v.toJson()).toList();
  }
  data['sessionId'] = entity.sessionId;
  if (entity.user != null) {
    data['user'] = entity.user.toJson();
  }
  return data;
}

userObjectmanuFlagsFromJson(
    UserObjectmanuFlags data, Map<String, dynamic> json) {
  if (json['menuFlag'] != null) {
    data.menuFlag = json['menuFlag']?.toString();
  }
  return data;
}

Map<String, dynamic> userObjectmanuFlagsToJson(UserObjectmanuFlags entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['menuFlag'] = entity.menuFlag;
  return data;
}

userObjectUserFromJson(UserObjectUser data, Map<String, dynamic> json) {
  if (json['sessionId'] != null) {
    data.sessionId = json['sessionId']?.toString();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toString();
  }
  if (json['roleId'] != null) {
    data.roleId = json['roleId']?.toString();
  }
  if (json['schoolId'] != null) {
    data.schoolId = json['schoolId']?.toString();
  }
  if (json['group_id'] != null) {
    data.groupId = json['group_id']?.toString();
  }
  if (json['api_url'] != null) {
    data.apiUrl = json['api_url']?.toString();
  }
  if (json['version'] != null) {
    data.version = json['version']?.toString();
  }
  if (json['schoolName'] != null) {
    data.schoolName = json['schoolName']?.toString();
  }
  if (json['semesterName'] != null) {
    data.semesterName = json['semesterName']?.toString();
  }
  if (json['teacherId'] != null) {
    data.teacherId = json['teacherId']?.toString();
  }
  if (json['teacherName'] != null) {
    data.teacherName = json['teacherName']?.toString();
  }
  if (json['userName'] != null) {
    data.userName = json['userName']?.toString();
  }
  if (json['time'] != null) {
    data.time = json['time']?.toInt();
  }
  if (json['sig'] != null) {
    data.sig = json['sig']?.toString();
  }
  if (json['trial'] != null) {
    data.trial = json['trial']?.toInt();
  }
  return data;
}

Map<String, dynamic> userObjectUserToJson(UserObjectUser entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['sessionId'] = entity.sessionId;
  data['id'] = entity.id;
  data['roleId'] = entity.roleId;
  data['schoolId'] = entity.schoolId;
  data['group_id'] = entity.groupId;
  data['api_url'] = entity.apiUrl;
  data['version'] = entity.version;
  data['schoolName'] = entity.schoolName;
  data['semesterName'] = entity.semesterName;
  data['teacherId'] = entity.teacherId;
  data['teacherName'] = entity.teacherName;
  data['userName'] = entity.userName;
  data['time'] = entity.time;
  data['sig'] = entity.sig;
  data['trial'] = entity.trial;
  return data;
}
