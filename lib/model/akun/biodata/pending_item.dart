part 'pending_item.g.dart';
class PendingItem{
  PendingItem(){}
  int request_id;
  String pic;
  String name;
  String tgl_lahir;
  String kota;

  factory PendingItem.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}