part of 'item_notif.dart';
ItemNotif _$fromJson(Map<String, dynamic> json) {
  return ItemNotif()
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..waktu = json['waktu'] as String
    ..tipe = json['tipe'] as String
  ;
}

Map<String, dynamic> _$toJson(ItemNotif instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'waktu': instance.waktu,
      'tipe': instance.tipe,
    };