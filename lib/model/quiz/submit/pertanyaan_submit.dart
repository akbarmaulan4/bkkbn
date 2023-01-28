part 'pertanyaan_submit.g.dart';
class PertanyaanSubmit{

  PertanyaanSubmit(){}
  String? kuis_id;
  String? header_id;
  int? pertanyaan_id;
  String? tipe;
  String? value;
  String? file_name;

  factory PertanyaanSubmit.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}