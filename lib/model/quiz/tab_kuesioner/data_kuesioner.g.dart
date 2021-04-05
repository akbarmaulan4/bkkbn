part of 'data_kuesioner.dart';
DataKuesioner _$fromJson(Map<String, dynamic> json) {
  return DataKuesioner()
    ..id = json['id'] as int ?? -1
    ..title = json['title'] as String ?? ''
    ..created_at = json['created_at'] as String ?? ''
    ..thumbnail = json['thumbnail'] as String ?? ''
    ..rating = json['rating'] as String ?? ''
    ..background = json['background'] as String ?? ''
    ..action = json['action'] as String ?? ''
    ..total_pertanyaan = json['total_pertanyaan'] as int ?? 0
    ..answered = json['answered'] as int ?? 0
    ..ulasan = json['ulasan'] as int ?? 0
    ..result_id = json['result_id'] as int ?? -1
  ;
}

Map<String, dynamic> _$toJson(DataKuesioner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'created_at': instance.created_at,
      'thumbnail': instance.thumbnail,
      'rating': instance.rating,
      'background': instance.background,
      'action': instance.action,
      'total_pertanyaan': instance.total_pertanyaan,
      'answered': instance.answered,
      'ulasan': instance.ulasan,
      'result_id': instance.result_id
    };