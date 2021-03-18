
part 'data_provinsi.g.dart';

class DataProvinsi{

  DataProvinsi(){}
  int id;
  String nama;

  factory DataProvinsi.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}