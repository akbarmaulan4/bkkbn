import 'package:kua/model/quiz/generate_kuesioner/group_question.dart';
part 'list_group_question.g.dart';

class ListGroupQuestion{
  ListGroupQuestion(){}
  List<GroupQuestion> data;

  factory ListGroupQuestion.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}