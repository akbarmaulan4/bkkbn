part of 'data_kelurahan.dart';
DataKelurahan _$fromJson(Map<String, dynamic> json) {
  return DataKelurahan()
    ..id = json['id'] as int ?? -1
    ..kecamatan_kode = json['kecamatan_kode'] as String ?? ''
    ..kelurahan_kode = json['kelurahan_kode'] as String ?? ''
    ..nama = json['nama'] as String ?? ''
    ..status = json['status'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DataKelurahan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kelurahan_kode': instance.kelurahan_kode,
      'kecamatan_kode': instance.kecamatan_kode,
      'status': instance.status,
      'nama': instance.nama
    };