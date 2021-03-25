part of 'item_result.dart';
ItemResult _$fromJson(Map<String, dynamic> json) {
  return ItemResult()
    ..id = json['id'] as String ?? ''
    ..rating = json['rating'] as String ?? ''
    ..rating_color = json['rating_color'] as String ?? ''
    ..member_kuis_nilai = json['member_kuis_nilai'] as String ?? ''
    ..kuis_max_nilai = json['kuis_max_nilai'] as String ?? ''
    ..label = json['label'] as String ?? ''
    ..kuis_title = json['kuis_title'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(ItemResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'rating_color': instance.rating_color,
      'member_kuis_nilai': instance.member_kuis_nilai,
      'kuis_max_nilai': instance.kuis_max_nilai,
      'label': instance.label,
      'kuis_title': instance.kuis_title,
    };