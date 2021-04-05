part of 'chat_item.dart';
ChatItem _$fromJson(Map<String, dynamic> json) {
  return ChatItem()
    ..header = json['header'] as String ?? ''
    ..child = (json['child'] as List)
        ?.map((e) =>
    e == null ? null : ChatMessage.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(ChatItem instance) =>
    <String, dynamic>{
      'header': instance.header,
      'child': instance.child,
    };