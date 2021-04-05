part of 'item_info.dart';
ItemInfo _$fromJson(Map<String, dynamic> json) {
  return ItemInfo()
    ..content = json['content'] as String ?? ''
    ..link = json['link'] as String ?? ''
    ..additional = (json['additional'] as List)?.map((e) => e == null ? null : Additional.fromJson(e as Map<String, dynamic>))?.toList()
  ;
}

Map<String, dynamic> _$toJson(ItemInfo instance) =>
    <String, dynamic>{
      'content': instance.content,
      'link': instance.link,
      'additional': instance.additional,
    };