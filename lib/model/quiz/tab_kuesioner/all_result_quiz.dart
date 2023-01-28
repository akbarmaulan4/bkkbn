import 'package:kua/model/quiz/tab_kuesioner/data_kuesioner.dart';
part 'all_result_quiz.g.dart';
class AllResultQuiz{
  AllResultQuiz(){}
  List<DataKuesioner>? data;

  factory AllResultQuiz.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}