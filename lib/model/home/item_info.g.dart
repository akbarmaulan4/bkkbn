part of 'item_info.dart';
ItemInfo _$fromJson(Map<String, dynamic> json) {
  return ItemInfo()
    ..content = json['content'] as String ?? ''
    ..link = json['link'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(ItemInfo instance) =>
    <String, dynamic>{
      'content': instance.content,
      'link': instance.link,
    };