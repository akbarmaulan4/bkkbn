
part of 'data_provinsi.dart';

DataProvinsi _$fromJson(Map<String, dynamic> json) {
  return DataProvinsi()
    ..id = json['id'] as int ?? -1
    ..nama = json['nama'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DataProvinsi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama
    };