part 'riwayat_item.g.dart';
class RiwayatItem{
  RiwayatItem(){}
  int? id;
  String? kuis_title;
  String? member_kuis_nilai;
  String? kuis_max_nilai;
  String? label;
  String? deskripsi;
  String? rating;
  String? rating_color;
  String? created_at;

  factory RiwayatItem.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}