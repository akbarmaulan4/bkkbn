
part of 'data_kabupaten.dart';

DataKabupaten _$fromJson(Map<String, dynamic> json) {
  return DataKabupaten()
    ..id = json['id'] as int
    ..provinsi_kode = json['provinsi_kode'] as String
    ..kabupaten_kode = json['kabupaten_kode'] as String
    ..nama = json['nama'] as String
    ..status = json['status'] as String
  ;
}

Map<String, dynamic> _$toJson(DataKabupaten instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provinsi_kode': instance.provinsi_kode,
      'kabupaten_kode': instance.kabupaten_kode,
      'status': instance.status,
      'nama': instance.nama
    };