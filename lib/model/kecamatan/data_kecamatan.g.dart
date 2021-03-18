
part of 'data_kecamatan.dart';

DataKecamatan _$fromJson(Map<String, dynamic> json) {
  return DataKecamatan()
    ..id = json['id'] as int ?? -1
    ..kabupaten_id = json['kabupaten_id'] as String ?? ''
    ..nama = json['nama'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DataKecamatan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kabupaten_id': instance.kabupaten_id,
      'nama': instance.nama
    };