part of 'item_summary_quiz.dart';
ItemSummaryQuiz _$fromJson(Map<String, dynamic> json) {
  return ItemSummaryQuiz()
    ..id = json['id'] as int
    ..message = json['message'] as String
    ..type = json['type'] as String
  ;
}

Map<String, dynamic> _$toJson(ItemSummaryQuiz instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'type': instance.type,
    };