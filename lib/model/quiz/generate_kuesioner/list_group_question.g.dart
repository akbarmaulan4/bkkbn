
part of 'list_group_question.dart';

ListGroupQuestion _$fromJson(Map<String, dynamic> json) {
  return ListGroupQuestion()
    ..data =  (json['data'] as List)
        ?.map((e) =>
    e == null ? null : GroupQuestion.fromJson(e as Map<String, dynamic>))?.toList()
  ;
}

Map<String, dynamic> _$toJson(ListGroupQuestion instance) =>
    <String, dynamic>{
      'data': instance.data
    };