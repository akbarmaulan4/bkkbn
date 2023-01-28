
import 'package:kua/model/edukasi/edukasi_item.dart';
part 'all_category_edukasi.g.dart';
class AllCategoryEdukasi{
  AllCategoryEdukasi(){}
  List<EdukasiItem>? data;

  factory AllCategoryEdukasi.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}