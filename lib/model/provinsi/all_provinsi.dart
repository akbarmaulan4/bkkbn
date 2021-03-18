
import 'package:kua/model/provinsi/data_provinsi.dart';
part 'all_provinisi.g.dart';

class AllProvinsi{
  AllProvinsi(){}
  List<DataProvinsi> data;

  factory AllProvinsi.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}