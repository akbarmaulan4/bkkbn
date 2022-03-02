part of 'own.dart';
Own _$fromJson(Map<String, dynamic> json) {
  return Own()
    ..id = json['id'] as int ?? -1
    ..name = json['name'] as String ?? ''
    ..tgl_lahir = json['tgl_lahir'] as String ?? ''
    ..gender = json['gender'] as String ?? ''
    ..profile_id = json['profile_id'] as String ?? ''
    ..pic = json['pic'] as String ?? ''
    ..kota = json['kota'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(Own instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tgl_lahir': instance.tgl_lahir,
      'gender': instance.gender,
      'profile_id': instance.profile_id,
      'pic': instance.pic,
      'kota': instance.kota,
    };