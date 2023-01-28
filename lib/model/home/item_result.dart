part 'item_result.g.dart';
class ItemResult{
  ItemResult(){}
  int? kuis_id;
  int? result_id;
  String? kuis_title;
  String? rating;
  String? rating_color;
  String? member_kuis_nilai;
  String? kuis_max_nilai;
  String? label;
  String? tgl_kuis;

  factory ItemResult.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}