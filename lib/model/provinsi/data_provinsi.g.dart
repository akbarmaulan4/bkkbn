
part of 'data_provinsi.dart';

DataProvinsi _$fromJson(Map<String, dynamic> json) {
  return DataProvinsi()
    ..id = json['id'] as int
    ..provinsi_kode = json['provinsi_kode'] as String
    ..nama = json['nama'] as String
    ..status = json['status'] as String
  ;
}

Map<String, dynamic> _$toJson(DataProvinsi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provinsi_kode': instance.provinsi_kode,
      'status': instance.status,
      'nama': instance.nama
    };