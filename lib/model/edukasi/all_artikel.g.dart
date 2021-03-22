part of 'all_artikel.dart';
AllArtikel _$fromJson(Map<String, dynamic> json) {
  return AllArtikel()
    ..data =  (json['data'] as List)
        ?.map((e) =>
    e == null ? null : ArtikelItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(AllArtikel instance) =>
    <String, dynamic>{
      'data': instance.data
    };