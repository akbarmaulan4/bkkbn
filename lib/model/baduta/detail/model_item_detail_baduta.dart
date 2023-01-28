part 'model_item_detail_baduta.g.dart';
class ModelItemDetailBaduta{
  ModelItemDetailBaduta(){}
  String? label;
  String? value;
  String? color;

  factory ModelItemDetailBaduta.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}