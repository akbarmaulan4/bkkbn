part of 'data_kelurahan.dart';
DataKelurahan _$fromJson(Map<String, dynamic> json) {
  return DataKelurahan()
    ..id = json['id'] as int ?? -1
    ..kecamatan_id = json['kecamatan_id'] as String ?? ''
    ..nama = json['nama'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DataKelurahan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kecamatan_id': instance.kecamatan_id,
      'nama': instance.nama
    };