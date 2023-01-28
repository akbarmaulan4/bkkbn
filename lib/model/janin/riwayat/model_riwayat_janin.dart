import 'package:kua/model/janin/riwayat/model_item_riwayat.dart';

part 'model_riwayat_janin.g.dart';
class ModelRiwayatJanin{
  ModelRiwayatJanin(){}
  int? id;
  String? name;
  List<ModelItemRiwayat>? details;

  factory ModelRiwayatJanin.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}