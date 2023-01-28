
import 'data_kabupaten.dart';

part 'all_kabupaten.g.dart';

class AllKabupaten{
  AllKabupaten(){}
  List<DataKabupaten>? data;

  factory AllKabupaten.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}