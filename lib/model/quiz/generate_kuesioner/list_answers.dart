part 'list_answers.g.dart';
class ListAnswer {
  ListAnswer(){}
  int id;
  String option;

  factory ListAnswer.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}