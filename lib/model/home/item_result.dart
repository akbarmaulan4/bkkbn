part 'item_result.g.dart';
class ItemResult{
  ItemResult(){}
  String id;
  String rating;
  String rating_color;
  String member_kuis_nilai;
  String kuis_max_nilai;
  String label;
  String kuis_title;

  factory ItemResult.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}