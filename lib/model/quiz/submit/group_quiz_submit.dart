import 'package:kua/model/quiz/submit/pertanyaan_submit.dart';

part 'group_quiz_submit.g.dart';
class GroupQuizSubmit{
  GroupQuizSubmit(){}
  String? kuis_id;
  String? header_id;
  String? jenis;
  List<PertanyaanSubmit>? pertanyaan;

  factory GroupQuizSubmit.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}