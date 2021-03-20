
import 'package:kua/model/quiz/generate_kuesioner/list_answers.dart';
part 'pertanyaan.g.dart';
class Pertanyaan{

  Pertanyaan(){}
  String kuis_id;
  String header_id;
  int pertanyaan_id;
  String title;
  String tipe;
  String api;
  String params;
  String value;
  String file_name;
  List<ListAnswer> element;

  factory Pertanyaan.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}