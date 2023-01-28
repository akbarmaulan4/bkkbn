part 'chat_message.g.dart';
class ChatMessage{
  ChatMessage(){}
  String? member_id;
  String? message;
  String? pic;
  String? jabatan;
  String? tanggal;
  String? jam;
  String? action;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}