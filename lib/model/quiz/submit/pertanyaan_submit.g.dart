part of 'pertanyaan_submit.dart';
PertanyaanSubmit _$fromJson(Map<String, dynamic> json) {
  return PertanyaanSubmit()
    ..kuis_id = json['kuis_id'] as String ?? ''
    ..header_id = json['header_id'] as String ?? ''
    ..pertanyaan_id = json['pertanyaan_id'] != null ? json['pertanyaan_id'] is num ? (json['pertanyaan_id'] as num)?.toInt() ?? 0: int.tryParse(json['pertanyaan_id'] as String) ?? -1: -1
    ..tipe = json['tipe'] as String ?? ''
    ..value = json['value'] as String ?? ''
    ..file_name = json['file_name'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(PertanyaanSubmit instance) =>
    <String, dynamic>{
      'kuis_id': instance.kuis_id,
      'header_id': instance.header_id,
      'pertanyaan_id': instance.pertanyaan_id,
      'tipe': instance.tipe,
      'value': instance.value,
      'file_name': instance.file_name,
    };