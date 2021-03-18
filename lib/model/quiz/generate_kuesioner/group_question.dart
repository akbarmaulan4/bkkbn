
import 'package:kua/model/quiz/generate_kuesioner/pertanyaan.dart';

part 'group_question.g.dart';
class GroupQuestion{
  GroupQuestion(){}
  String kuis_id;
  String header_id;
  String jenis;
  String deskripsi;
  String caption;
  List<Pertanyaan> pertanyaan;

  factory GroupQuestion.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}
