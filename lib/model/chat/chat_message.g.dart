part of 'chat_message.dart';
ChatMessage _$fromJson(Map<String, dynamic> json) {
  return ChatMessage()
    ..member_id = json['member_id'] as String ?? ''
    ..message = json['message'] as String ?? ''
    ..pic = json['pic'] as String ?? ''
    ..jabatan = json['jabatan'] as String ?? ''
    ..tanggal = json['tanggal'] as String ?? ''
    ..jam = json['jam'] as String ?? ''
    ..action = json['action'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(ChatMessage instance) =>
    <String, dynamic>{
      'member_id': instance.member_id,
      'message': instance.message,
      'pic': instance.pic,
      'jabatan': instance.jabatan,
      'tanggal': instance.tanggal,
      'jam': instance.jam,
      'action': instance.action
    };