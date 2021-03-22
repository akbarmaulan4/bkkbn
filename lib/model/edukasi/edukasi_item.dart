part 'edukasi_item.g.dart';
class EdukasiItem{
  EdukasiItem(){}
  int id;
  String kategori;
  String deskripsi;
  String created_at;
  String creator;

  factory EdukasiItem.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}