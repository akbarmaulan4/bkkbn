part 'item_edukasi.g.dart';
class ItemEdukasi{
  ItemEdukasi(){}
  int id;
  String title;
  String image;
  String kategori;

  factory ItemEdukasi.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}