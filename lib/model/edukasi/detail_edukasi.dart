part 'detail_edukasi.g.dart';
class DetailEdukasi{
  DetailEdukasi(){}
  int? id;
  String? kategori;
  String? judul;
  String? content;
  String? deskripsi;
  String? tgl_publish;
  String? image;
  String? creator;

  factory DetailEdukasi.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}