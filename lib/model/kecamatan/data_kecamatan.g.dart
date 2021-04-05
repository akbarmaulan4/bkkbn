
part of 'data_kecamatan.dart';

DataKecamatan _$fromJson(Map<String, dynamic> json) {
  return DataKecamatan()
    ..id = json['id'] as int ?? -1
    ..kabupaten_kode = json['kabupaten_id'] as String ?? ''
    ..kecamatan_kode = json['kecamatan_kode'] as String ?? ''
    ..nama = json['nama'] as String ?? ''
    ..status = json['status'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DataKecamatan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kabupaten_kode': instance.kabupaten_kode,
      'kecamatan_kode': instance.kecamatan_kode,
      'status': instance.status,
      'nama': instance.nama
    };