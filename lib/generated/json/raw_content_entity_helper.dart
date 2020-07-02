import 'package:flutter_project/entity/raw_content_entity.dart';

rawContentEntityFromJson(RawContentEntity data, Map<String, dynamic> json) {
  if (json['type'] != null) {
    data.type = json['type']?.toString();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toString();
  }
  if (json['subject_id'] != null) {
    data.subjectId = json['subject_id']?.toInt();
  }
  if (json['class_id'] != null) {
    data.classId = json['class_id']?.toString();
  }
  return data;
}

Map<String, dynamic> rawContentEntityToJson(RawContentEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['type'] = entity.type;
  data['id'] = entity.id;
  data['subject_id'] = entity.subjectId;
  data['class_id'] = entity.classId;
  return data;
}
