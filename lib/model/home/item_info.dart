part 'item_info.g.dart';
class ItemInfo{
  ItemInfo(){}
  String content;
  String link;

  factory ItemInfo.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}