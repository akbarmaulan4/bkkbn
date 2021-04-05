part of 'waiting_item.dart';
WaitingItem _$fromJson(Map<String, dynamic> json) {
  return WaitingItem()
    ..sender_id = json['sender_id'] as int ?? -1
    ..pic = json['pic'] as String ?? ''
    ..name = json['name'] as String ?? ''
    ..tgl_lahir = json['tgl_lahir'] as String ?? ''
    ..kota = json['kota'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(WaitingItem instance) =>
    <String, dynamic>{
      'sender_id': instance.sender_id,
      'pic': instance.pic,
      'name': instance.name,
      'tgl_lahir': instance.tgl_lahir,
      'kota': instance.kota
    };