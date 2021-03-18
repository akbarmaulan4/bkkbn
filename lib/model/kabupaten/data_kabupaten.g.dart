
part of 'data_kabupaten.dart';

DataKabupaten _$fromJson(Map<String, dynamic> json) {
  return DataKabupaten()
    ..id = json['id'] as int ?? -1
    ..provinsi_id = json['provinsi_id'] as String ?? ''
    ..nama = json['nama'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DataKabupaten instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provinsi_id': instance.provinsi_id,
      'nama': instance.nama
    };