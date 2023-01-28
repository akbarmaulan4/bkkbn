import 'package:kua/model/kelurahan/data_kelurahan.dart';
part 'all_kelurahan.g.dart';
class AllKelurahan{
  AllKelurahan(){}
  List<DataKelurahan>? data;

  factory AllKelurahan.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}