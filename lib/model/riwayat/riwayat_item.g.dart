part of 'riwayat_item.dart';
RiwayatItem _$fromJson(Map<String, dynamic> json) {
  return RiwayatItem()
    ..id = json['id'] as int
    ..kuis_title = json['kuis_title'] as String
    ..member_kuis_nilai = json['member_kuis_nilai'] as String
    ..kuis_max_nilai = json['kuis_max_nilai'] as String
    ..label = json['label'] as String
    ..deskripsi = json['deskripsi'] as String
    ..rating = json['rating'] as String
    ..rating_color = json['rating_color'] as String
    ..created_at = json['created_at'] as String
  ;
}

Map<String, dynamic> _$toJson(RiwayatItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kuis_title': instance.kuis_title,
      'member_kuis_nilai': instance.member_kuis_nilai,
      'kuis_max_nilai': instance.kuis_max_nilai,
      'label': instance.label,
      'deskripsi': instance.deskripsi,
      'rating': instance.rating,
      'rating_color': instance.rating_color,
      'created_at': instance.created_at
    };