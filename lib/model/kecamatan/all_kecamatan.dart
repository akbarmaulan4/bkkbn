
import 'package:kua/model/kecamatan/data_kecamatan.dart';
part 'all_kecamatan.g.dart';

class AllKecamatan{
  AllKecamatan(){}
  List<DataKecamatan> data;

  factory AllKecamatan.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}