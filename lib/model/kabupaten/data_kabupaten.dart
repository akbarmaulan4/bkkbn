part 'data_kabupaten.g.dart';
class DataKabupaten{
  DataKabupaten(){}
  int id;
  String provinsi_kode;
  String kabupaten_kode;
  String nama;
  String status;

  factory DataKabupaten.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}