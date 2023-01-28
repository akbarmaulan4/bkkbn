part 'model_item_riwayat_janin.g.dart';
class ModelItemRiwayatJanin{
  ModelItemRiwayatJanin(){}
  String? label;
  String? value;

  factory ModelItemRiwayatJanin.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}