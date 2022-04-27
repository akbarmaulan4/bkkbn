import 'package:kua/model/janin/riwayat/model_item_riwayat_janin.dart';

part 'model_detail_riwat_janin.g.dart';
class ModelDetailRiwayatJanin{
  ModelDetailRiwayatJanin(){}
  String label;
  List<ModelItemRiwayatJanin> details;

  factory ModelDetailRiwayatJanin.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}