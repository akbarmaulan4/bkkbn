
import 'package:kua/model/akun/biodata/couple_item.dart';
part 'all_couple.g.dart';
class AllCouple{
  AllCouple(){}
  List<CoupleItem>? data;

  factory AllCouple.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}