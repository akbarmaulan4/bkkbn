
import 'package:kua/model/baduta/detail/model_item_detail_baduta.dart';
part 'model_detail_baduta.g.dart';
class ModelDetailBaduta{
  ModelDetailBaduta(){}
  String label;
  List<ModelItemDetailBaduta> details;

  factory ModelDetailBaduta.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}