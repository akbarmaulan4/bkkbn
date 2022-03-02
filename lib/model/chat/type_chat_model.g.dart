part of 'type_chat_model.dart';
TypeChatModel _$fromJson(Map<String, dynamic> json) {
  return TypeChatModel()
    ..type = json['type'] as String ?? ''
    ..name = json['name'] as String ?? ''
    ..status = json['status'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(TypeChatModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'status': instance.status,
    };