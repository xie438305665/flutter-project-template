import 'package:flutter_project/entity/sign_entity.dart';

signEntityFromJson(SignEntity data, Map<String, dynamic> json) {
  if (json['success'] != null) {
    data.success = json['success']?.toInt();
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  if (json['data'] != null) {
    data.data = new SignData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> signEntityToJson(SignEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['success'] = entity.success;
  data['message'] = entity.message;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

signDataFromJson(SignData data, Map<String, dynamic> json) {
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['grade'] != null) {
    data.grade = json['grade']?.toString();
  }
  if (json['typeName'] != null) {
    data.typeName = json['typeName']?.toString();
  }
  if (json['classes'] != null) {
    data.classes = new List<SignDataClass>();
    (json['classes'] as List).forEach((v) {
      data.classes.add(new SignDataClass().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> signDataToJson(SignData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = entity.name;
  data['grade'] = entity.grade;
  data['typeName'] = entity.typeName;
  if (entity.classes != null) {
    data['classes'] = entity.classes.map((v) => v.toJson()).toList();
  }
  return data;
}

signDataClassFromJson(SignDataClass data, Map<String, dynamic> json) {
  if (json['className'] != null) {
    data.className = json['className']?.toString();
  }
  if (json['productName'] != null) {
    data.productName = json['productName']?.toString();
  }
  if (json['productType'] != null) {
    data.productType = json['productType']?.toInt();
  }
  if (json['classId'] != null) {
    data.classId = json['classId']?.toString();
  }
  if (json['isSigned'] != null) {
    data.isSigned = json['isSigned']?.toInt();
  }
  return data;
}

Map<String, dynamic> signDataClassToJson(SignDataClass entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['className'] = entity.className;
  data['productName'] = entity.productName;
  data['productType'] = entity.productType;
  data['classId'] = entity.classId;
  data['isSigned'] = entity.isSigned;
  return data;
}
