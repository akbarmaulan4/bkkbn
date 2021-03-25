
import 'package:kua/model/akun/bantuan/detail_bantuan_model.dart';
part 'all_bantuan_detail.g.dart';
class AllBantuanDetail{
  AllBantuanDetail(){}
  List<DetailBantuanModel> data;

  factory AllBantuanDetail.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}