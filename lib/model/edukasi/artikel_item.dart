part 'artikel_item.g.dart';
class ArtikelItem{
  ArtikelItem(){}
  int? id;
  String? kategori;
  String? judul;
  String? deskripsi;
  String? tgl_publish;
  String? url;
  String? image;
  String? creator;

  factory ArtikelItem.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}