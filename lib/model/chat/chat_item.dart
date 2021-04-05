
import 'package:kua/model/chat/chat_message.dart';
part 'chat_item.g.dart';
class ChatItem{
  ChatItem(){}
  String header;
  List<ChatMessage> child;

  factory ChatItem.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}