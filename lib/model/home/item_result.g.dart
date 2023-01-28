part of 'item_result.dart';
ItemResult _$fromJson(Map<String, dynamic> json) {
  return ItemResult()
    ..kuis_id = json['kuis_id'] as int
    ..result_id = json['result_id'] as int
    ..kuis_title = json['kuis_title'] as String
    ..rating = json['rating'] as String
    ..rating_color = json['rating_color'] as String
    ..member_kuis_nilai = json['member_kuis_nilai'] as String
    ..kuis_max_nilai = json['kuis_max_nilai'] as String
    ..label = json['label'] as String
    ..tgl_kuis = json['tgl_kuis'] as String
  ;
}

Map<String, dynamic> _$toJson(ItemResult instance) =>
    <String, dynamic>{
      'kuis_id': instance.kuis_id,
      'result_id': instance.result_id,
      'kuis_title': instance.kuis_title,
      'rating': instance.rating,
      'rating_color': instance.rating_color,
      'member_kuis_nilai': instance.member_kuis_nilai,
      'kuis_max_nilai': instance.kuis_max_nilai,
      'label': instance.label,
      'tgl_kuis': instance.tgl_kuis,
    };