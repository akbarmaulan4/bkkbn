part of 'file_detail_submit.dart';
FileDetailSubmit _$fromJson(Map<String, dynamic> json) {
  return FileDetailSubmit()
    ..name = json['name'] as String ?? ''
    ..file = json['file'] as String ?? ''
      ;
}

Map<String, dynamic> _$toJson(FileDetailSubmit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'file': instance.file
    };