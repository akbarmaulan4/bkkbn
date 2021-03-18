part of 'data_kuesioner.dart';
DataKuesioner _$fromJson(Map<String, dynamic> json) {
  return DataKuesioner()
    ..id = json['id'] as int ?? -1
    ..title = json['title'] as String ?? ''
    ..created_at = json['created_at'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DataKuesioner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'created_at': instance.created_at
    };