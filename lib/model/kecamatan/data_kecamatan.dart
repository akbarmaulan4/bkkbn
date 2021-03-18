part 'data_kecamatan.g.dart';

class DataKecamatan{
  DataKecamatan(){}
  int id;
  String kabupaten_id;
  String nama;

  factory DataKecamatan.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}