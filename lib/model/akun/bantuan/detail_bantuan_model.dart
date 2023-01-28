part 'detail_bantuan_model.g.dart';
class DetailBantuanModel{
  DetailBantuanModel(){}
  int? id;
  String? title;
  String? content;
  String? image;

  factory DetailBantuanModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}