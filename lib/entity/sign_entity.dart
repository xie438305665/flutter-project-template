import 'package:flutter_project/generated/json/base/json_convert_content.dart';

class SignEntity with JsonConvert<SignEntity> {
  int success;
  String message;
  SignData data;
}

class SignData with JsonConvert<SignData> {
  String name;
  String grade;
  String typeName;
  List<SignDataClass> classes;
}

class SignDataClass with JsonConvert<SignDataClass> {
  String className;
  String productName;
  int productType;
  String classId;
  int isSigned;
}
