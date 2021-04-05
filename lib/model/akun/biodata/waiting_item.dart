part 'waiting_item.g.dart';
class WaitingItem{
  WaitingItem(){}
  int sender_id;
  String pic;
  String name;
  String tgl_lahir;
  String kota;

  factory WaitingItem.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}