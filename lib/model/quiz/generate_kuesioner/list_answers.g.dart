part of 'list_answers.dart';
ListAnswer _$fromJson(Map<String, dynamic> json) {
  return ListAnswer()
    ..id = json['id'] as int
    ..option = json['option'] as String
  ;
}

Map<String, dynamic> _$toJson(ListAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'option': instance.option
    };