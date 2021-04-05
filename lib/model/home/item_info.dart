import 'package:kua/model/home/additional.dart';

part 'item_info.g.dart';
class ItemInfo{
  ItemInfo(){}
  String content;
  String link;
  List<Additional> additional;

  factory ItemInfo.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}