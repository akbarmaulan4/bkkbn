part of 'couple_item.dart';
CoupleItem _$fromJson(Map<String, dynamic> json) {
  return CoupleItem()
    ..id = json['id'] as int ?? -1
    ..pic = json['pic'] as String ?? ''
    ..name = json['name'] as String ?? ''
    ..tgl_lahir = json['tgl_lahir'] as String ?? ''
    ..kota = json['kota'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(CoupleItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pic': instance.pic,
      'name': instance.name,
      'tgl_lahir': instance.tgl_lahir,
      'kota': instance.kota
    };