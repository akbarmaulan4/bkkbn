part 'type_chat_model.g.dart';
class TypeChatModel{
  TypeChatModel(){}
  String type;
  String name;
  String status;

  factory TypeChatModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}