part 'pasangan_item.g.dart';
class PasanganItem{
  PasanganItem(){}
  int id;
  String title;
  String created_at;
  int result_id;
  String label;
  String rating;
  String background;
  int point;
  int max_point;
  String deskripsi;

  factory PasanganItem.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}