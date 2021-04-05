part of 'pasangan_item.dart';
PasanganItem _$fromJson(Map<String, dynamic> json) {
  return PasanganItem()
    ..id = json['kuis_id'] as int ?? -1
    ..title = json['title'] as String ?? ''
    ..created_at = json['created_at'] as String ?? ''
    ..result_id = json['result_id'] as int ?? -1
    ..label = json['label'] as String ?? ''
    ..rating = json['rating'] as String ?? ''
    ..background = json['background'] as String ?? ''
    ..point = json['point'] != null ? json['point'] is num ? (json['point'] as num)?.toInt() ?? 0: int.tryParse(json['point'] as String) ?? -1: -1 //json['point'] as String ?? ''
    ..max_point = json['max_point'] != null ? json['max_point'] is num ? (json['max_point'] as num)?.toInt() ?? 0: int.tryParse(json['max_point'] as String) ?? -1: -1
    ..deskripsi = json['deskripsi'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(PasanganItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'created_at': instance.created_at,
      'result_id': instance.result_id,
      'label': instance.label,
      'rating': instance.rating,
      'background': instance.background,
      'point': instance.point,
      'max_point': instance.max_point,
      'deskripsi': instance.deskripsi,
    };