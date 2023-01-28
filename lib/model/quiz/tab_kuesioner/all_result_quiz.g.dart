part of 'all_result_quiz.dart';
AllResultQuiz _$fromJson(Map<String, dynamic> json) {
  return AllResultQuiz()
    ..data =  (json['data'] as List)
        .map((e) =>
    e == null ? null : DataKuesioner.fromJson(e as Map<String, dynamic>)).cast<DataKuesioner>()
        .toList()
  ;
}

Map<String, dynamic> _$toJson(AllResultQuiz instance) =>
    <String, dynamic>{
      'data': instance.data
    };