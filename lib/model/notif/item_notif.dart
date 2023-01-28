part 'item_notif.g.dart';
class ItemNotif{
  ItemNotif(){}
  String? title;
  String? content;
  String? waktu;
  String? tipe;

  factory ItemNotif.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}