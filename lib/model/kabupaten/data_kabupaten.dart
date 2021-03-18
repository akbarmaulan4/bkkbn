part 'data_kabupaten.g.dart';
class DataKabupaten{
  DataKabupaten(){}
  int id;
  String provinsi_id;
  String nama;

  factory DataKabupaten.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}