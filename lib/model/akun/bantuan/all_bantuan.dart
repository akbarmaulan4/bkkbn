
import 'package:kua/model/akun/bantuan/bantuan_item.dart';
part 'all_bantuan.g.dart';
class AllBantuan{
  AllBantuan(){}
  List<BantuanItem>? data;

  factory AllBantuan.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}