part 'model_item_riwayat.g.dart';
class ModelItemRiwayat{
  ModelItemRiwayat(){}
  String label;
  String value;
  String color;
  String label_color;

  factory ModelItemRiwayat.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}