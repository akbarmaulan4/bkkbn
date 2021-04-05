
part of 'pending_item.dart';
PendingItem _$fromJson(Map<String, dynamic> json) {
  return PendingItem()
    ..request_id = json['request_id'] as int ?? -1
    ..pic = json['pic'] as String ?? ''
    ..name = json['name'] as String ?? ''
    ..tgl_lahir = json['tgl_lahir'] as String ?? ''
    ..kota = json['kota'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(PendingItem instance) =>
    <String, dynamic>{
      'request_id': instance.request_id,
      'pic': instance.pic,
      'name': instance.name,
      'tgl_lahir': instance.tgl_lahir,
      'kota': instance.kota
    };