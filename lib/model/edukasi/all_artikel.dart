
import 'package:kua/model/edukasi/artikel_item.dart';
part 'all_artikel.g.dart';
class AllArtikel{
  AllArtikel(){}
  List<ArtikelItem>? data;

  factory AllArtikel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}