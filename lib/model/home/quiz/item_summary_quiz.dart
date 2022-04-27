part 'item_summary_quiz.g.dart';
class ItemSummaryQuiz{
  ItemSummaryQuiz(){}
  int id;
  String message;
  String type;

  factory ItemSummaryQuiz.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}