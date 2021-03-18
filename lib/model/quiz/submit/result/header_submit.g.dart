part of 'header_submit.dart';
HeaderSubmit _$fromJson(Map<String, dynamic> json) {
  return HeaderSubmit()
    ..kuis_code = json['kuis_code'] as String ?? ''
    ..rating = json['rating'] as String ?? ''
    ..rating_color = json['rating_color'] as String ?? ''
    ..created_at = json['created_at'] as String ?? ''
    ..kuis_max_nilai = json['kuis_max_nilai'] as String ?? ''
    ..member_kuis_nilai = json['member_kuis_nilai'] as String ?? ''
    ..url = json['url'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(HeaderSubmit instance) =>
    <String, dynamic>{
      'kuis_code': instance.kuis_code,
      'rating': instance.rating,
      'rating_color': instance.rating_color,
      'created_at': instance.created_at,
      'kuis_max_nilai': instance.kuis_max_nilai,
      'member_kuis_nilai': instance.member_kuis_nilai,
      'url': instance.url,
    };