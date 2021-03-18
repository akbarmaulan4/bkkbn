part of 'group_quiz_submit.dart';
GroupQuizSubmit _$fromJson(Map<String, dynamic> json) {
  return GroupQuizSubmit()
    ..kuis_id = json['kuis_id'] as String ?? ''
    ..header_id = json['header_id'] as String ?? ''
    ..jenis = json['jenis'] as String ?? ''
    ..pertanyaan =  (json['pertanyaan'] as List)
        ?.map((e) =>
    e == null ? null : PertanyaanSubmit.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(GroupQuizSubmit instance) =>
    <String, dynamic>{
      'kuis_id': instance.kuis_id,
      'header_id': instance.header_id,
      'jenis': instance.jenis,
      'pertanyaan': instance.pertanyaan
    };