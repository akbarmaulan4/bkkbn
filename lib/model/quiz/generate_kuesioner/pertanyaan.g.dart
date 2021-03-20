part of 'pertanyaan.dart';
Pertanyaan _$fromJson(Map<String, dynamic> json) {
  return Pertanyaan()
    ..kuis_id = json['kuis_id'] as String ?? ''
    ..header_id = json['header_id'] as String ?? ''
    ..pertanyaan_id = json['pertanyaan_id'] != null ? json['pertanyaan_id'] is num ? (json['pertanyaan_id'] as num)?.toInt() ?? 0: int.tryParse(json['pertanyaan_id'] as String) ?? -1: -1
    ..title = json['title'] as String ?? ''
    ..tipe = json['tipe'] as String ?? ''
    ..api = json['api'] as String ?? ''
    ..params = json['params'] as String ?? ''
    ..file_name = json['file_name'] as String ?? ''
    ..element =  (json['element'] as List)
        ?.map((e) =>
    e == null ? null : ListAnswer.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(Pertanyaan instance) =>
    <String, dynamic>{
      'kuis_id': instance.kuis_id,
      'header_id': instance.header_id,
      'pertanyaan_id': instance.pertanyaan_id,
      'title': instance.title,
      'tipe': instance.tipe,
      'api': instance.api,
      'params': instance.params,
      'file_name': instance.file_name,
      'element': instance.element
    };