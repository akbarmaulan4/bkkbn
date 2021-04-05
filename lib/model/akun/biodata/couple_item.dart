part 'couple_item.g.dart';
class CoupleItem{
  CoupleItem(){}
  int id;
  String name;
  String tgl_lahir;
  String pic;
  String kota;

  factory CoupleItem.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}