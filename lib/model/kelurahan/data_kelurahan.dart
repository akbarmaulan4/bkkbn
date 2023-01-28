part 'data_kelurahan.g.dart';
class DataKelurahan{
  DataKelurahan(){}
  int? id;
  String? kecamatan_kode;
  String? kelurahan_kode;
  String? nama;
  String? status;

  factory DataKelurahan.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}