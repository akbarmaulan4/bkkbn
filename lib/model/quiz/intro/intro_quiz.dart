part 'intro_quiz.g.dart';
class IntroQuiz{
  IntroQuiz(){}
  int id;
  String title;
  String deskripsi;

  factory IntroQuiz.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}