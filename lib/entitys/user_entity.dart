import 'package:flutter/material.dart';
import 'package:zsy/generated/json/base/json_convert_content.dart';
import 'package:zsy/generated/json/base/json_filed.dart';

class UserEntity with JsonConvert<UserEntity> {
	int success;
	String message;
	UserObject object;
}

class UserObject with JsonConvert<UserObject> {
	List<UserObjectmanuFlags> menuFlags;
	String sessionId;
	UserObjectUser user;
}

class UserObjectmanuFlags with JsonConvert<UserObjectmanuFlags> {
	String menuFlag;
}

class UserObjectUser with JsonConvert<UserObjectUser>{
	String sessionId;
	String id;
	String roleId;
	String schoolId;
	@JSONField(name: "group_id")
	String groupId;
	@JSONField(name: "api_url")
	String apiUrl;
	String version;
	String schoolName;
	String semesterName;
	String teacherId;
	String teacherName;
	String userName;
	int time;
	String sig;
	int trial;
}
