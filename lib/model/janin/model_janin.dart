part 'model_janin.g.dart';
class ModelJanin{
  ModelJanin(){}
  int? id;
  String? name;
  String? status;
  String? hpl;

  factory ModelJanin.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}