import 'package:flutter_project/generated/json/base/json_convert_content.dart';
import 'package:flutter_project/generated/json/base/json_filed.dart';

class RawContentEntity with JsonConvert<RawContentEntity> {
  String type;
  String id;
  @JSONField(name: "subject_id")
  int subjectId;
  @JSONField(name: "class_id")
  String classId;
}
