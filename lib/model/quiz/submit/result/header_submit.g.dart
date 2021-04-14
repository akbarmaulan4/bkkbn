part of 'header_submit.dart';
HeaderSubmit _$fromJson(Map<String, dynamic> json) {
  return HeaderSubmit()
    ..kuis_id = json['kuis_id'] != null ? json['kuis_id'] is num ? (json['kuis_id'] as num)?.toInt() ?? 0: int.tryParse(json['kuis_id'] as String) ?? -1: -1
    ..result_id = json['result_id'] != null ? json['result_id'] is num ? (json['result_id'] as num)?.toInt() ?? 0: int.tryParse(json['result_id'] as String) ?? -1: -1
    ..kuis_code = json['kuis_code'] as String ?? ''
    ..rating = json['rating'] as String ?? ''
    ..rating_color = json['rating_color'] as String ?? ''
    ..tanggal_kuis = json['tanggal_kuis'] as String ?? ''
    ..label = json['label'] as String ?? ''
    ..deskripsi = json['deskripsi'] as String ?? ''
    ..kuis_max_nilai = json['kuis_max_nilai'] as String ?? ''
    ..member_kuis_nilai = json['member_kuis_nilai'] as String ?? ''
    ..url = json['url'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(HeaderSubmit instance) =>
    <String, dynamic>{
      'kuis_id': instance.kuis_id,
      'result_id': instance.result_id,
      'kuis_code': instance.kuis_code,
      'rating': instance.rating,
      'rating_color': instance.rating_color,
      'tanggal_kuis': instance.tanggal_kuis,
      'label': instance.label,
      'deskripsi': instance.deskripsi,
      'kuis_max_nilai': instance.kuis_max_nilai,
      'member_kuis_nilai': instance.member_kuis_nilai,
      'url': instance.url,
    };