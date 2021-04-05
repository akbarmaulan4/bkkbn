part 'header_submit.g.dart';
class HeaderSubmit{
  HeaderSubmit(){}
  int kuis_id;
  String kuis_code;
  String tanggal_kuis;
  String label;
  String deskripsi;
  String rating;
  String rating_color;
  String kuis_max_nilai;
  String member_kuis_nilai;
  String url;

  factory HeaderSubmit.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}