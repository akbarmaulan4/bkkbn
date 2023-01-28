
part 'data_provinsi.g.dart';

class DataProvinsi{

  DataProvinsi(){}
  int? id;
  String? provinsi_kode;
  String? nama;
  String? status;

  factory DataProvinsi.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}