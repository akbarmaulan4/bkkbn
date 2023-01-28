part 'model_item_anak.g.dart';
class ModelItemAnak{
  ModelItemAnak(){}
  int? id;
  String? nama;

  factory ModelItemAnak.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}