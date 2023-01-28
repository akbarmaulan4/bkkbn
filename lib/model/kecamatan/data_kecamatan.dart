part 'data_kecamatan.g.dart';

class DataKecamatan{
  DataKecamatan(){}
  int? id;
  String? kabupaten_kode;
  String? kecamatan_kode;
  String? nama;
  String? status;

  factory DataKecamatan.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}