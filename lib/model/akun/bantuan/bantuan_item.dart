part 'bantuan_item.g.dart';
class BantuanItem{
  BantuanItem(){}
  int? id;
  String? title;

  factory BantuanItem.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}