part 'data_kelurahan.g.dart';
class DataKelurahan{
  DataKelurahan(){}
  int id;
  String kecamatan_id;
  String nama;

  factory DataKelurahan.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}