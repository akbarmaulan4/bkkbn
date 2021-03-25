part of 'bantuan_item.dart';
BantuanItem _$fromJson(Map<String, dynamic> json) {
  return BantuanItem()
    ..id = json['id'] as int ?? -1
    ..title = json['title'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(BantuanItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };